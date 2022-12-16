package kr.or.ddit.autumn.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="empId")
public class EleRefVO {
	private Integer elrNo;
	private Integer eleNo;
	private String empId;
	
	
	private String empNm;
	private String jobNm;
	private String depNm;
}
