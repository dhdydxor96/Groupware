package kr.or.ddit.autumn.vo;

import java.io.Serializable;
import java.util.Set;

import javax.validation.constraints.NotNull;

import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Data
@EqualsAndHashCode(of = "msgNo")
@ToString
@Slf4j
public class MessageVO implements Serializable{
	private Integer msgNo;
	private String empId;
	private String msgCon;
	@NotNull(groups=UpdateGroup.class)
	private Integer roomId;
	private String msgDay;
	private String empNm;
	private String msgNew;
	
	private Set<ChatRoomVO> chatRoomList;
}
