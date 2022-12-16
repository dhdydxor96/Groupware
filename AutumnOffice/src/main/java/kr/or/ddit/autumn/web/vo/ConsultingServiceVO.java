package kr.or.ddit.autumn.web.vo;


import javax.validation.Valid;
import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString
@EqualsAndHashCode(of="serCode")
public class ConsultingServiceVO {
	private int rnum;
	
	private String serCode;
	private String comCode;
	@NotBlank
	private String serEmp;
	@NotBlank
	private String serPeri;
	@NotBlank
	private String servicePay;
	@NotBlank
	private String serStd;
	@NotBlank
	private String serEnd;
	@NotBlank
	private String serName;
	private String comDomain;
	
	@Valid
	private ConsultingVO consulting; // has A
	private String comCnm;
}
