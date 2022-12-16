package kr.or.ddit.autumn.groupware.chat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.ChatRoomVO;

@Mapper
public interface ChatRoomDAO {
	
	//채팅방 생성
	public int insertChatRoom(ChatRoomVO chatroom);

	//룸아이디로 채팅방 셀렉트
	public ChatRoomVO selectChatRoom(Integer roomId);
	
	//채팅방 제목 수정
	public int updateChatRoom(ChatRoomVO chatroom);

	//채팅방 삭제
	public int deleteChatRoom(@Param("roomId") Integer roomId);

}
