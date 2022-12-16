package kr.or.ddit.autumn.vo;

import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of="jobId")
@Data
public class JobVO {
	private int rnum;
	@NotBlank
	private Integer jobId;
	private Integer jobHjc;
	private String jobNm;
	private String jobTnm;
	private String jobCrd;
	private String jobUpd;
	private String comCode;
	
	private List<CompanyVO> companyList;
	
	private int empCount;
	
	private List<EmployeeVO> empList;
	
	private JobVO job;
	private List<JobVO> jobList;
}	
