package kr.or.ddit.autumn.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="revNo")
public class MeetReserVO {
	@NotNull
	private Integer revNo;
	@NotBlank
	private String empId;
	@NotNull
	private Integer meetNo;
	@NotBlank
	private String revStart;
	@NotBlank
	private String revCon;
	@NotNull
	private Integer revSta;
	@NotNull
	private Integer metTime;
	
	private MeetRoomVO meetRoom;
	
}
