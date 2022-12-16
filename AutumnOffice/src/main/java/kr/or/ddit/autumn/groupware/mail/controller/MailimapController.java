package kr.or.ddit.autumn.groupware.mail.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.List;
import java.util.stream.Stream;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.groupware.mail.service.MailReaderServiceImpl;
import kr.or.ddit.autumn.groupware.mail.vo.ReceiveMailVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/mail")
public class MailimapController {
	private String userName = "";
	private String password = "";
	
	
	
	@Inject
	private MailReaderServiceImpl receiver;
	
	@Value("#{appInfo.attatchFolder}")//el코드를 쓸수있는 어노테이션
	private Resource attatchFolder;
	private File saveFolder;
	
	@PostConstruct
	public void init(
			
			) throws IOException {
    
    
		saveFolder = attatchFolder.getFile();
	
		if(!saveFolder.exists())
			saveFolder.mkdirs();
		
		log.info("로딩된 saveFolder : {}",saveFolder.getCanonicalPath());
	}
	
	
	
	
	//메일 페이징 리스트
		@PostMapping(value="/mailList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public PagingVO<ReceiveMailVO> mailPagingList(HttpServletRequest request
				    ,HttpSession session
					,@RequestParam(name="page", required=false, defaultValue="1") int currentPage) throws ParseException, MessagingException, IOException {
			
	    String saveDirectory = "D:\\saveFiles\\";
	    receiver.setSaveDirectory(saveFolder);
	   
	    EmployeeVO empVO = (EmployeeVO) session.getAttribute("authEmp");
	    userName = empVO.getEmpMail();
		password = empVO.getEmpMpass();
		PagingVO<ReceiveMailVO> pagingVO = new PagingVO<>(10,3);
			if(StringUtils.isBlank(password)) {
				
				return pagingVO;
			}else {
				pagingVO.setCurrentPage(currentPage);
				
				int totalRecord = receiver.retrieveMailCount(pagingVO,userName, password);
				pagingVO.setTotalRecord(totalRecord);
				
				
			    List<ReceiveMailVO> mailList = receiver.receiveMailAttachedFilePaging(request, userName, password, currentPage);
			    pagingVO.setDataList(mailList);
		   
		    	return pagingVO;
			}
		}
	
	//메일 하나삭제
	@PostMapping(value="/mailDelete.do")
	@ResponseBody
	public boolean mailDelete(Integer mailNo
			   				  ,HttpSession session) throws ParseException, MessagingException, IOException {
		 EmployeeVO empVO = (EmployeeVO) session.getAttribute("authEmp");
		    userName = empVO.getEmpMail();
			password = empVO.getEmpMpass();
	    	boolean result = receiver.deleteMail(mailNo, userName, password);
 
    return result;
	}
	
	//메일 하나삭제
	@PostMapping(value="/mailDetailDelete.do")
	public String mailDetailDelete(Integer mailNo
								  ,HttpSession session) throws ParseException, MessagingException, IOException {
		
		    EmployeeVO empVO = (EmployeeVO) session.getAttribute("authEmp");
		    userName = empVO.getEmpMail();
			password = empVO.getEmpMpass();
			boolean result = receiver.deleteMail(mailNo, userName, password);
	    
	   
			String viewName = "redirect:/groupware/mail/mailList.do";
	 
	return viewName;
	}
	
	//메일체크박스삭제
		@PostMapping(value="/mailCheckDelete.do")
		@ResponseBody
		public boolean mailCheckDelete(@RequestParam("deleteNos[]") String [] deleteNos
										,HttpSession session) throws ParseException, MessagingException, IOException {
			
			 Integer[] intDeletetNos = Stream.of(deleteNos).mapToInt(Integer::parseInt).boxed().toArray(Integer[]::new);
			 EmployeeVO empVO = (EmployeeVO) session.getAttribute("authEmp");
			    userName = empVO.getEmpMail();
				password = empVO.getEmpMpass();
			boolean result	 = receiver.deleteCheckMail(intDeletetNos, userName, password);
		
	    return result;
		}
	
	
}