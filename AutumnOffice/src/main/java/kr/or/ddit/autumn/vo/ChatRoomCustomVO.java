package kr.or.ddit.autumn.vo;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ChatRoomCustomVO {
	
    private Integer roomId;
    private String roomName;
    private List<MessageVO> empList;

    
}