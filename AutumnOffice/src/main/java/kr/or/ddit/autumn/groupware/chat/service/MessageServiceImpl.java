package kr.or.ddit.autumn.groupware.chat.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.chat.dao.MessageDAO;
import kr.or.ddit.autumn.vo.ChatRoomCustomVO;
import kr.or.ddit.autumn.vo.MessageVO;

@Service
public class MessageServiceImpl implements MessageService {
	@Inject
	private MessageDAO dao;

	@Override
	public List<MessageVO> retrieveChatRoomList(String empId) {
		
		return dao.selectChatRoomList(empId);
	}
	
	@Override
	public List<ChatRoomCustomVO> retrieveChatRoomCustomList(String empId) {
		
		return dao.selectChatRoomCustomList(empId);
	}

	@Override
	public List<MessageVO> retrieveMessageList(Integer roomId) {
		
		return dao.selectMessageList(roomId);
	}

	@Override
	public ServiceResult createMessage(MessageVO message) {
		
		ServiceResult result = null;
		
		 
		int rowcnt = dao.insertMessage(message);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;

		return result;
	}

	@Override
	public ServiceResult removeChat(MessageVO message) {
		
		int rowcnt = dao.deleteChat(message);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	
	@Override
	public ServiceResult removeMessage(MessageVO message) {
		
		int rowcnt = dao.deleteMessage(message);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}


	@Override
	public ServiceResult updateNewChatRoom(MessageVO message) {
		
		int rowcnt = dao.updateNewChatRoom(message);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}



}
