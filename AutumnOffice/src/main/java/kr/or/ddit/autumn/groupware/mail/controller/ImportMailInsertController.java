package kr.or.ddit.autumn.groupware.mail.controller;

import java.util.Map;
import java.util.stream.Stream;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.mail.service.ImportMailService;
import kr.or.ddit.autumn.groupware.mail.vo.ReceiveMailVO;
import kr.or.ddit.autumn.vo.ImportMailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/mail")
public class ImportMailInsertController {
	@Inject
	private ServletContext application;

	@Inject
	private ImportMailService importMailService;


	@GetMapping(value="/importMailInsert.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ServiceResult importMailInsert(@RequestParam(value="mailNo",required = false) Integer mailNo
										, @RequestParam(value="mailNos[]",required = false) String mailNos[]
										, Authentication authentication
										,HttpServletRequest request
										) {
		
		application = request.getServletContext();
		Map<String,ReceiveMailVO> mailMap = (Map<String, ReceiveMailVO>) application.getAttribute("mailMap");
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		ServiceResult result = null;
		if(mailNo==null || mailNos!=null) {
			 Integer[] intMailNos = Stream.of(mailNos).mapToInt(Integer::parseInt).boxed().toArray(Integer[]::new);	
			for(int mailNum : intMailNos) {
				ReceiveMailVO receiveMailVO = mailMap.get("mail"+mailNum);	
				ImportMailVO importMailVO = new ImportMailVO(receiveMailVO);
				importMailVO.setEmpId(adapter.getRealUser().getEmpId());
				result = importMailService.createImportMailVO(importMailVO);	
			}
			 
		return result;
		
		}else {
		
			ReceiveMailVO receiveMailVO = mailMap.get("mail"+mailNo);
			ImportMailVO importMailVO = new ImportMailVO(receiveMailVO);
			importMailVO.setEmpId(adapter.getRealUser().getEmpId());
			result = importMailService.createImportMailVO(importMailVO);	
	
		return result;
		}
	}
	
	


}