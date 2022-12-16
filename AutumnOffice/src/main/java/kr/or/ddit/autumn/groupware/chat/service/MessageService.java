package kr.or.ddit.autumn.groupware.chat.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.ChatRoomCustomVO;
import kr.or.ddit.autumn.vo.MessageVO;

public interface MessageService {

	public ServiceResult createMessage(MessageVO message);

//	public MessageVO retrieveMessage(Integer notNo);

	//채팅방 목록
	public List<MessageVO> retrieveChatRoomList(String empId);
	
	//채팅방 목록
	public List<ChatRoomCustomVO> retrieveChatRoomCustomList(String empId);
	
	//예시) 1번방의 메세지목록
	public List<MessageVO> retrieveMessageList(Integer roomId);

	//삭제여부 변경
	public ServiceResult removeChat(MessageVO message);

	public ServiceResult removeMessage(MessageVO message);
	
	//채팅방 new표시 업데이트
	public ServiceResult updateNewChatRoom(MessageVO message);
}
