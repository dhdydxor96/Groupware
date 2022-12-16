package kr.or.ddit.autumn.vo;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="meetNo")
public class MeetInfoVO {
	@NotNull
	private Integer meetNo;
	private String meiPer;
	private String meiBeam;
	private String meiBod;
	private String meiPla;
	private String meiItem;
	private String meiScr;
	
}
