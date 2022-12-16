package kr.or.ddit.autumn.management.base.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.management.base.dao.PopupAttatchDAO;
import kr.or.ddit.autumn.management.base.dao.PopupDAO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.PopUpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PopupManageServiceImpl implements PopupManageService {

	@Inject
	private PopupDAO popupDAO;
	@Inject
	private PopupAttatchDAO attatchDAO;
	
	@Inject
	private FtpUtil ftpUtil; 
	
	@Value("#{ftpInfo.savePath}")
	private String savePath;
	
	@Transactional
	@Override
	public ServiceResult creatPopup(PopUpVO popup) {		
		int rowcnt = 0;
		
		
		AttatchVO newAttatch = new AttatchVO();
		
		if(popup.getAttatch() != null ) {
			log.info("@@@@@@@@@@@@@@@@@@@@ 새로운 Attatch 파일 확인"+popup.getAttatch().toString()+"@@@@@@@@@@@@@@");
			// 새로 저장할 팝업 첨부파일 
			newAttatch = popup.getAttatch();
		}
		
		// 로그인한 회사 기존에 존재하는 popup_no를 조회해옴
		// SELECT POPUP_NO FROM POPUP WHERE COM_CODE = 'a001'
		// comCode를 통해 해당 회사의 팝업 공지 번호 조회해서 리스트로 담음
		// 하나 등록하는 순간 하나를 삭제하므로 하나밖에 없으나 컴퓨터는 1개라고 인식을 못하기 때문에 List로 담아줌.
		// 리스트로 담긴 해당 회사의 번호를 하나씩 빼서 attatchVO에 popupNo를 설정해줌. 
		List<Integer> popupNoList = popupDAO.searchPopupNo(popup);
		log.info("@@@@@@@@@@@@@@@@@@@@ 검색해온 popupNo 확인" + popupNoList.toString() +"@@@@@@@@@@@@@@");
		if(popupNoList!=null && !popupNoList.isEmpty()) {
			for(Integer popupNo : popupNoList) {
				// 가져온 popupNo를 popupVO에 넣어주고
				popup.setPopupNo(popupNo);
				// 그 popupNo에 있는 첨부파일을 조회해서 popupVO에 Attatch에 담아준다
				retrieveChildAttatch(popup);
				log.info("@@@@@@@@@@@@@@@@@@@@ popupNo의 Attatch 파일 확인" + popup.getAttatch() +"@@@@@@@@@@@@@@");
				// 담겨있는 popupVO attatch(첨부파일정보)를 AttatchVO를 생성해서 담아준다.
				AttatchVO attatch = popup.getAttatch();
				// attatch가 담겨 있으면
				if(attatch != null) {
					// 첨부파일 삭제
					rowcnt = deleteAttatch(popup);
					if(rowcnt == 0) return ServiceResult.FAIL;
					
					//첨부파일을 삭제 했으므로 popupVO 삭제 가능 삭제 진행!
					rowcnt += deletePopup(popup);
					if(rowcnt == 1) return ServiceResult.FAIL;
				}else {
					rowcnt = deletePopup(popup);
					if(rowcnt == 1) return ServiceResult.FAIL;
				}
				
			}
		}
		if(newAttatch.getAttSnm() != null && !newAttatch.getAttSnm().isEmpty()) {
			System.out.println("@@@@@@@@@@@@ 맨처음에 저장해 두었던 번호와 첨부파일 확인 @@@@@@@@@");
			// 맨처음에 저장해 두었던 번호와 첨부파일 다시 셋팅후
			// 입력받은 popup 제목, 내용 및 첨부파일 추가
			popup.setAttatch(newAttatch);
			rowcnt += popupDAO.insertPopup(popup);
			rowcnt += processAttatch(popup);
		}else {
			System.out.println("@@@@@@@@@@@@ 맨처음에 저장해 두었던 번호와 첨부파일 확인 @@@@@@@@@");
			rowcnt += popupDAO.insertPopup(popup);
		}
		
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	// 팝업 제목, 내용 등록 후 팝업 이미지 첨부파일 등록 프로세스
	private int processAttatch(PopUpVO popup) {
		int rowcnt = 0;
		AttatchVO attatch = popup.getAttatch();
		attatch.setPopupNo(popup.getPopupNo());
		if(attatch!=null) {
			rowcnt = attatchDAO.insertAttatch(attatch);
			ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee());
		}
		return rowcnt;
	}
	
	
	private void retrieveChildAttatch(PopUpVO popup) {
		popup.setAttatch(popupDAO.retrieveChildAttatch(popup));
	}
	
	private int deleteAttatch(PopUpVO popupNo) {
		int rowcnt = attatchDAO.deletePopupAttatch(popupNo);
		return rowcnt;
	}
	
	private int deletePopup(PopUpVO popup) {
		int rowcnt = popupDAO.deletePopup(popup);
		return rowcnt;
	}

	//	팝업 공지를 띄울 수 있도록 comCode를 통해 popup_no를 조회한 후 popup_no와 com_Code를 통해 attatchVO 조회
	@Override
	public AttatchVO retrieveAttatch(String comCode) {
		log.info("@@@@@@@@@@@@@ 왔는지 확인 @@@@@@@@@@@@@@");
		AttatchVO attatch = new AttatchVO();
		attatch.setComCode(comCode);
		
		// comCode를 통해 해당 회사의 팝업 공지 번호 조회해서 리스트로 담음
		// 하나 등록하는 순간 하나를 삭제하므로 하나밖에 없으나 컴퓨터는 1개라고 인식을 못하기 때문에 List로 담아줌.
		List<Integer> popUpNo = attatchDAO.selectpopupNo(attatch);
		
		// 리스트로 담긴 해당 회사의 번호를 하나씩 빼서 attatchVO에 popupNo를 설정해줌. 
		for(Integer popupNo : popUpNo)
			if(popupNo != 0 && popupNo != null ) {
				attatch.setPopupNo(popupNo);
				log.info("attatch 확인 : " + attatch);
				log.info("retrieveAttatch 확인 : " + attatchDAO.retrieveAttatch(attatch));
				attatch = attatchDAO.retrieveAttatch(attatch);
			}
		return attatch;
	  }

	@Override
	public PopUpVO retrievePopup(PopUpVO popup) {
		List<Integer> popupNoList = popupDAO.searchPopupNo(popup);
		log.info("@@@@@@@ 111111111111111111 popupNoList 확인 : " + popupDAO.searchPopupNo(popup));
		if(popupNoList!=null && !popupNoList.isEmpty()) {
			for(Integer popupNo : popupNoList) {
				popup.setPopupNo(popupNo);
				popup = popupDAO.retrievePopup(popup);
				log.info("@@@@@@@ 22222222222222222 popup 확인 : " + popup);
			}
		}
		return popup;
	}

	@Override
	public ServiceResult modifyPopup(PopUpVO popup) {
		List<Integer> popupNoList = popupDAO.searchPopupNo(popup);
		popup.setPopupNo(popupNoList.get(0));

		log.info("popupSta : " + popup.getPopupSta());
		log.info("popupNo: " + popup.getPopupNo());
		int rowcnt = popupDAO.updatePopupSta(popup);
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@ 확인 4 ??????????????????" + popup);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
}
