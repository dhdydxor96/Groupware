package kr.or.ddit.autumn.groupware.mail.controller;

import java.util.stream.Stream;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.mail.service.SendMailService;
import kr.or.ddit.autumn.vo.SendMailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/mail")
public class SendMailDeleteController {
	

	@Inject
	private SendMailService sendMailService;

		
		//디테일페이지에서 메일 한개 삭제
		@PostMapping(value="/sendMailDetailDelete.do")
		public String sendMailDetailDelete(@RequestParam("mailNo") Integer mailNo ){
			SendMailVO sendMailVO = sendMailService.retrieveSendMail(mailNo);
		    	ServiceResult result = sendMailService.removeSendMailVO(sendMailVO);
		      
		    	
	    return "redirect:/groupware/mail/mailForwardList.do";
		}
	
	
		//메일리스트에서 메일 한개 삭제
		@PostMapping(value="/sendMailDelete.do")
		@ResponseBody
		public ServiceResult sendMailDelete(@RequestParam("mailNo") Integer mailNo ){
			SendMailVO sendMailVO = sendMailService.retrieveSendMail(mailNo);
		    	ServiceResult result = sendMailService.removeSendMailVO(sendMailVO);
		  
		    			
	    return result;
		}
		
	
		
		//메일체크박스삭제
		@PostMapping(value="/sendMailCheckDelete.do")
		@ResponseBody
		public ServiceResult mailCheckDelete(@RequestParam("deleteNos[]") String [] deleteNos) {
				
				 Integer[] intDeletetNos = Stream.of(deleteNos).mapToInt(Integer::parseInt).boxed().toArray(Integer[]::new);
				 ServiceResult result = null;
				 for(int mailNo:intDeletetNos) {
					SendMailVO sendMailVO = new SendMailVO();
					sendMailVO.setMailNo(mailNo);
				    result = sendMailService.removeSendMailVO(sendMailVO);
				}
		    
		return result;
		}

}