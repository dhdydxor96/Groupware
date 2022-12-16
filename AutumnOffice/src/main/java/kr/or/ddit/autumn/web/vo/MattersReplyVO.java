package kr.or.ddit.autumn.web.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="mrepNo")
@ToString
public class MattersReplyVO implements Serializable {
	private Integer mrepNo;
	private Integer matNo;
	private String mrepCon;
	private String mrepWri;
	private String mrepDate;
	private String mrepUdate;
}
