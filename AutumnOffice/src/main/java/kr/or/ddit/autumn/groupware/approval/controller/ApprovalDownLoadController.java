package kr.or.ddit.autumn.groupware.approval.controller;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.groupware.approval.service.ApprovalService;
import kr.or.ddit.autumn.vo.AttatchVO;

@Controller
public class ApprovalDownLoadController {
	
	@Inject
	private ApprovalService service;
	
	@RequestMapping("/groupware/approval/download.do")
	public String download(
		@RequestParam(name="what", required=true) int attNo
		, Model model
	)throws IOException {
		AttatchVO attatch = service.retrieveAttatch(attNo);
		model.addAttribute("attatch", attatch);
		return "downloadView";
	}
}
