package kr.or.ddit.autumn.web.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString
@EqualsAndHashCode(of="arepNo")
public class AdviceReplyVO {
	private Integer arepNo;
	private Integer advNo;
	private String arepCon;
	private String arepWri;
	private String arepDate;
}
