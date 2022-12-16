package kr.or.ddit.autumn.groupware.chat.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.ChatRoomVO;


public interface ChatRoomService {

	public ServiceResult createChatRoom(ChatRoomVO chatRoom);

	public ChatRoomVO retrieveChatRoom(Integer roomId);

	

	public ServiceResult modifyChatRoom(ChatRoomVO chatRoom);

	public ServiceResult removeChatRoom(Integer roomId);
}
