package kr.or.ddit.autumn.groupware.address.service;

import java.util.List;

import kr.or.ddit.autumn.groupware.address.vo.AddressVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface AddressService {

	public int totalRecode(PagingVO<AddressVO> pagingVO);
	
	public List<AddressVO> addressList(PagingVO<AddressVO> pagingVO);
}
