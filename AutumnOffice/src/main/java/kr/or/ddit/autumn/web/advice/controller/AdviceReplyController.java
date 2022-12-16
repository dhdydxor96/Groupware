package kr.or.ddit.autumn.web.advice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.web.advice.service.AdviceReplyService;
import kr.or.ddit.autumn.web.vo.AdviceReplyVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 *	상담요청 댓글 컨트롤러 
 *
 */

@Slf4j
@Controller
@RequestMapping("/web/advice")
@RequiredArgsConstructor
public class AdviceReplyController {
	private final AdviceReplyService replyService;
	
	@ModelAttribute("advReply")
	public AdviceReplyVO reply() {
		return new AdviceReplyVO();
	}
	
	@PostMapping(value="/replyInsert.do")
	public String replyInsert(@ModelAttribute("advReply") AdviceReplyVO reply) {
		String viewName = null;
		
		log.info("값 제대로 들어오니"+reply);
		replyService.createReply(reply);
		viewName="redirect:/web/advice/adviceView.do?what="+reply.getAdvNo();
		return viewName;
	}
	
	@GetMapping(value="/replyDelete.do")
	public String replyDelete(@ModelAttribute("advReply") AdviceReplyVO reply
		, @RequestParam(value="reply") int arepNo, @RequestParam(value="advice") int advNo) {
		String viewName = null;
		
		reply.setArepNo(arepNo);
		
		log.info("값 제대로 들어오니"+reply);
		replyService.removeReply(reply);
		viewName="redirect:/web/advice/adviceView.do?what="+advNo;
		return viewName;
	}
	
}
