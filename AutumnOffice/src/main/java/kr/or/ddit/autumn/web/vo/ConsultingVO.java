package kr.or.ddit.autumn.web.vo;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.autumn.commons.validate.InsertGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="comCode")
@ToString
public class ConsultingVO {
	@NotBlank
	private String comCode;
	@NotBlank(groups= {InsertGroup.class})
	private String comId;
	@NotBlank(groups= {InsertGroup.class})
	private String comPass;
	@NotBlank
	private String comNm;
	@NotBlank
	private String comPh;
	@NotBlank
	private String comMail;
	@NotBlank
	private String comCnm;
	@NotBlank
	private String comCeo;
	@NotBlank
	private String comTel;
	private String comBrn;
	@NotBlank
	private String comAddr;
	private String comDiv;
	private String comCorporate;
	private String comDomain;
}
