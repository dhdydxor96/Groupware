package kr.or.ddit.autumn.vo;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.autumn.commons.validate.InsertGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="boCode")
public class BoardVO {
	@NotBlank(groups=InsertGroup.class)
	private String boCode;
	private String comCode;
	private String boType;
	private String boYn;
}
