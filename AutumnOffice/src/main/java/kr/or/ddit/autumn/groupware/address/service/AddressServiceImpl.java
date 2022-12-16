package kr.or.ddit.autumn.groupware.address.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.groupware.address.dao.AddressDAO;
import kr.or.ddit.autumn.groupware.address.vo.AddressVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Service
public class AddressServiceImpl implements AddressService {

	@Inject
	private AddressDAO dao;
	
	@Override
	public int totalRecode(PagingVO<AddressVO> pagingVO) {
		return dao.totalRecode(pagingVO);
	}

	@Override
	public List<AddressVO> addressList(PagingVO<AddressVO> pagingVO) {
		return dao.addressList(pagingVO);
	}

}
