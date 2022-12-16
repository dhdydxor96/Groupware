package kr.or.ddit.autumn.groupware.mail.controller;

import java.util.stream.Stream;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.mail.service.ImportMailService;
import kr.or.ddit.autumn.vo.ImportMailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/mail")
public class ImportMailDeleteController {

	@Inject
	private ImportMailService importMailService;

	// 메일 하나삭제
	@PostMapping(value ="/importMailDelete.do")
	@ResponseBody
	public ServiceResult importMailDelete(@RequestParam("maiNo") Integer maiNo) {
		ImportMailVO importMailVO = importMailService.retrieveImportMail(maiNo);
		ServiceResult result = importMailService.removeImportMailVO(importMailVO);

		return result;
	}

	// 메일체크박스삭제
	@PostMapping(value ="/importMailCheckDelete.do")
	@ResponseBody
	public ServiceResult importMailCheckDelete(@RequestParam("deleteNos[]") String[] deleteNos) {
		System.out.println(deleteNos);
		Integer[] intDeletetNos = Stream.of(deleteNos).mapToInt(Integer::parseInt).boxed().toArray(Integer[]::new);
		ServiceResult result = null;
		for (int maiNo : intDeletetNos) {
			ImportMailVO importMailVO = new ImportMailVO();
			importMailVO.setMaiNo(maiNo);
			result = importMailService.removeImportMailVO(importMailVO);
		}

		return result;
	}

}