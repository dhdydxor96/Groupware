package kr.or.ddit.autumn.groupware.chat.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.chat.dao.ChatRoomDAO;
import kr.or.ddit.autumn.vo.ChatRoomVO;

@Service
public class ChatRoomServiceImpl implements ChatRoomService {
	@Inject
	private ChatRoomDAO dao;


	@Override
	public ServiceResult createChatRoom(ChatRoomVO chatRoom) {
		ServiceResult result = null;
		
		 
		int rowcnt = dao.insertChatRoom(chatRoom);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;

		return result;
	}
	
	@Override
	public ChatRoomVO retrieveChatRoom(Integer roomId) {
		ChatRoomVO chatroom = dao.selectChatRoom(roomId);
		if (chatroom == null)
			throw new RuntimeException("해당 채팅방 없음");
		return chatroom;
	}



	@Override
	public ServiceResult modifyChatRoom(ChatRoomVO chatRoom) {
		retrieveChatRoom(chatRoom.getRoomId());
		int rowcnt = dao.updateChatRoom(chatRoom);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeChatRoom(Integer roomId) {
		retrieveChatRoom(roomId);
		int rowcnt = dao.deleteChatRoom(roomId);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
