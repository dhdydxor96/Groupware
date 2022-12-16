package kr.or.ddit.autumn.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class EmpTimeVO {
	
	@NotNull
	private int emtNo;
	@NotBlank
	private String comCode;
	@NotBlank
	private String emtOnt;
	@NotBlank
	private String emtOft;
}
