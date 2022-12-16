package kr.or.ddit.autumn.groupware.address.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.groupware.address.vo.AddressVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface AddressDAO {
	
	/**
	 * 페이징 처리를 위한 총 레코드 수
	 * @param pagingVO
	 * @return
	 */
	public int totalRecode(PagingVO<AddressVO> pagingVO); 

	/**
	 * 주소록 리스트 조회
	 * @param pagingVO
	 * @return
	 */
	public List<AddressVO> addressList(PagingVO<AddressVO> pagingVO);
}
