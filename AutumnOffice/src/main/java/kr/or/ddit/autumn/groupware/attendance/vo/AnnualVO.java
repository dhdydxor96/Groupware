package kr.or.ddit.autumn.groupware.attendance.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class AnnualVO implements Serializable{
	
	@NotBlank
	private String empNm;
	@NotBlank
	private String JobNm;
	@NotBlank
	private int aulCot;	
	private int aulLot;
	private int aulUse;
}
