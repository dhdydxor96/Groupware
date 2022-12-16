package kr.or.ddit.autumn.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="escCode")
@ToString
public class EmpStcodeVO implements Serializable{
	@NotBlank
	private String escCode;
	@NotBlank
	private String escNm;
}
