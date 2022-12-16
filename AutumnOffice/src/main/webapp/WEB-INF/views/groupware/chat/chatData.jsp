<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

	<!-- 시큐리티 설정 -->
	<security:authorize access="isAuthenticated()">
				<security:authentication property="principal" var="principal"/>
	</security:authorize>
  

          <div class="card card-chat overflow-hidden">
            <div class="card-body d-flex p-0 h-100">
              <div class="chat-sidebar">
                <div class="contacts-list scrollbar-overlay">
                  <div id="roomList" class="nav nav-tabs border-0 flex-column" role="tablist" aria-orientation="vertical">

                   
<!--             대화방목록 나오는 부분 -->
				  	<input type="button" value="대화생성하기"  id="employeeList"
                class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#tooltippopovers" >
				  </div>
                </div>
                
                
                <form class="contacts-search-wrapper">
                  <div class="form-group mb-0 position-relative d-md-none d-lg-block w-100 h-100">
                    <input class="form-control form-control-sm chat-contacts-search border-0 h-100" type="text" placeholder="Search contacts ..." /><span class="fas fa-search contacts-search-icon"></span>
                  </div>
                  <button class="btn btn-sm btn-transparent d-none d-md-inline-block d-lg-none"><span class="fas fa-search fs--1"></span></button>
                </form>
              </div>
<!--        =====================================================여기까지 대화방 리스트=========================  -->
              
              
              
              
              <div class="tab-content card-chat-content">
<!--                 <div class="tab-pane card-chat-pane active" id="chat-0" role="tabpanel" aria-labelledby="chat-link-0"> -->
                <div class="tab-pane card-chat-pane active" >
                  <div class="chat-content-header">
                    <div class="row flex-between-center">
                      <div class="col-6 col-sm-8 d-flex align-items-center"><a class="pe-3 text-700 d-md-none contacts-list-show" href="#!">
                          <div class="fas fa-chevron-left"></div>
                        </a>
                        <div class="min-w-0">
                          <h5 class="mb-0 text-truncate fs-0">Antony Hopkins</h5>
                        
                        </div>
                      </div>
                      
                      <div class="col-auto">
                      
                        <button class="btn btn-sm btn-falcon-primary btn-chat-info" type="button" data-index="0" data-bs-toggle="tooltip" data-bs-placement="top" title="Conversation Information"><span class="fas fa-info"></span></button>
                    
                      </div>
                    </div>
                  
                  </div>
                 
                  <div class="chat-content-body" style="display: inherit;">

          		   <div id="messageArea" class="chat-content-scroll-area scrollbar">

           		  </div>

                </div>
                
                

              
              </div>
            </div>
          </div>
         </div> 
      
        
  <!--  모달창 -->
<div class="modal fade" id="tooltippopovers" tabindex="-1" aria-labelledby="tooltippopoversLabel" aria-hidden="true">
  <div class="modal-dialog mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1"><button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button></div>
<!--       <div class="modal-body"> -->
        <div class="bg-light rounded-top-lg py-3 ps-4 pe-6">
          <h4 class="mb-1" id="tooltippopoversLabel">멤버리스트</h4>
        </div>
        <div class="p-4 pb-0">
          <div class="row">
            <div class="col">
            	<ul id="modalList">
            	
            	
            	</ul>
  <input type="submit" class="btn btn-secondary" id="create" value="개설하기"/>
             
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>


  <script>
  
  
