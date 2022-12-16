package kr.or.ddit.autumn.groupware.attendance.vo;

import lombok.Data;

@Data
public class StatusVO {
	private Integer staNo;
	private String escCode;
	private String empId;
	private String staInd;
	private String staOnt;
	private String staOft;
	
	private String staCht;
	private String dayVal;
	private String sumSta;
	private String staCon;
	private String staId;
	private String updateDay;
	
	// 초분시 계산
	private String sumSecond;
	private String sumTime;
	private String overTime;
	private String leftTime;
	
	// 부서별 조회
	private String comCode;
	private String depId;
	private String allTime;
	private String empNm;
	private String jobNm;
	private String depNm;
	private String staNm;
	private String staJob;
	
	private String powRole;
	private String rNum;
}
