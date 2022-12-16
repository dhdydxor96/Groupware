package kr.or.ddit.autumn.groupware.address.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.address.service.AddressService;
import kr.or.ddit.autumn.groupware.address.vo.AddressVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;

@RequestMapping("/groupware/address")
@RequiredArgsConstructor
@Controller
public class AddressListController {
	
	private final AddressService service;
	
	@RequestMapping("/addressList.do")
	public String addressList() {
		return "groupware/address/addressList";
	}
	
	@GetMapping(value="/addressList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<AddressVO> addressList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<AddressVO> pagingVO = new PagingVO<>(10,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setComcode(comCode);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = service.totalRecode(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<AddressVO> addressList = service.addressList(pagingVO);
		pagingVO.setDataList(addressList);
		
		return pagingVO;
				
	}
	
	
}
