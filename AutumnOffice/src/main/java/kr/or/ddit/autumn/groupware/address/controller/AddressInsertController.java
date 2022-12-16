package kr.or.ddit.autumn.groupware.address.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AddressInsertController {
	
	@RequestMapping("/groupware/address/addressForm.do")
	public String addressForm() {
		return "groupware/address/addressForm";
	}

}