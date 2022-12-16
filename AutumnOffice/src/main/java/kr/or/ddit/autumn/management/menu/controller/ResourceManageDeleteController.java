package kr.or.ddit.autumn.management.menu.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.menu.service.ResourceManageService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.MeetRoomVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/menu")
@RequiredArgsConstructor
public class ResourceManageDeleteController {

	private final ResourceManageService service;
	
	// ================================
	// * 관리자페이지 - 회의실 삭제
	// (회의실 이미지+회의실 상세정보+회의실)
	// ================================
	@RequestMapping(value="/resoureManageDelete.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<MeetRoomVO> resourceManageDelete(Authentication authentication, @RequestParam(value="delMeetNos[]") List<String> delMeetNos,
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			) {
		
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		log.info("삭제할 파라미터 데이터 {}", delMeetNos);
		
		ServiceResult result = null ;
		
		for(String delMeetNo : delMeetNos) {
			if(StringUtils.isBlank(delMeetNo)) {
				continue;
			}
			 result = service.removeMeetRoom(Integer.parseInt(delMeetNo));
			 
			 if(result.equals(ServiceResult.OK)) {
				 continue;
			 }else {
				 break;
			 }
		}
		
		SearchVO searchVO = new SearchVO();
		searchVO.setState(null);
		
		PagingVO<MeetRoomVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setComcode(comCode);
		pagingVO.setSimpleCondition(searchVO);
		int totalRecord = service.selectTotalCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<MeetRoomVO> meetRoomList = service.retrieveMeetRoomList(pagingVO);
		pagingVO.setDataList(meetRoomList);
		
		log.info("회의실 관리 -  삭제할때 비동기 처리 값 {}",pagingVO);
		
		return pagingVO;
	}
	
}
