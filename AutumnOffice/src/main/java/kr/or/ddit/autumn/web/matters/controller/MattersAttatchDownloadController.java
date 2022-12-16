package kr.or.ddit.autumn.web.matters.controller;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.web.matters.service.MattersService;

/**
 *	문의사항 다운로드 컨트롤러 
 *
 */

@Controller
public class MattersAttatchDownloadController {
	@Inject
	private MattersService service;
	
	@RequestMapping("/web/matters/download.do")
	public String download(
		@RequestParam(name="what", required=true) int attNo
		, Model model
	)throws IOException {
		AttatchVO attatch = service.retrieveAttatch(attNo);
		model.addAttribute("attatch", attatch);
		return "downloadView";
	}
}
