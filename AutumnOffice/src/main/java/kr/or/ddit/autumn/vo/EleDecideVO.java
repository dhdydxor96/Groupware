package kr.or.ddit.autumn.vo;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class EleDecideVO {
	private int eldNo;
	private String empId;
	@NotBlank
	private String empProxy;
	private String empNm;
	@NotBlank
	private String eldStart;
	@NotBlank
	private String eldEnd;
	@NotBlank
	private String eldRes;
	private String eldInd;
	private String jobNm;
	private boolean eldUse;
}
