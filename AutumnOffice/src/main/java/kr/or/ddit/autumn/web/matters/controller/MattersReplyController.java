package kr.or.ddit.autumn.web.matters.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.web.matters.service.MattersReplyService;
import kr.or.ddit.autumn.web.vo.MattersReplyVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 *	문의사항 댓글 컨트롤러 
 *
 */

@Slf4j
@Controller
@RequestMapping("/web/matters")
@RequiredArgsConstructor
public class MattersReplyController {
	private final MattersReplyService replyService;
	
	@ModelAttribute("reply")
	public MattersReplyVO reply() {
		return new MattersReplyVO();
	}
	
	@PostMapping(value="/replyInsert.do")
	public String replyInsert(@ModelAttribute("reply") MattersReplyVO reply) {
		String viewName = null;
		log.info("값 제대로 들어오니"+reply);
		replyService.createReply(reply);
		viewName= "redirect:/web/matters/mattersView.do?what="+reply.getMatNo();
		return viewName;
	}
	
	@GetMapping(value="/replyDelete.do")
	public String replyDelete(@ModelAttribute("reply") MattersReplyVO reply
			, @RequestParam(value="reply") int mrepNo, @RequestParam(value="matter") int matNo) {
		String viewName = null;
		
		reply.setMrepNo(mrepNo);
		
		
		log.info("값 제대로 들어오니"+reply);
		replyService.removeReply(reply);
		viewName= "redirect:/web/matters/mattersView.do?what="+matNo;
		return viewName;
	}
	
	
	
}
