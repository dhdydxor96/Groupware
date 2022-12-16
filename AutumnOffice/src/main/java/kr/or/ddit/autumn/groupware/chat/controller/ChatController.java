package kr.or.ddit.autumn.groupware.chat.controller;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.WebSocketSession;

import kr.or.ddit.autumn.commons.employee.service.EmployeeService;
import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.commons.notify.service.NotifyService;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import kr.or.ddit.autumn.groupware.chat.service.ChatRoomService;
import kr.or.ddit.autumn.groupware.chat.service.MessageService;
import kr.or.ddit.autumn.groupware.main.service.GroupwareMainService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.ChatRoomCustomVO;
import kr.or.ddit.autumn.vo.ChatRoomVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.MessageVO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/groupware/chat")
public class ChatController {
	private final MessageService messageService;
	private final ChatRoomService chatRoomService;
	private final EmployeeService EmployeeService;
	private final GroupwareMainService service;
	
	@Resource(name="otherWsSessions")
	private List<WebSocketSession> otherWsSessions;
	
	@Inject
	private NotifyService notifyService;
	
	// 채팅메인뷰
	@GetMapping("/chatHome.do")
	public String chatUI() {
	
		return "groupware/chat/chat";
	}

	
	//채팅방목록 가져오기
	@GetMapping(value="/chatRoomList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<MessageVO> roomList(@RequestParam("empId") String empId,Model model) {

		List<MessageVO> messageList = messageService.retrieveChatRoomList(empId);
		model.addAttribute("messageList", messageList);
		
		return messageList;
	}
	
	//채팅방커스텀목록 가져오기
	@GetMapping(value="/chatRoomCustomList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ChatRoomCustomVO> roomCustomList(@RequestParam("empId") String empId,Model model) {

		List<ChatRoomCustomVO> chatRoomList = messageService.retrieveChatRoomCustomList(empId);
		System.out.println("여기옴?");
		model.addAttribute("chatRoomList", chatRoomList);
		return chatRoomList;
	}
	
	    //사원리스트
	    @GetMapping(value="/allEmployeeList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	    @ResponseBody
	    public List<EmployeeVO> Employee(Authentication authentication){
	    	EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
	    	List<EmployeeVO> EmployeeList 
	    	= EmployeeService.allRetrieveEmployeeList(adapter.getRealUser().getComCode());
	    	
	    	return EmployeeList;
	    }
	 
	    //사원리스트 프로필사진
		@RequestMapping(value="/chatProfileInfo.do")
		public String selectEmpProfileImage(Authentication authentication
										,@RequestParam("empId") String empId
										, Model model) {
			
			
			AttatchVO attatch = service.retrieveMyInfo(empId);
			
			model.addAttribute("attatch", attatch);
			
			return "ImageView";
		}	    
	    
	    
	    //채팅방 + 메세지 생성
	  	@PostMapping(value="/insertChatRoom.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	    @ResponseBody
	    public ChatRoomVO roomCreate(@RequestParam("empId[]") String[] empId
	    							,@RequestParam("empNm[]") String[] empNm
	    							 ,Authentication authentication){
	  		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
			
			String myId = adapter.getRealUser().getEmpId();
			
	  		String str = Arrays.toString(empNm);
	  		String str2 = str.substring(0, str.length() - 1);
	  		String roomName = str2.substring(1,str2.length()).replaceAll(" ","");
	  		ChatRoomVO room = new ChatRoomVO();
	  		//룸생성
	  		room.setRoomName(roomName);
      	    chatRoomService.createChatRoom(room);
      	    MessageVO message = new MessageVO();
      	    //본인 저장
      	    message.setEmpId(myId);
			message.setRoomId(room.getRoomId());
			message.setMsgNew("0");
			messageService.createMessage(message);

			//초대한 사람 저장
	  		for(String emp : empId) {

	  			message.setEmpId(emp);
	  			message.setRoomId(room.getRoomId());
	  			message.setMsgNew("1");
	  			messageService.createMessage(message);
	  		//알림 생성 및 Push하는 모듈
	  			notifyService.notifyInsertModule(emp, 0);
	  			
	   		}
	  	    return room;
	    }
	  	
	  
		//방이름 변경
	    @PostMapping(value="/updateChatRoom.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	    @ResponseBody
	    public ServiceResult updateRoomName(@Validated(UpdateGroup.class)
	    					@ModelAttribute("chatRoom") ChatRoomVO chatRoom
	    					, Errors errors){
	    	ServiceResult result= null;
	    	if(!errors.hasErrors()) {
	    	 result =chatRoomService.modifyChatRoom(chatRoom);
	    	}
	    	 	
	    	
	    	return result;
	    }

	    
	    @PostMapping(value="/updateNewChatRoom.do",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public ServiceResult chatDelete(@Validated(UpdateGroup.class)
										@RequestParam("roomId") Integer roomId
										,Authentication authentication){
	    	EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
			MessageVO message = new MessageVO();
			message.setEmpId(adapter.getRealUser().getEmpId());
			message.setRoomId(roomId);
			ServiceResult result = messageService.updateNewChatRoom(message);

			return result;

		}

}