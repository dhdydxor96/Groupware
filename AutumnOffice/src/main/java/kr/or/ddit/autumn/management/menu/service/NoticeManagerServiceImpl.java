package kr.or.ddit.autumn.management.menu.service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.management.menu.dao.NoticeManagerAttatchDAO;
import kr.or.ddit.autumn.management.menu.dao.NoticeManagerDAO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class NoticeManagerServiceImpl implements NoticeManagerService {

	private final NoticeManagerDAO notiManagerDAO;
	private final NoticeManagerAttatchDAO attatchDAO;
	
	@Inject
	private FtpUtil ftpUtil; 
	
	@Value("#{ftpInfo.savePath}")
	private String savePath;
	
	private int processAttatchList(NoticeVO notice) {
		int rowcnt = 0;
		List<AttatchVO> attatchList = notice.getAttatchList();
		if(attatchList!=null && !attatchList.isEmpty()) {
			rowcnt = attatchDAO.insertAttatches(notice);
			for(AttatchVO attatch : attatchList) {
				ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee());
			}
		}
		return rowcnt;
	}
	
	@Override
	public ServiceResult createNoticeBymanager(NoticeVO notice) {
		int rowcnt = notiManagerDAO.insertNotice(notice);
		rowcnt += processAttatchList(notice);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public NoticeVO retrieveNotice(int nocNo) {
		notiManagerDAO.incrementNoHit(nocNo);
		NoticeVO notice = notiManagerDAO.selectNotice(nocNo);
		if(notice == null)
			throw new RuntimeException(String.format("%d 글번호의 글이 없음.", nocNo));
		return notice;
	}
	
	@Override
	public NoticeVO retrieveNoticeForEdit(int nocNo) {
		NoticeVO notice = notiManagerDAO.selectNotice(nocNo);
		if(notice == null)
			throw new RuntimeException(String.format("%d 글번호의 글이 없음.", nocNo));
		return notice;
	}

	@Override
	public List<NoticeVO> retrieveNoticeList(PagingVO<NoticeVO> paging) {
		return notiManagerDAO.selectNoticeList(paging);
	}

	@Override
	public int retrieveNoticeCount(PagingVO<NoticeVO> paging) {
		log.info("@@@@@@@@@@@@  3333333  pagingVO.getCom : " + paging);
		return notiManagerDAO.selectTotalRecord(paging);
	}
	
	private int processDeleteAttatch(NoticeVO notice) {
		int[] delAttNos = notice.getDelAttNos();
		if(delAttNos==null || delAttNos.length==0) return 0;
		Arrays.sort(delAttNos);
		List<AttatchVO> attatchList = notiManagerDAO.selectNotice(notice.getNocNo()).getAttatchList();
		List<String> saveNames = attatchList.stream()
				.filter(attatch->{
					return Arrays.binarySearch(delAttNos, attatch.getAttNo()) >= 0;
				}).map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		int rowcnt = attatchDAO.deleteAttatches(delAttNos);
		
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				ftpUtil.removeFile(savePath, attSavename);
			}
		}
		return rowcnt;
	}
	
	private int processDeleteAttatches(NoticeVO notice) {
		List<AttatchVO> attatchList = notiManagerDAO.selectAttatchList(notice);
		
		if(attatchList==null || attatchList.isEmpty()) return 0;
		
		List<String> saveNames = attatchList.stream()
				.map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		int rowcnt = 0;
		rowcnt = attatchDAO.deleteAttatch(notice.getNocNo());
		
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				ftpUtil.removeFile(savePath, attSavename);
			}
		}
		return rowcnt;
	}

	private int processDeleteAttes(int nocNo) {
		List<AttatchVO> attatchList = notiManagerDAO.selectAttList(nocNo);
		
		if(attatchList==null || attatchList.isEmpty()) return 0;
		
		List<String> saveNames = attatchList.stream()
				.map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		int rowcnt = 0;
		rowcnt = attatchDAO.deleteAttatch(nocNo);
		
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				ftpUtil.removeFile(savePath, attSavename);
			}
		}
		return rowcnt;
	}
	
	@Transactional
	@Override
	public ServiceResult modifyNotice(NoticeVO notice) {
		ServiceResult result = null;
		int rowcnt = notiManagerDAO.updateNotice(notice);
		rowcnt += processAttatchList(notice);
		processDeleteAttatch(notice);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Transactional
	@Override
	public ServiceResult removeNotice(NoticeVO notice) {
		ServiceResult result = null;
			processDeleteAttatches(notice);
			int rowcnt = notiManagerDAO.deleteNotice(notice);
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Transactional
	@Override
	public ServiceResult removeNotices(int nocNos) {
		ServiceResult result = null;
		processDeleteAttes(nocNos);
		int rowcnt = notiManagerDAO.deleteNot(nocNos);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public AttatchVO retrieveAttatch(int attNo) {
		AttatchVO attatch = attatchDAO.selectAttatch(attNo);
		if(attatch == null)
			throw new RuntimeException("해당 파일 없음.");
		return attatch;
	}

}
