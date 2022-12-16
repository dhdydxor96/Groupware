package kr.or.ddit.autumn.groupware.resource.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.autumn.vo.MeetRoomVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="revNo")
public class ReservVO {
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
	
	// room 정보
	private MeetRoomVO meetRoom;
	
	// 예약 시간 뿌려줄거
	private String metCon;
	
	// 날짜 검색용
	private String startDay;
	private String endDay;
	
	// 예약자 이름 확인
	private String empNm;
	
	private String meetNm;
	private int metTime;
	
	//테이블 뿌리기
	private String mon;
	private String tues;
	private String wed;
	private String thur;
	private String fri;
	
//	private String expr;
	
	private String dayVal;
	private String timeTxt;
	private String rsvNms;
	
	public String getExpr() {
		
		
		
		return "'"+mon+"' MON, '"+tues+"' TUES, '"+wed+"' WED, '"+thur+"' THUR, '"+fri+"' FRI";
	}
}
