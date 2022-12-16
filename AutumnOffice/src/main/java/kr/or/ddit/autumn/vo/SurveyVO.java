package kr.or.ddit.autumn.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString
@EqualsAndHashCode(of="surNo")
public class SurveyVO {
	private int rnum;
	private Integer surNo;
	private String empId;
	private String empNm;
	private String surTitle;
	private String surPurpose;
	private String surGuide;
	private String surSdate;
	private String surEdate;
	private Integer surState;
	private String surInsdat;
	
	private EmployeeVO employee;
	private List<EmployeeVO> employeeList;
}
