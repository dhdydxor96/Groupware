package kr.or.ddit.autumn.groupware.attendance.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class DepAnnualVO implements Serializable{

	@NotBlank
	private String empNm;
	@NotBlank
	private String empHid;
	@NotBlank
	private String jobNm;
	@NotBlank
	private String depNm;
	private int aulCot;
	private int aulLot;
	private int aulUse;
	private int empYears;
	
	private String rnum;
}
