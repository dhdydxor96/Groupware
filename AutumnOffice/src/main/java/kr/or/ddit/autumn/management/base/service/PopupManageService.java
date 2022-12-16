package kr.or.ddit.autumn.management.base.service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.PopUpVO;

public interface PopupManageService {
	/**	팝업 공지를 만들어 줌
	 * @param popup
	 * @return 성공 : OK, 실패 : FAIL
	 */
	public ServiceResult creatPopup(PopUpVO popup);
	
	/** 이 회사에 등록되어 있는 팝업 공지 이미지를 조회
	 * @param comCode
	 * @return	attatchVO
	 */
	public AttatchVO retrieveAttatch(String comCode);

	/**	회사 코드를 통해 등록한 팝업 공지의 제목, 내용을 조회
	 * @return	popupVO
	 */
	public PopUpVO retrievePopup(PopUpVO popup);

	/** 팝업 공지의 활성화 상태를 변경
	 * @param popup
	 * @return 성공 : OK, 실패 : FAIL
	 */
	public ServiceResult modifyPopup(PopUpVO popup);
}
