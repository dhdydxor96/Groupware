package kr.or.ddit.autumn.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WebIndexController {
	
	@RequestMapping("/web/index.do")
	public String index() {
		System.out.println("ㅎㅎ");
		return "web/index";
	}
	
}
