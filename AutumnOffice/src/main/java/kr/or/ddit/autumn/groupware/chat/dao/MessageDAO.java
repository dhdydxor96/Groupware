package kr.or.ddit.autumn.groupware.chat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.ChatRoomCustomVO;
import kr.or.ddit.autumn.vo.MessageVO;


@Mapper
public interface MessageDAO {

	//메세지 생성
	public int insertMessage(MessageVO message);

//	public MessageVO selectMessage(Integer roomId);
	
	//empId의 채팅방 목록
	public List<MessageVO> selectChatRoomList(String empId);
	
	//empId의 채팅방커스텀 목록
	public List<ChatRoomCustomVO> selectChatRoomCustomList(String empId);
	
	//roomId별 메세지 목록
	public List<MessageVO> selectMessageList(Integer roomId);
	
	//채팅방, 메세지 삭제상태코드 변경
	public int deleteChat(MessageVO message);
	
	//메세지 삭제
	public int deleteMessage(MessageVO message);
	
	//채팅방 new상태
	
	public int updateNewChatRoom(MessageVO message );
	
	

}
