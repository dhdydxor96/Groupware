package kr.or.ddit.autumn.management.base.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.management.base.dao.LogoManageDAO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class LogoManageServiceImpl implements LogoManageService {

	private final LogoManageDAO dao;
	
	@Inject
	private FtpUtil ftpUtil; 
	
	@Value("#{ftpInfo.savePath}")
	private String savePath;

	// ================================
	// * 파일 등록
	// ================================
	private int processAttatch(CompanyVO companyVO) {
		int rowcnt = 0;

		List<AttatchVO> attatchList = companyVO.getAttatchList();
		AttatchVO attatchVO = new AttatchVO();

		log.info("ServiceImpl에서 attatchList 정보값 {}", companyVO.getAttatchList());

		if (attatchList != null && !attatchList.isEmpty()) {

			attatchVO.setComCode(companyVO.getComCode());
			attatchVO.setAttFnm(companyVO.getAttatchList().get(0).getAttFnm());
			attatchVO.setAttSnm(companyVO.getAttatchList().get(0).getAttSnm());
			attatchVO.setAttMime(companyVO.getAttatchList().get(0).getAttMime());
			attatchVO.setAttFis(companyVO.getAttatchList().get(0).getAttFis());
			attatchVO.setAttFas(companyVO.getAttatchList().get(0).getAttFas());

			rowcnt = dao.insertLogoImage(attatchVO);

			for (AttatchVO attatch : attatchList) {
				ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee());
				log.info("파일 저장 경로 : {}", savePath);
			}
		}
		return rowcnt;
	}

	// ================================
	// * 파일 삭제
	// ================================
	private int processDeleteAttatches(CompanyVO companyVO) {
		AttatchVO attatchVO = dao.selectCompanyAttatchInfo(companyVO.getComCode());

		if (attatchVO == null)
			return 0;

		String saveName = attatchVO.getAttSnm();

		int rowcnt = 0;

		rowcnt = dao.deleteLogoImage(companyVO.getComCode());

		if (!saveName.isEmpty()) {
			File deleteFile = new File(savePath, saveName);
			FileUtils.deleteQuietly(deleteFile);
		}
		return rowcnt;
	}

	@Transactional
	@Override
	public ServiceResult updateLogoImage(CompanyVO companyVO) {

		ServiceResult result = null;

		int rowcnt = 0;

		rowcnt += processDeleteAttatches(companyVO);
		rowcnt += processAttatch(companyVO);

		if (rowcnt >= 1) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}

		return result;
	}

	@Override
	public AttatchVO retrieveLogoImage(String comCode) {
		return dao.selectCompanyAttatchInfo(comCode);
	}

}
