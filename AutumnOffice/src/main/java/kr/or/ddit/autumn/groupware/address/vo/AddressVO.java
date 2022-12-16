package kr.or.ddit.autumn.groupware.address.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class AddressVO implements Serializable{

	private int rnum;
	@NotBlank
	private String empNm;
	private String empPh;
	private String empMail;
	private String depNm;
	private String jobNm;
}
