package kr.or.ddit.autumn.groupware.attendance.vo;

import lombok.Data;

@Data
public class AnnualRecodeVO {
	
	private Integer lerCode;
	private Integer eleNo;
	private Integer aulNo;
	private String lerStart;
	private String lerEnd;
	
	private String empNm;
	private String depNm;
	private String empId;
	
	private String lerDay;
	private String rNum;
}
