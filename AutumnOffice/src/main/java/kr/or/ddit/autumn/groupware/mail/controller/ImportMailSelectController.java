package kr.or.ddit.autumn.groupware.mail.controller;

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
import kr.or.ddit.autumn.groupware.mail.service.ImportMailService;
import kr.or.ddit.autumn.vo.ImportMailVO;
import kr.or.ddit.autumn.vo.SendMailVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/mail")
public class ImportMailSelectController {
	

	@Inject
	private ImportMailService importMailService;


	// 중요메일함뷰
	@GetMapping("/mailImportList.do")
	public String mailImportListUI(Model model) {
		model.addAttribute("mail", "중요메일함");
		return "groupware/mail/mailImportList";
	}


	// 중요메일함리스트
	@GetMapping(value="/mailImportList.do" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ImportMailVO> mailImportList(
			  @RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, Authentication authentication
			) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		
		
		
		PagingVO<ImportMailVO> pagingVO = new PagingVO<>(10,3);
		pagingVO.setEmpId(adapter.getRealUser().getEmpId());
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = importMailService.retrieveImportMailCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ImportMailVO> mailList = importMailService.retrieveImportMailList(pagingVO);
		pagingVO.setDataList(mailList);
		
		return pagingVO;
		
	}
	
	//상세뷰
	@GetMapping("/mailImportDetail.do")
	public String mailDetailUI(Model model,
			   @RequestParam("maiNo") Integer maiNo) {
		model.addAttribute("mail", "중요메일함");
		model.addAttribute("maiNo", maiNo);
		return "groupware/mail/mailImportDetail";
	}
	
	//상세데이터
	@RequestMapping(value="mailImportDetail.do"
			, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ImportMailVO importMailView(@RequestParam("maiNo") Integer maiNo) {
	ImportMailVO importMailVO = importMailService.retrieveImportMail(maiNo);
	
	return importMailVO;
	}
	

	//다음 이전 페이지 
	@GetMapping(value="mailImportNextPage.do"
			, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ImportMailVO> forwardMailNextPage(Authentication authentication) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		
		List<ImportMailVO> mailList = importMailService.noPageRetrieveImportMailList(adapter.getRealUser().getEmpId());
	return mailList;
	
	}	


}