// 	alert("${principal.realUser.empId}");
	
	
	$.ajax({
		url : "${cPath }/groupware/chat/chatRoomList.do",
		data : {empId : "${principal.realUser.empId}"},
		
		method : "get",
		
		dataType : "json", // Accept vs Content-Type
		success : function(resp) {
		let messageList = resp;
		
			console.log(messageList);
			let texts =[];
		
			$.each(messageList, function(index,message){
				let chatRoom = message.chatRoomList;
			    
				let text = "";
				text +=	"<div class='hover-actions-trigger chat-contact nav-item roomList' role='tab' id="+chatRoom[0].roomId+" data-bs-toggle='tab' data-bs-target='#chat-0' aria-controls='chat-0' aria-selected='true'>";
				text +=  "<input type='hidden' name='chatRoom' value="+chatRoom[0].roomId+">";    
				text +=                      `<div class="d-md-none d-lg-block">
		                                    <div class="dropdown dropdown-active-trigger dropdown-chat">
		                                      <button class="hover-actions btn btn-link btn-sm text-400 dropdown-caret-none dropdown-toggle end-0 fs-0 mt-4 me-1 z-index-1 pb-2 mb-n2" type="button" data-boundary="viewport" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="fas fa-cog" data-fa-transform="shrink-3 down-4"></span></button>
		                                      <div class="dropdown-menu dropdown-menu-end border py-2 rounded-2">
		                                        <a class="dropdown-item" href="#!">Archive</a>
		                                        <a class="dropdown-item text-danger" href="#!">Delete</a>
		                                      </div>
		                                    </div>
		                                  </div>
		            
		                                  <div class="d-flex p-3">
		                                    <div class="avatar avatar-xl status-online">
		            <!--                         여기 프로필사진 -->
		            					   </div>
		                                    <div class="flex-1 chat-contact-body ms-2 d-md-none d-lg-block">
		                                      <div class="d-flex justify-content-between">`;
		         text +=                      " <h5  class='mb-0 chat-contact-title'>"+chatRoom[0].roomName+"</h5>";
		                                       
		         text +=                   " </div>"      ;
		         text += 			 " </div>"            ;
		         text +=             " </div>"            ;
		         text +=             " </div>"            ;
				
			texts.push(text);
				
			});
			$("#roomList").append(texts);
				
			
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
  
  
	$("#employeeList").on("click", function(){
		$.ajax({
			url : "${cPath }/groupware/chat/allEmployeeList.do",
			
//	 		url : cf_getContextPath()+"/chat/allemployeeList.do",
			method : "get",
			
			dataType : "json", // Accept vs Content-Type
			success : function(resp) {
				$("#modalList").empty();
				console.log(resp);
				
			
							
				let list = resp;
				let texts =[];
				$.each(list, function(index,employee){
				
				let url = "${cPath }/groupware/chat/chat.do?roomId="+employee.empId+"&roomName="+employee.empNm 

				 let text = $("<li>").html(
					 		$("<input>")
				 			.attr("type","checkbox")
				 			.attr("name","empId")
				 			.attr("value",employee.empId)
				 			.attr("data-name",employee.empNm)
				 			).append(employee.empNm+"상태:"+employee.empSta);
					texts.push(text);
							
				});
				console.log(texts);

				$("#modalList").append(texts);

			
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
		
	});	
	
	//대화상대 초대 
	$(document).on("click","#create",function(event){
		
		event.preventDefault();
		let empIds = [];
		let empNames = [];
		$("[name=empId]:checked").each(function(){
			let checkempId = $(this).val();
			let checkempName = $(this).data("name");
			empNames.push(checkempName);
			empIds.push(checkempId);
		});

	    
		$.ajax({
			url : "${cPath }/groupware/chat/insertChatRoom.do",
			method : "post",
			data : {"empId" : empIds,"empNm" : empNames},
			dataType : "json", // Accept vs Content-Type
			
			success : function(resp) {
				let chatRoom = resp;
				location.href= "${cPath }/groupware/chat/chat.do?roomId="+chatRoom.roomId+"&roomName="+chatRoom.roomName;
		
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
		return false;
	});
	
  
 //대화방 클릭
  $(document).on('click','.roomList',function(){
	let value = $(this).find(":input[name]");
    console.log(value.val());
    init(event);



  });
  
  $(document).on('click','#b001',function(){
	  $("#messageArea").empty();
	  let message2 = `
			

		  
		    
		                      
		   
		   
		                       <div class="chat-content-scroll-area scrollbar">
		                    		

		   <!--                      ========================상대 대화박스================================ -->
		                         <div class="d-flex p-3">
		                           <div class="avatar avatar-l me-3">
		                          		 <span>찬솔</span>
		   						</div>
		                           <div class="flex-1">
		                             <div class="w-xxl-75">
		                               <div class="hover-actions-trigger d-flex align-items-center">
		                                 <div class="chat-message bg-200 p-2 rounded-2">야 이거 바뀐거지</div>
		                           	</div>
		                               <div class="text-400 fs--2"><span>11:54 am</span>
		                               </div>
		                             </div>
		                           </div>
		                         </div>
		   
		    
		         
		   <!--                      ========================내 대화박스================================ -->		                         
		                         <div class="d-flex p-3">
		                           <div class="flex-1 d-flex justify-content-end">
		                             <div class="w-100 w-xxl-75">
		                               <div class="hover-actions-trigger d-flex flex-end-center">
		                                 <div class="bg-primary text-white p-2 rounded-2 chat-message light">어렵네
		                                 </div>
		                               </div>
		                               <div class="text-400 fs--2 text-end">11:54 am<span class="fas fa-check-double ms-2"></span>
		                               </div>
		                             </div>
		                           </div>
		                         </div>
		                         
		                     
		                         
		                       </div>
		                       
		                       
		                       <form class="chat-editor-area">
		                       <div class="emojiarea-editor outline-none scrollbar" contenteditable="true"></div>
		                       <input class="d-none" type="file" id="chat-file-upload" />
		                       <label class="chat-file-upload cursor-pointer" for="chat-file-upload"><span class="fas fa-paperclip"></span></label>
		                       <div class="btn btn-link emoji-icon" data-emoji-button="data-emoji-button"><span class="far fa-laugh-beam"></span></div>
		                       <button class="btn btn-sm btn-send shadow-none" type="submit">Send</button>
		                     </form>
		                       `
		                         
		                 
  $("#messageArea").append(message2);
  });
  
  
  </script>
  
  <script type="text/javascript">
		
	
	    let localId = "${principal.realUser.empId}"+"${roomId}";
	    
		let client = null;
		let headers = {}
		let messageArea = document.querySelector("#messagesArea");
// 		if(localStorage.getItem("messageArea")!=null){
		messageArea.innerHTML = localStorage.getItem("messageArea"+localId);
// 		}
		let SUB_ID = null;
		
		function init(event) {
			// stomp-endpoint로 양방향 통신 연결 수립


			var sockJS =
				new SockJS("${cPath}/stomp/echo");
			// sockJS 연결 기반하에 Stomp client 객체 생성
			client = Stomp.over(sockJS);
			// Stomp CONNECT frame 전송
			client.connect(headers, function (connectFrame) {
				console.log(headers);
				// CONNECTED frame 을 받은 후,
				// echo 메시지 프레임을 수신을 위한
				// SUBSCRIBE frame에서 사용할 구독 아이디를 생성하기 위해
				// 구독 요청 핸들러 쪽으로 전송되는 SUBSCRIBE frame
				// 단 한번의 응답만을 수신함.
				client.subscribe("/app/handledEcho", function (messageFrame) {
					console.log("1");
					console.log(messageFrame);
					SUB_ID = messageFrame.body;
					headers.id = SUB_ID;
					
					
					connectMessageSend(); //입장메세지
					// Simple Message Broker 로 부터 브로드캐스팅 되는
					// 에코 메시지를 구독하기 위한 SUBSCRIBE frame 전송
					client.subscribe("/topic/echoed/${roomId}", function (messageFrame) {
						console.log("3");
						
						let body = JSON.parse(messageFrame.body);
						let msgTag = document.createElement("p");
						if (body.empId == SUB_ID)
							msgTag.classList.add("my"); //my 라는 class를 추가
						msgTag.innerHTML =
							body.msgCon + "[" + body.empId + "]"; // 메시지와 발신자 표시
						messageArea.appendChild(msgTag); //messageArea 에 데이터 쌓기

						localStorage.setItem("messageArea"+localId,messageArea.innerHTML);
						
						console.log("unma :" + localStorage.getItem("messageArea"+localId));
// 						messageArea.innerHTML = localStorage.getItem("messageArea");

					}, { id: SUB_ID });
					
			
		
				});
				let msgTag = document.createElement("p");
				msgTag.innerHTML = "연결완료";
				messageArea.appendChild(msgTag);
			}, function (error) {
				console.log(error);
				alert(error.headers.message);
			});
		}
		function messageSend(event) {
			let rmId = "${roomId}";//room.jsp에서 온 데이타임
			if (!client || !client.connected) throw "stomp 연결 수립 전";
			let body = {
				roomId : rmId					
				,empId: SUB_ID
				, msgCon: event.target.value
			}
			console.log("bodytest : "+body);
			// 서버사이드의 메시지 처리 없이 에코되는 메시지 전송
			// client.send("/topic/echoed", headers, JSON.stringify(body));
			// 서버사이드의 메시지 핸들러에서 처리될 메시지 전송
			client.send("/app/handledEcho", headers, JSON.stringify(body));
			console.log("2");
			console.log("2 : "+event.target.value);
		
			event.target.value = ""; //대화창 비우기
			event.target.focus();
		}
		function connectMessageSend() {
			let rmId = "${roomId}";
			if (!client || !client.connected) throw "stomp 연결 수립 전";
		
			let body = {
				roomId : rmId					
				,empId: SUB_ID
				, msgCon: "${principal.realUser.empNm}" + "님이 입장하셨습니다."
			}
			client.send("/app/handledEcho", headers, JSON.stringify(body));
		}
		function disconnectMessageSend() {
			let rmId = "${roomId}";
			if (!client || !client.connected) throw "stomp 연결 수립 전";
		
			let body = {
				roomId : rmId					
				,empId: SUB_ID
				, message: "${principal.realUser.empNm}" + "님이 퇴장하셨습니다."
			}
			client.send("/app/handledEcho", headers, JSON.stringify(body));
		}
		
		function disconnect(event) {
			if (!client || !client.connected) throw "stomp 연결 수립 전";
			disconnectMessageSend();
			client.disconnect();
			let msgTag = document.createElement("p");
			msgTag.innerHTML = "연결종료";
			messageArea.appendChild(msgTag);
			
		}
		window.addEventListener("unload",disconnect);
	</script>



    


