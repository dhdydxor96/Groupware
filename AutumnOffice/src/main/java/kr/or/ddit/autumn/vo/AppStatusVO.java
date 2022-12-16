package kr.or.ddit.autumn.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="eleNo")
public class AppStatusVO implements Serializable{
	@NotNull
	private Integer eleNo;
	@NotNull
	private Integer aplNo;
	private String apsStatus;
	private String apsDate;
	private String apsRer;
}	
