package kr.or.ddit.autumn.web.matters.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.hibernate.validator.constraints.Mod11Check.ProcessingDirection;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.web.matters.dao.MattersAttatchDAO;
import kr.or.ddit.autumn.web.matters.dao.MattersDAO;
import kr.or.ddit.autumn.web.matters.dao.MattersReplyDAO;
import kr.or.ddit.autumn.web.vo.MattersReplyVO;
import kr.or.ddit.autumn.web.vo.MattersVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MattersServiceImpl implements MattersService {
	private final MattersDAO mattersDAO;
	private final MattersAttatchDAO attatchDAO;
	
	@Inject
	private FtpUtil ftpUtil; 
	
	@Value("#{ftpInfo.savePath}")
	private String savePath;
	
	private int processAttatchList(MattersVO matters) {
		int rowcnt = 0;
		List<AttatchVO> attatchList = matters.getAttatchList();
		if(attatchList!=null && !attatchList.isEmpty()) {
			rowcnt = attatchDAO.insertAttatches(matters);
			for(AttatchVO attatch : attatchList) {
				ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee());
				log.info("파일 저장 경로 : {}", savePath);
			}
		}
		return rowcnt;
	}

	@Override
	public ServiceResult creaeteMatters(MattersVO matters) {
		int rowcnt = mattersDAO.insertMatters(matters);
		rowcnt += processAttatchList(matters);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public MattersVO retrieveMatters(int matNo) {
		MattersVO matters = mattersDAO.selectMatters(matNo);
		if(matters==null)
			throw new RuntimeException(String.format("%d 글번호의 글이 없음.", matNo));
		return matters;
	}

	@Override
	public List<MattersVO> retrieveMattersList(PagingVO<MattersVO> pagingVO) {
		return mattersDAO.selectmattersList(pagingVO);
	}

	@Override
	public int retrieveMattersCount(PagingVO<MattersVO> pagingVO) {
		return mattersDAO.selectTotalRecord(pagingVO);
	}
	
	private boolean mattersAuthenticate(MattersVO matters) {
		MattersVO saved = retrieveMatters(matters.getMatNo());
		String inputPass = matters.getMatPass();
		String savedPass = saved.getMatPass();
		return savedPass.equals(inputPass);
	}
	
	@Transactional
	@Override
	public ServiceResult modifyMatters(MattersVO matters) {
		ServiceResult result = null;
		if(mattersAuthenticate(matters)) {
			int rowcnt = mattersDAO.updateMatters(matters);
			rowcnt += processAttatchList(matters);
			processDeleteAttatch(matters);
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		}else {
			result = ServiceResult.INVALIDPASSWORD;
		}
		return result;
	}
	
	private int processDeleteAttatch(MattersVO matters) {
		int[] delAttNos = matters.getDelAttNos();
		if(delAttNos==null || delAttNos.length==0) return 0;
		Arrays.sort(delAttNos);
		List<AttatchVO> attatchList = mattersDAO.selectMatters(matters.getMatNo()).getAttatchList();
		List<String> saveNames = attatchList.stream()
				.filter(attatch->{
					return Arrays.binarySearch(delAttNos, attatch.getAttNo()) >= 0;
				}).map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		int rowcnt = attatchDAO.deleteAttatches(delAttNos);
		
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				File deleteFile = new File(savePath, attSavename);
				FileUtils.deleteQuietly(deleteFile);
			}
		}
		return rowcnt;
	}
	
	private int processDeleteAttatches(MattersVO matters) {
		List<AttatchVO> attatchList = mattersDAO.selectMatters(matters.getMatNo()).getAttatchList();
		
		if(attatchList==null || attatchList.isEmpty()) return 0;
		
		List<String> saveNames = attatchList.stream()
				.map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		int rowcnt = 0;
		rowcnt = attatchDAO.deleteAttatch(matters.getMatNo());
		
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				File deleteFile = new File(savePath, attSavename);
				FileUtils.deleteQuietly(deleteFile);
			}
		}
		return rowcnt;
	}
	

	@Transactional
	@Override
	public ServiceResult removeMatters(MattersVO matters) {
		ServiceResult result = null;
		if(mattersAuthenticate(matters)) {
			processDeleteAttatches(matters);
			int rowcnt = mattersDAO.deleteMatters(matters);
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		}else {
			result = ServiceResult.INVALIDPASSWORD;
		}
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
