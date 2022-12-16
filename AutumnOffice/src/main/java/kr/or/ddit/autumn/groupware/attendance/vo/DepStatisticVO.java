package kr.or.ddit.autumn.groupware.attendance.vo;

import lombok.Data;

@Data
public class DepStatisticVO {

	private String empId;
	private String jobNm;
	private String depNm;
	private String empNm;
	private String staInd;
	private String staOnt;
	private String staOft;
	private String vacCat;
	private String staRec;
	private String bstTrp;
	
	private String depId;
	private String comCode;
	private String powRole;
	
	// 지각 / 결근 여부 확인 [ 부서원 리스트 ]
	private String staRes;
	
	//-----통계 [ 전체 통계 ]
	// 지각
	private int lateRes;
	// 출장
	private int trpRes;
	// 휴가
	private int vacRes;
	// 연차
	private int recRes;
	// 결근
	private int NoRes;
	
	private String rnum;
}
