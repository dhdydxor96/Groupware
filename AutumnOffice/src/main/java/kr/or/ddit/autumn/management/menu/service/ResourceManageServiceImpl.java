package kr.or.ddit.autumn.management.menu.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.groupware.resource.vo.ResourceInfoVO;
import kr.or.ddit.autumn.management.menu.dao.ResourceManageDAO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.MeetInfoVO;
import kr.or.ddit.autumn.vo.MeetRoomVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ResourceManageServiceImpl implements ResourceManageService {

	private final ResourceManageDAO dao;
	
	@Inject
	private FtpUtil ftpUtil; 
	
	@Value("#{ftpInfo.savePath}")
	private String savePath;

	// 파일 등록
	private int processAttatch(ResourceInfoVO resourceInfoVO) {
		int rowcnt = 0;

		List<AttatchVO> attatchList = resourceInfoVO.getAttatchList();
		AttatchVO attatchVO = new AttatchVO();

		log.info("ServiceImpl에서 attatchList 정보값 {}", resourceInfoVO.getAttatchList());

		if (attatchList != null && !attatchList.isEmpty()) {

			attatchVO.setMeetNo(resourceInfoVO.getMeetNo());
			attatchVO.setAttFnm(resourceInfoVO.getAttatchList().get(0).getAttFnm());
			attatchVO.setAttSnm(resourceInfoVO.getAttatchList().get(0).getAttSnm());
			attatchVO.setAttMime(resourceInfoVO.getAttatchList().get(0).getAttMime());
			attatchVO.setAttFis(resourceInfoVO.getAttatchList().get(0).getAttFis());
			attatchVO.setAttFas(resourceInfoVO.getAttatchList().get(0).getAttFas());

			rowcnt = dao.insertMeetRoomImage(attatchVO);

			for (AttatchVO attatch : attatchList) {
				ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee());
				log.info("파일 저장 경로 : {}", savePath);
			}
		}
		return rowcnt;
	}
	
	// 파일 삭제
		private int processDeleteAttatches(int meetNo) {
			
			AttatchVO attatchVO = dao.selectMeetRoomImage(meetNo);

			if (attatchVO == null)
				return 0;

			String saveName = attatchVO.getAttSnm();

			int rowcnt = 0;

			rowcnt = dao.deleteMeetRoomImage(meetNo);

			if (!saveName.isEmpty()) {
				ftpUtil.removeFile(savePath, saveName);
			}
			return rowcnt;
		}
	
	
	@Override
	public List<MeetRoomVO> retrieveMeetRoomList(PagingVO pagingVO) {
		return dao.selectMeetRoomList(pagingVO);
	}

	@Override
	public int selectTotalCount(PagingVO pagingVO) {
		return dao.selectTotalCount(pagingVO);
	}

	@Transactional
	@Override
	public ServiceResult createMeetRoom(ResourceInfoVO meetInfo) {
		ServiceResult result = null;
		
		// 1. 회의실 등록하기
		MeetRoomVO meetRoom = new MeetRoomVO();
		
		meetRoom.setComCode(meetInfo.getComCode());
		meetRoom.setMeetNm(meetInfo.getMeetNm());
		int rowcnt =  dao.insertMeetRoom(meetRoom);
		
		// 1-1. 생성된 회의실의 MEET_NO 받아오기
		int meetNo = dao.selectMeetRoomNo(meetInfo);

		meetInfo.setMeetNo(meetNo);
		
		log.info("회의실 등록 이후 VO 값 {}", meetInfo);
		
		// 2. 회의실 상세정보 등록하기
		rowcnt += dao.insertMeetInfo(meetInfo);
		
		// 3. 회의실 이미지 등록하기
		rowcnt += processAttatch(meetInfo);
		
		if(rowcnt>=3) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	@Transactional
	@Override
	public ServiceResult removeMeetRoom(int meetNo) {
		ServiceResult result = null;
		int rowcnt = 0;

		// 1. 회의실 이미지 삭제
		rowcnt += processDeleteAttatches(meetNo);
		
		// 2. 예약 현황 있는지 확인
		int reserCnt =  dao.selectMeetReser(meetNo);
		
		if(reserCnt>=1) {
			// 2-1. 예약 현황이 존재한다면 삭제
			rowcnt += dao.deleteMeetReser(meetNo);
		}
		
		// 3. 회의실 상세 정보 삭제
		rowcnt += dao.deleteMeetInfo(meetNo);
		
		// 4. 회의실 삭제
		rowcnt +=  dao.deleteMeetRoom(meetNo);
		
		if(rowcnt>=3) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	
	@Override
	public ResourceInfoVO retrieveMeetInfo(int meetNo) {
		return dao.selectMeetInfo(meetNo);
	}

	@Transactional
	@Override
	public ServiceResult updateMeetInfo(ResourceInfoVO meetInfo) {
		ServiceResult result = null;
		
		// 1. 회의실 수정하기
		MeetRoomVO meetRoom = new MeetRoomVO();
		
		meetRoom.setComCode(meetInfo.getComCode());
		meetRoom.setMeetNm(meetInfo.getMeetNm());
		meetRoom.setMeetNo(meetInfo.getMeetNo());
		int rowcnt =  dao.updateMeetRoom(meetRoom);
		
		// 2. 회의실 상세정보 수정하기
		rowcnt += dao.updateMeetInfo(meetInfo);
		
		// 3. 회의실 이미지 수정하기
		log.info("무슨정보가지고 있니 {}",meetInfo.getMeetFiles().get(0).getOriginalFilename()  );
		log.info("attatchList 비어있니 {}", StringUtils.isNotBlank(meetInfo.getMeetFiles().get(0).getOriginalFilename()));
		if(StringUtils.isNotBlank(meetInfo.getMeetFiles().get(0).getOriginalFilename())) {
			// attatch 값을 가지고 있다면
			rowcnt += processDeleteAttatches(meetInfo.getMeetNo());
			rowcnt += processAttatch(meetInfo);
		}
		
		
		if(rowcnt>=2) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	
}
