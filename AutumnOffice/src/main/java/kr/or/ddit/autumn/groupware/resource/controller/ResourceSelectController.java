package kr.or.ddit.autumn.groupware.resource.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.resource.service.ResourceService;
import kr.or.ddit.autumn.groupware.resource.vo.ReservVO;
import kr.or.ddit.autumn.groupware.resource.vo.ResourceInfoVO;
import kr.or.ddit.autumn.groupware.resource.vo.ResourcePagingVO;
import kr.or.ddit.autumn.groupware.resource.vo.RoomVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.MeetTimeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/resource")
@RequiredArgsConstructor
public class ResourceSelectController {

	private final ResourceService resourceService;
	
	// ================================
	// * 회의실리스트+예약현황
	// ================================
	@RequestMapping("/resourceList.do")
	public String resourceList(Authentication authentication, Model model) {
		
		// 로그인한 본인 정보 
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realUser = adapter.getRealUser();
		
		return "groupware/resource/resourceList";
		
		
	}
	
	// ================================
	// * 전체 회의실 리스트 조회+회의실 예약건수
	// ================================
	@RequestMapping(value="/companyResourceStatus.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResourcePagingVO<RoomVO> companyResourceStatus(Authentication authentication, @RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition){
		
		// 로그인한 본인 정보 
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realUser = adapter.getRealUser();
		String comCode = realUser.getComCode();
		
		ResourcePagingVO<RoomVO> pagingVO = new ResourcePagingVO<>(3,3);
		pagingVO.setComcode(comCode);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = resourceService.selectResourceTotalCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<RoomVO> roomList = resourceService.retrieveAllResourceList(pagingVO);
		pagingVO.setDataList(roomList);
		
		return pagingVO;
	}
	
	// ================================
	// * 내 예약 현황 확인
	// ================================
	@RequestMapping(value="/myResourceStatus.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResourcePagingVO<ReservVO> myResourceStatus(Authentication authentication, @RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition){
		// 로그인한 본인 정보 
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realUser = adapter.getRealUser();
		String empId = realUser.getEmpId();
		
		// 사용 전/사용완료 변경
		resourceService.updateResourceStatus();
		
		ResourcePagingVO<ReservVO> pagingVO = new ResourcePagingVO<>(5,3);
		pagingVO.setEmpId(empId);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = resourceService.selectResourceTotalCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ReservVO> reserList = resourceService.retrieveMyResourceList(pagingVO);
		pagingVO.setDataList(reserList);
		
		return pagingVO;
	}
	
	
	// ================================
	// * 회의실 상세보기 (회의실 정보, 회의실 예약 현황)
	// ================================
	@RequestMapping("/resourceDetail.do")
	public String resourceView(Authentication authentication, Model model, @RequestParam("what") int meetNo) {
		
		// 로그인한 본인 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realUser = adapter.getRealUser();
		
		// 잘못된 파라미터로 본인의 기업이 아닌 타 기업의 회의실을 확인하는지 확인
		List<RoomVO> meetRoomList;
		meetRoomList = resourceService.retrieveCompanyAllResourceList(realUser.getComCode());
		
		ArrayList list = new ArrayList();
		
		for(RoomVO roomInfo : meetRoomList) {
				list.add(roomInfo.getMeetNo());
				
				
		}
		log.info("갖고있는 정보"+list);
		
		if(!list.contains(meetNo)) {
			return "redirect:/groupware/resource/resourceList.do";
		}
		
		
		// 회의실 정보 (빔프로젝트 여부, 위치 등)
		ResourceInfoVO resourceInfoVO = resourceService.retrieveResourceDetail(meetNo);
		model.addAttribute(resourceInfoVO);
		
		// 시간 정보 제공 (9:00~10:00)
		List<MeetTimeVO> timeList = resourceService.selectTimeList();
		model.addAttribute(timeList);

		//-----------------------------------
		// 기간 지정
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		//일주일의 첫날 선택
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        //해당 주차 시작일과의 차이 구하기용
        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - cal.getFirstDayOfWeek();
        //해당 주차의 첫날 세팅
        cal.add(Calendar.DAY_OF_MONTH, - dayOfWeek);
        //해당 주차의 첫일자(월)
        String stDt = format.format(cal.getTime());
        //해당 주차의 화요일 세팅
        cal.add(Calendar.DAY_OF_MONTH, 1); 
        String tues = format.format(cal.getTime());
        
        //해당 주차의 수요일 세팅
        cal.add(Calendar.DAY_OF_MONTH, 1); 
        String wed = format.format(cal.getTime());
        
        //해당 주차의 수요일 세팅
        cal.add(Calendar.DAY_OF_MONTH, 1); 
        String thur = format.format(cal.getTime());
        
        //해당 주차의 마지막 세팅
        cal.add(Calendar.DAY_OF_MONTH, 1); 
        //해당 주차의 마지막일자(금)
        String edDt = format.format(cal.getTime());

        log.info(stDt+","+tues+","+wed+","+thur+","+edDt);
        
        ReservVO reservSetVO = new ReservVO();
        
        reservSetVO.setStartDay(stDt);
        reservSetVO.setEndDay(edDt);
        reservSetVO.setMon(stDt);
        reservSetVO.setTues(tues);
        reservSetVO.setWed(wed);
        reservSetVO.setThur(thur);
        reservSetVO.setFri(edDt);
        
        reservSetVO.setMeetNo(meetNo);
        
        ReservVO reservVO = new ReservVO();
        reservVO.setStartDay(stDt);
        reservVO.setEndDay(edDt);
        model.addAttribute("reservVO", reservVO);
        
        //List<ReservVO> reservList = resourceService.retrieveRoomList(reservSetVO);
        List<ReservVO> reservList = resourceService.retrieveReservTableList(meetNo);
        
        log.info("제발>>>>>>>>>>>>>>>>>>>>>>>>>"+reservList);
        model.addAttribute(reservList);
        
        log.info("회의실 주간 예약"+model);
        
		return "groupware/resource/resourceDetail";
	}
}
