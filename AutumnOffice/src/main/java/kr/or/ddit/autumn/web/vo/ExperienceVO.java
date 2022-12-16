package kr.or.ddit.autumn.web.vo;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.autumn.commons.validate.InsertGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="expMail")
@ToString
public class ExperienceVO {
	
	@NotBlank(groups= {InsertGroup.class})
	private String expMail;
	@NotBlank
	private String expCom;
	@NotBlank
	private String expNm;
	@NotBlank
	private String expTel;
}
