package kr.or.ddit.autumn.vo;

import lombok.Data;

@Data
public class LveRecodeVO {
	private Integer lerCode;
	private Integer eleNo;
	private Integer aulNo;
	private String lerStart;
	private String lerEnd;
	
	private String lerUse;
	
	private JobVO job;
	private EmployeeVO employee;
	private ElecAppVO elecApp;
	private DepartmentVO department;
	
	private String rNum;
}
