package kr.or.ddit.autumn.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@EqualsAndHashCode(of="depId")
@Data
@ToString
public class DepartmentVO implements Serializable{
	
	private int rnum;
	
	@NotBlank
	private String depId;
	private String depHdc;
	private String depTnm;
	private String depNm;
	private String depMag;
	private String depDst;
	private String depCrd;
	private String depUpd;
	private String comCode;
	private String empId;
	private String empNm;
	
	private int empCount;
	
	private List<EmployeeVO> employeeList;
	
	private List<CompanyVO> companyList;
	
	private DepartmentVO department;
	private List<DepartmentVO> departmentList;
	
	private EmployeeVO employee;
	private PowerVO power;
	private List<PowerVO> powerList;
}
