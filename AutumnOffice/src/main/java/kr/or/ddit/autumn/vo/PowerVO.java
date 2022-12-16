package kr.or.ddit.autumn.vo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class PowerVO {
	private int rnum;
	
	private int powNo;
	private String empId;
	private String powRole;
	private String empNm;
	
	private EmployeeVO employee;
	private List<EmployeeVO> employeeList;
	@JsonIgnore
	private transient List<DepartmentVO> departmentList;
	@JsonIgnore
	private transient List<JobVO> jobList;
	DepartmentVO department;
	JobVO job;
}
