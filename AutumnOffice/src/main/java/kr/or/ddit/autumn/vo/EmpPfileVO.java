package kr.or.ddit.autumn.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of="epfNo")
@Data
public class EmpPfileVO implements Serializable{
	private Integer epfNo;
	@NotBlank
	private Integer attNo;
	@NotBlank
	private String empId;
}
