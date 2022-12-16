package kr.or.ddit.autumn.management.base.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.PopUpVO;

@Mapper
public interface PopupAttatchDAO {
		
	public List<Integer> selectpopupNo(AttatchVO attatch);	

	/**	팝업공지를 등록할때 삽입한 이미지 첨부파일을 저장
	 * @param attatch
	 * @return	성공 : 1, 실패 : 0
	 */
	public int insertAttatch(AttatchVO attatch);
	
	/**	팝업 공지를 새로 등록했을 경우 기존 팝업 공지를 삭제
	 * @param popupNo
	 * @return	성공 : 1, 실패 : 0
	 */
	public int deletePopupAttatch(PopUpVO popup);

	public AttatchVO retrieveAttatch(AttatchVO attatch);
	
}
