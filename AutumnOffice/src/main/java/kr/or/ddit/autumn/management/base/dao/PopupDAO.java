package kr.or.ddit.autumn.management.base.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.PopUpVO;

@Mapper
public interface PopupDAO {
	
	/** 등록되어 있는 팝업 번호를 조회
	 * @param popup
	 * @return	popupNo의 List{항상 하나밖에 없음(등록하기 전에 기존것을 삭제하기 때문에...)}
	 */
	public List<Integer> searchPopupNo(PopUpVO popup);
	
	/**	등록되어 있는 첨부파일정보 조회 
	 * @param popup
	 * @return attatchVO 첨부파일 또한 하나밖에 없음(하나밖에 등록을 못하기 때문)
	 */
	public AttatchVO retrieveChildAttatch(PopUpVO popup);
	
	/**	등록되어 있는 팝업을 삭제
	 * @param popup
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deletePopup(PopUpVO popup);
	
	/**	입력한 팝업 공지를 DB에 등록
	 * @param popup
	 * @return	성공 : 1, 실패 : 0
	 */
	public int insertPopup(PopUpVO popup);
	
	public PopUpVO retrievePopup(PopUpVO popup);

	public int updatePopupSta(PopUpVO popup);
}
