package kr.or.ddit.autumn.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="cotNo")
public class CommentsVO {
	private Integer cotNo;
	private Integer poNo;
	private String empId;
	private String cotCon;
	private String cotCrd;

	private String empNm; 
}
