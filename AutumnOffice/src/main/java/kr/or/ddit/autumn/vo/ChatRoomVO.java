package kr.or.ddit.autumn.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ChatRoomVO implements Serializable{
	@NotNull(groups=UpdateGroup.class)
    private Integer roomId;
    private String roomName;
    

    
}