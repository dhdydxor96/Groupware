package kr.or.ddit.autumn.management.group.employee.controller;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.management.group.employee.service.ManagementEmployeeService;
import kr.or.ddit.autumn.vo.AttatchVO;

@Controller
public class EmployeeImageController {
	
	@Inject
	private ManagementEmployeeService service;
	
	@RequestMapping("/management/group/employee/employeeImageView.do")
	public String download(@RequestParam(required=true, name="what") String empId, Model model)throws IOException{
		AttatchVO imageInfoVO = service.retrieveAttatch(empId);
		model.addAttribute("attatch", imageInfoVO);
		return "ImageView";
	}
}
