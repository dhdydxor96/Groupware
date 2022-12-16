package kr.or.ddit.autumn.groupware.board.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.groupware.board.service.CommentService;
import kr.or.ddit.autumn.vo.CommentsVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping(value="/groupware/board/comment", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class CommentController {
	
	private final CommentService service; 
	
	@GetMapping("/{poNo}")
	public PagingVO<CommentsVO> CommentList(
				CommentsVO detailCondition
			,	@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		) {
		
		log.info("@@@@@@@@@@@@@@@@@@@@@호출 111111 !!!!!!!!!!!!!!!!!!!!!");
		PagingVO<CommentsVO> pagingVO = new PagingVO<>(); 
		pagingVO.setDetailCondition(detailCondition);
		pagingVO.setCurrentPage(currentPage);
		
		service.retrieveCommentList(pagingVO);
	
		return pagingVO;
	}
	
	@PostMapping("/{poNo}")
	public Map<String, Object> insertComment(
				@PathVariable(name="poNo", required=true) int poNo
			,	@Validated(InsertGroup.class)	@ModelAttribute("comments") CommentsVO comments
			,	Errors errors
		) {

		log.info("@@@@@@@@@@@@@@@@@@@@@호출 2222222 !!!!!!!!!!!!!!!!!!!!!");
		
		
		System.out.println("@@@@@@@@@@@@@@@@@@@ 호출 empId : "+comments.getEmpId()+" 333333 %%%%%%%%%%%%%%");
		
		Map<String, Object> result = new HashMap<String, Object>();
		if(!errors.hasErrors()) {
			if(null == comments.getCotNo()) {
				result.put("result", service.createComment(comments));
			}else { 
				result.put("message", service.updateComment(comments));
			}
		}else {
			result.put("errors", errors.getFieldErrorCount());
		}
		return result;
	}
	
	@GetMapping("/updateComment/{poNo}")
	public Map<String, Object> updateComment(
				@PathVariable(name="where", required=true) int poNo
			,	@ModelAttribute("comments") CommentsVO comments
		) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("message", service.updateComment(comments));
		
		return result;
	}
	
	@GetMapping("/deleteComment/{poNo}")
	public Map<String, Object> deleteComment(
			@ModelAttribute("comments") CommentsVO comments
		) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("message", service.deleteComment(comments));
		
		return result;
	}
	
}
