package kr.or.ddit.autumn.groupware.mail.controller;

import java.util.Arrays;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.mail.service.MailService;
import kr.or.ddit.autumn.groupware.mail.service.SendMailService;
import kr.or.ddit.autumn.vo.SendMailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/mail")
public class MailInsertController {
	
	
	@Inject
	private MailService mailService;
	@Inject
	private SendMailService sendMailService;
	
	
	// 메일작성뷰
	@GetMapping("/mailInsert.do")
	public String mailWriteUI(@RequestParam(value="check", required = false) String check
							 ,@RequestParam(value="toAddress", required = false) String toAddress
							 ,HttpServletRequest request
							 ,Model model) {
		HttpSession session = request.getSession();
		if(!StringUtils.isNotBlank(check)){
			session.removeAttribute("toAddresses");
		}
		if(StringUtils.isNotBlank(toAddress)){
			model.addAttribute("toAddress", toAddress);
		}
		
		return "groupware/mail/mailWrite";
	}
	
	// 체크박스메일작성뷰
	@GetMapping("/mailCheckBoxInsert.do")
	@ResponseBody
	public String mailCheckBoxWriteUI(@RequestParam(value="toAddresses[]",required = false) String [] toAddresses 
							   ,HttpServletRequest request
							   ,Model model) {
			
		if(toAddresses!=null) {
			HttpSession session = request.getSession();
			session.setAttribute("toAddresses", toAddresses);
		}
		return "OK";
	}
	
	



	//매일작성
	@PostMapping(value="/mailInsert.do")
	public String mailSend(SendMailVO sendMailVO 
						  ,String nickName
						  ,String [] toMails
						  ,Model model
						  ,Authentication authentication
						  ){
		
//		List<MultipartFile> files = sendMailVO.getFiles();
		String viewName = null;
		ServiceResult result = null;
		 boolean bool = false;
		 
    	EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		if(!StringUtils.isNotBlank(nickName)){
			nickName = adapter.getRealUser().getEmpNm();
		}
		sendMailVO.setEmpId(adapter.getRealUser().getEmpId());
		
		for(String toAddress : toMails) {

		sendMailVO.setToAddress(toAddress);
	  //smtp보내기
	  bool = mailService.mailSend(sendMailVO,nickName,adapter.getRealUser().getEmpMail(), adapter.getRealUser().getEmpMpass());
	  
	  }
	  //DB저장
	  if(bool) {
	  result = sendMailService.createSendMailVO(toMails,sendMailVO);
	  }
	  System.out.println(bool);
		if(ServiceResult.OK.equals(result)||bool) {
			
			model.addAttribute("word1", "Success");
			model.addAttribute("word2", "메일을 성공적으로 보냈습니다.");
			model.addAttribute("word3", "발송한 메일들은 보낸메일함에 저장되었습니다!");
			viewName = "groupware/mail/mailSuccess";
			
		}else {
			
			model.addAttribute("word1", "Failed");
			model.addAttribute("word2", "메일 전송에 실패한 메일이 있습니다.");
			model.addAttribute("word3", "받는 사람의 메일 주소가 정확한지와 현재 사용하고 있는 주소가 맞는지 다시 확인하고 발송해 보세요.");
			viewName = "groupware/mail/mailSuccess";
		}
	  
		return viewName;
	}
	

}