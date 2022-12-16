package kr.or.ddit.autumn.management.menu.service;

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
import kr.or.ddit.autumn.management.menu.dao.DocManageMenualAttatchDao;
import kr.or.ddit.autumn.management.menu.dao.DocManageMenualDao;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.RuleVO;
import kr.or.ddit.autumn.web.vo.MattersVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DocManageMenualServiceImpl implements DocManageMenualService {

	private final DocManageMenualDao docManageDao;
	private final DocManageMenualAttatchDao docManageAttatchDao;
	
	@Inject
	private FtpUtil ftpUtil; 
	
	@Value("#{ftpInfo.savePath}")
	private String savePath;
	
	private int processAttatchList(RuleVO rule) {
		int rowcnt = 0;
		List<AttatchVO> attatchList = rule.getAttatchList();
		if(attatchList!=null && !attatchList.isEmpty()) {
			rowcnt = docManageAttatchDao.insertAttatches(rule);
			for(AttatchVO attatch : attatchList) {
				ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee());
			}
		}
		return rowcnt;	
	}
	
	@Override
	public ServiceResult createRule(RuleVO rule) {
		int rowcnt = docManageDao.insertRule(rule);
		int selectRulNo = docManageAttatchDao.selectRulNo(rule.getComCode());
		rule.setRulNo(selectRulNo);
		rowcnt += processAttatchList(rule);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public RuleVO retrieveRule(int rulNo) {
		RuleVO rule = docManageDao.selectRule(rulNo);
		if(rule==null)
			throw new RuntimeException(String.format("%d 글번호의 글이 없음.", rulNo));		
		return rule;
	}

	@Override
	public List<RuleVO> retrieveRuleList(PagingVO<RuleVO> pagingVO) {
		return docManageDao.selectRuleList(pagingVO);
	}

	@Override
	public int retrieveRuleCount(PagingVO<RuleVO> pagingVO) {
		return docManageDao.selectTotalRecord(pagingVO);
	}

	@Transactional
	@Override
	public int modifyRule(RuleVO rule) {
		int rowcnt = docManageDao.updateRule(rule);
		rowcnt += processAttatchList(rule);
		processDeleteAttatch(rule);
		return rowcnt;
	}
	
	private int processDeleteAttatch(RuleVO rule) {
		int[] delAttNos = rule.getDelAttNos();
		if(delAttNos==null || delAttNos.length==0) return 0;
		Arrays.sort(delAttNos);
		List<AttatchVO> attatchList = docManageDao.selectRule(rule.getRulNo()).getAttatchList();
		List<String> saveNames = attatchList.stream()
				.filter(attatch->{
					return Arrays.binarySearch(delAttNos, attatch.getAttNo()) >= 0;
				}).map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		int rowcnt = docManageAttatchDao.deleteAttatches(delAttNos);
		
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				ftpUtil.removeFile(savePath, attSavename);
			}
		}
		return rowcnt;
	}
	
	private int processDeleteAttatches(RuleVO rule) {
		List<AttatchVO> attatchList = docManageDao.selectRule(rule.getRulNo()).getAttatchList();
		
		if(attatchList==null || attatchList.isEmpty()) return 0;
		
		List<String> saveNames = attatchList.stream()
				.map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		int rowcnt = 0;
		rowcnt = docManageAttatchDao.deleteAttatch(rule.getRulNo());
		
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				ftpUtil.removeFile(savePath, attSavename);
			}
		}
		return rowcnt;
	}
	
	@Transactional
	@Override
	public ServiceResult removeRule(RuleVO rule) {
		ServiceResult result = null;
		processDeleteAttatches(rule);
		int rowcnt = docManageDao.deleteRule(rule);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public AttatchVO retrieveAttatch(int attNo) {
		AttatchVO attatch = docManageAttatchDao.selectAttatch(attNo);
		if(attatch == null)
			throw new RuntimeException("해당 파일이 없음.");
		return attatch;
	}

}
