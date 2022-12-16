package kr.or.ddit.autumn.groupware.profile.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.profile.service.GroupwareProfileService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ProfileUpdateController {

	private final GroupwareProfileService service;
	
	// ================================
	// * 프로필 관리 - 프로필 사진 업로드
	// ================================
	@PostMapping(value="/groupware/profile/profileUpdate.do")
	public String updateProfile(Authentication authentication,  EmployeeVO employeeVO, RedirectAttributes ratt) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		log.info("파라미터 정보 - AttatchList : {}", employeeVO.getAttatchList() );
		
		employeeVO.setEmpId(empId);
		
		ServiceResult result = service.updateProfileImage(employeeVO);
		
		if(result.equals(ServiceResult.FAIL)) {
			ratt.addFlashAttribute("message", "프로필 사진 변경에 실패하였습니다.잠시 후에 다시 시도해주세요.");
		}
		
		return "redirect:/groupware/index.do";
	}
}
 