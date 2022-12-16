package kr.or.ddit.autumn.web.advice.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.web.advice.dao.AdviceDAO;
import kr.or.ddit.autumn.web.advice.dao.AdviceAttatchDAO;
import kr.or.ddit.autumn.web.vo.AdviceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdviceServiceImpl implements AdviceService {
	private final AdviceDAO adviceDAO;
	private final AdviceAttatchDAO attatchDAO;
	
	@Inject
	private FtpUtil ftpUtil; 
	
	@Value("#{ftpInfo.savePath}")
	private String savePath;
	
	private int processAttatchList(AdviceVO advice) {
		int rowcnt = 0;
		List<AttatchVO> attatchList = advice.getAttatchList();
		if(attatchList!=null && !attatchList.isEmpty()) {
			rowcnt = attatchDAO.insertAttatches(advice);
			for(AttatchVO attatch : attatchList) {
				ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee());
				log.info("파일 저장 경로 : {}", savePath);
			}
		}
		return rowcnt;
	}

	@Override
	public ServiceResult createAdvice(AdviceVO advice) {
		int rowcnt = adviceDAO.insertAdvice(advice);
		rowcnt += processAttatchList(advice);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public AdviceVO retrieveAdvice(int advNo) {
		AdviceVO advice = adviceDAO.selectAdvice(advNo);
		if(advice == null)
			throw new RuntimeException(String.format("%d 글번호의 글이 없음.", advNo));
		return advice;
	}

	@Override
	public List<AdviceVO> retrieveAdviceList(PagingVO<AdviceVO> pagingVO) {
		return adviceDAO.selectAdviceList(pagingVO);
	}

	@Override
	public int retrieveAdviceCount(PagingVO<AdviceVO> pagingVO) {
		return adviceDAO.selectTotalRecord(pagingVO);
	}
	
	private boolean adviceAuthenticate(AdviceVO advice) {
		AdviceVO saved = retrieveAdvice(advice.getAdvNo());
		String inputPass = advice.getAdvPass();
		String savedPass = saved.getAdvPass();
		return savedPass.equals(inputPass);
	}
	
	@Transactional
	@Override
	public ServiceResult modifyAdvice(AdviceVO advice) {
		ServiceResult result = null;
		if(adviceAuthenticate(advice)) {
			int rowcnt = adviceDAO.updateAdvice(advice);
			rowcnt += processAttatchList(advice);
			processDeleteAttatch(advice);
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
			}else {
				result = ServiceResult.INVALIDPASSWORD;
			}
			return result;
		}
	
	private int processDeleteAttatch(AdviceVO advice) {
		int[] delAttNos = advice.getDelAttNos();
		if(delAttNos==null || delAttNos.length==0) return 0;
		Arrays.sort(delAttNos);
		List<AttatchVO> attatchList = adviceDAO.selectAdvice(advice.getAdvNo()).getAttatchList();
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
	
	private int processDeleteAttatches(AdviceVO advice) {
		List<AttatchVO> attatchList = adviceDAO.selectAdvice(advice.getAdvNo()).getAttatchList();
		
		if(attatchList==null || attatchList.isEmpty()) return 0;
		
		List<String> saveNames = attatchList.stream()
				.map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		int rowcnt = 0;
		rowcnt = attatchDAO.deleteAttatch(advice.getAdvNo());
		
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
	public ServiceResult removeAdvice(AdviceVO advice) {
		ServiceResult result = null;
		if(adviceAuthenticate(advice)) {
			processDeleteAttatches(advice);
			int rowcnt = adviceDAO.deleteAdvice(advice);
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
