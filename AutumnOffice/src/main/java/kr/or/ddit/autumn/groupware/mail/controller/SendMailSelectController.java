package kr.or.ddit.autumn.groupware.mail.controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

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
import kr.or.ddit.autumn.groupware.mail.service.SendMailService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.SendMailVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/mail")
public class SendMailSelectController {
	

	@Inject
	private SendMailService sendMailService;


	// 보낸메일함뷰
	@GetMapping("/mailForwardList.do")
	public String mailForwardListUI(Model model) {
		model.addAttribute("mail", "보낸메일함");
		return "groupware/mail/mailSendList";
	}


	// 보낸메일함데이터
	@GetMapping(value="/mailForwardList.do" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<SendMailVO> mailForwardList(
			  @RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, Authentication authentication
			) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		
		
		
		PagingVO<SendMailVO> pagingVO = new PagingVO<>(10,3);
		pagingVO.setEmpId(adapter.getRealUser().getEmpId());
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = sendMailService.retrieveSendMailCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<SendMailVO> mailList = sendMailService.retrieveSendMailList(pagingVO);
		pagingVO.setDataList(mailList);
		log.info("========================!!!!!!!!!!!mailList {}",mailList);
		return pagingVO;
		
	}
	
	
	@GetMapping("/mailForwardDetail.do")
	public String mailDetailUI(Model model,
			   @RequestParam("mailNo") Integer mailNo) {
		model.addAttribute("mail", "보낸메일함");
		model.addAttribute("mailNo", mailNo);
		return "groupware/mail/mailSendDetail";
	}
	
	
	@RequestMapping(value="mailForwardDetail.do"
			, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public SendMailVO sendMailView(@RequestParam("mailNo") Integer mailNo) {
	SendMailVO sendMailVO = sendMailService.retrieveSendMail(mailNo);
	System.out.println(sendMailVO.getAttatchList());
	return sendMailVO;
	}
	
	
	@RequestMapping("/mailDownload.do")
	public String download(@RequestParam(name="what", required=true) int attNo
			, Model model) throws IOException {
		AttatchVO attatch = sendMailService.retrieveAttatch(attNo);
		model.addAttribute("attatch", attatch);
		 return "downloadView";
	 
		
	}
	
	
	@GetMapping(value="mailForwardNextPage.do"
			, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<SendMailVO> sendMailNextPage(Authentication authentication) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		
		List<SendMailVO> mailList = sendMailService.noPageRetrieveSendMailList(adapter.getRealUser().getEmpId());
	return mailList;
	}

}