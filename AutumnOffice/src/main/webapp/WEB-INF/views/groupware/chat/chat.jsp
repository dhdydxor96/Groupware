<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

	<!-- 시큐리티 설정 -->
	<security:authorize access="isAuthenticated()">
				<security:authentication property="principal" var="principal"/>
	</security:authorize>
  
<style>
#modalList {
    list-style: none;
    padding-left: 0px;
}
span {
    font-family: 'IBM Plex Sans KR', sans-serif;
    font-size: 12px; 
}
div {
    font-family: 'IBM Plex Sans KR', sans-serif;
}

</style>

          <div class="card card-chat overflow-hidden" >
            <div class="card-body d-flex p-0 h-100">
              <div class="chat-sidebar">
                <div class="contacts-list scrollbar-overlay">
                  <div id="roomList" class="nav nav-tabs border-0 flex-column" role="tablist" aria-orientation="vertical">              
                <!--대화방목록 나오는 부분 -->
                    
<!-- 				  	<input type="button" value="대화생성하기"  id="employeeList" class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#tooltippopovers" > -->
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
                <div class="tab-pane card-chat-pane active" >                
                  <div class="chat-content-body" style="display: inherit;">
          		    <div id="messageArea" class="chat-content-scroll-area scrollbar">
          		    
<!-- 	          		  	대화들어올곳 -->
           		    </div>
					   		 <form class="chat-editor-area" id="messageSend">
		                       <div id="msgForm" class="emojiarea-editor outline-none scrollbar" contenteditable="true"></div>
		                       <input class="d-none" type="file" id="chat-file-upload" />
		                       <label class="chat-file-upload cursor-pointer" for="chat-file-upload"><span class="fas fa-paperclip"></span></label>
		                       <div class="btn btn-link emoji-icon" data-emoji-button="data-emoji-button"><span class="far fa-laugh-beam"></span></div>
		                       <input type="hidden" id="hiddenId">
		                       <input class="btn btn-sm btn-send shadow-none" type="button" onclick="fn_localStorageClear();" value="clear">
		                       <input class="btn btn-sm btn-send shadow-none" type="submit" value="Send">
<!-- 		                       <input class="btn btn-sm btn-send shadow-none" type="button" value="Exit" id="exit"> -->
		                     </form>
                 </div>         
              </div>
            </div>
          </div>
         </div> 
      
        
  <!--  모달창 -->
<div class="modal fade" id="tooltippopovers" tabindex="-1" aria-labelledby="tooltippopoversLabel" aria-hidden="true">
  <div class="modal-dialog mt-2 modal-dialog-centered" role="document">
    <div class="modal-content border-0" style="
    width: 63%; modal-dialog:center;">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1"><button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button></div>
<!--       <div class="modal-body"> -->
        <div class="bg-light rounded-top-lg py-3 ps-4 pe-6">
          <h4 class="mb-1" id="tooltippopoversLabel">사원리스트</h4>
        </div>
        <div class="p-4 pb-0 ">
          <div class="row ">
            <div class="col "  style="max-height: calc(100vh - 200px); overflow-x: hidden; overflow-y: auto;">
        
            	<ul id="modalList" >
            
            	</ul>
   				<hr>
                 
                 <div class="mb-3">
                 <button class="btn btn-outline-primary me-1 mb-1" type="submit" id="create" name="submit"  style="width:100%; font-weight:bold;  font-family: 'IBM Plex Sans KR', sans-serif;">초대하기</button>
                 </div>
             
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>



<script defer="defer">
  connect = "false";


  let localId = "";
  
  let headers = {}

  let SUB_ID = null;
  let client = null;
  fn_roomList(); 

  init(event);
  
			  
  let messageArea = document.querySelector("#messagesArea");
  let $messageSend = $("#messageSend"); 

//input 엔터키 이벤트
  $messageSend.keydown(function(key) {
  	if( key.keyCode == 13 ){
  		key.preventDefault();//엔터키 막기
  		$messageSend.submit();
  	}
  });
  
  //채팅방 목록 불러오기
  function fn_roomList() {	
	let empId =  "${principal.realUser.empId}";
	
	$.ajax({
// 		url : "${cPath }/groupware/chat/chatRoomList.do",
		url : "${cPath }/groupware/chat/chatRoomCustomList.do",
		data : {empId : "${principal.realUser.empId}"},
		
		method : "get",
		
		dataType : "json", // Accept vs Content-Type
		success : function(resp) {

		let messageList = resp;
		
			console.log(messageList);
			let texts =[];
		
				let text = "";
				text += "<input type='button' value='대화생성하기'  id='employeeList' class='btn btn-primary' type='button' data-bs-toggle='modal' data-bs-target='#tooltippopovers' style=\"font-family:'IBM Plex Sans KR', sans-serif;\">"
				
			$.each(messageList, function(index,message){
				let chatRoom = message;
				
			    
				
				text +=	"<div class='hover-actions-trigger chat-contact nav-item roomList mainDiv' role='tab' id="+chatRoom.roomId+" data-bs-toggle='tab' data-bs-target='#chat-0' aria-controls='chat-0' aria-selected='true'>";
				text +=  "<input type='hidden' name='chatRoom' value="+chatRoom.roomId+">";    
				text +=                      `<div class="d-md-none d-lg-block">
		                                    <div class="dropdown dropdown-active-trigger dropdown-chat">
		                                      <button class="hover-actions btn btn-link btn-sm text-400 dropdown-caret-none dropdown-toggle end-0 fs-0 mt-4 me-1 z-index-1 pb-2 mb-n2" type="button" data-boundary="viewport" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="fas fa-cog" data-fa-transform="shrink-3 down-4"></span></button>
		                                      <div class="dropdown-menu dropdown-menu-end border py-2 rounded-2">`
		         text +=                        "<a class='dropdown-item' href='#!' id='reNameRoom' data-value="+chatRoom.roomId+">Rename</a>";		                                        
		         text +=                        "<a class='dropdown-item text-danger' href='#!' id='deleteRoom' data-value="+chatRoom.roomId+">Delete</a>";
		         text +=                        `</div>
		                                    </div>
		                                  </div>
		            
		                                  <div class="d-flex p-3">
		                                    <div class="avatar avatar-xl">`;
		            <!--                         여기 프로필사진 -->
		            if(chatRoom.empList.length>=3){
		            	text += "";
			         text += 	"<div class='rounded-circle overflow-hidden h-100 d-flex'>"
	                 text +=   "<div class='w-50 border-end'><img src='${cPath}/groupware/chat/chatProfileInfo.do?empId="+chatRoom.empList[0].empId+"' onerror=\"this.src='${cPath}/resources/groupware/assets/img/profile_user_example.png'\"></div>";
	                 text +=   "<div class='w-50 d-flex flex-column'><img class='h-50 border-bottom' src='${cPath}/groupware/chat/chatProfileInfo.do?empId="+chatRoom.empList[1].empId+"' onerror=\"this.src='${cPath}/resources/groupware/assets/img/profile_user_example.png'\">";
	                 text +=    "<img class='h-50' src='${cPath}/groupware/chat/chatProfileInfo.do?empId="+chatRoom.empList[2].empId+"' onerror=\"this.src='${cPath}/resources/groupware/assets/img/profile_user_example.png'\"></div>"
	                 text += 	"</div>";
		            }else{
			            $.each(chatRoom.empList, function(index,emp){
			            	if(emp.empId==empId){
			            		return;
			            	}else{
			            		text += "<img class='rounded-circle' src='${cPath}/groupware/chat/chatProfileInfo.do?empId="+emp.empId+"' onerror=\"this.src='${cPath}/resources/groupware/assets/img/profile_user_example.png'\">";
			            	}
			            })
		            	
		            }
		           
		         text +=`   			</div>
		                                    <div class="flex-1 chat-contact-body ms-2 d-md-none d-lg-block">
		         								<div class='d-flex justify-content-between' id='renameDiv'>`;
		         text +=                      " <h5  class='mb-0 chat-contact-title'>"+chatRoom.roomName+"</h5>";
		         
		         $.each(chatRoom.empList, function(index,message){
		        	 if(message.empId==empId&&message.msgNew=='1'){
		        		 let msgNewRoomId = "msgNew"+chatRoom.roomId;
		        		 text +=	"<span data-value="+msgNewRoomId+" class='badge badge-soft-success badge-pill ms-2'>NEW</span>";
		        	 }else{
		        		 return;
		        	 }
		         })       
		                                       
		         text +=                   " </div>"      ;
		         text += 			 " </div>"            ;
		         text +=             " </div>"            ;
		         text +=             " </div>"            ;
				
				
			});
			texts.push(text);
			$("#roomList").empty();
			$("#roomList").append(texts);
			
			$("#messageArea").empty(); //채팅방 나가기 했을때 대화창 비우기위해 비웠음
			
			
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
  };
  
  //미리 내가 가지고 있는 방 구독
  function fn_subScribe(init){	
		$.ajax({
			url : "${cPath }/groupware/chat/chatRoomList.do",
			data : {empId : "${principal.realUser.empId}"},
			method : "get",
			dataType : "json", // Accept vs Content-Type
			success : function(resp) {
				
				let messageList = resp;
			
				console.log("messageList"+messageList);
				
				let texts =[];
				
				$.each(messageList, function(index,message){
					let chatRoom = message.chatRoomList;
					subscribe(chatRoom[0].roomId);
				});
			  },
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	  };
  
  
  
  //모달창에 사원리스트 넣기
	$(document).on("click", "#employeeList", function(){
		let empId =  "${principal.realUser.empId}";
		$.ajax({
			url : "${cPath }/groupware/chat/allEmployeeList.do",
			method : "get",
			dataType : "json", // Accept vs Content-Type
			success : function(resp) {
				$("#modalList").empty();

				let list = resp;
				let texts =[];
				let sta ="";
				$.each(list, function(index,employee){
					console.log(employee);
				switch (employee.empSta) {
				  case '0':
				    sta ="status-offline";
				    break;
				  case '1':
					sta ="status-online";
					break;
				  case '2':
					sta ="status-away";
					break;
				};
				
				if(employee.empId==empId) return;//본인은 제오
			    
				let text = $("<li>")
					 		.html(
					 			$("<div>")
							 	.attr("class","avatar avatar-xl "+sta)
							 	.html(
							 		$("<img>")
							 		.attr("class","rounded-circle")
							 		.attr("src","${cPath}/groupware/chat/chatProfileInfo.do?empId="+employee.empId)
							 		.attr("onerror","this.src='${cPath}/resources/groupware/assets/img/profile_user_example.png'")
							 	)
				 			).append(
				 					$("<span>")
				 					.attr("class","fw-bold ms-2")
				 					.html(employee.empNm+"  "+employee.job.jobNm+"&nbsp"+"<span class='badge badge-soft-secondary'>"+employee.department.depNm+"</span>"+"&nbsp&nbsp")
				 					)
				 			.append(
				 				$("<input>")
					 			.attr("type","checkbox")
					 			.attr("name","empId")
					 			.attr("value",employee.empId)
					 			.attr("data-name",employee.empNm)
					 			.attr("data-sta",employee.empSta)
				 			);
				
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
	
	//대화상대 초대 추가 방생성
	$(document).on("click","#create",function(event){
		event.preventDefault();
		
		
		let empIds = [];
		let empNames = [];
		$("[name=empId]:checked").each(function(){
			let checkempId = $(this).val();
			let checkempName = $(this).data("name");
			let empSta = $(this).data("sta");
			if(empSta=='0'){
				empIds.push("fail");
				return;
			}
			empNames.push(checkempName);
			empIds.push(checkempId);
		});
		if(empIds.includes("fail")){
			toastr.error("비접속자와는 대화를 할 수 없습니다!");
			return;
		}
		if(empIds[0]==null){
			toastr.error("비접속자와는 대화를 할 수 없습니다!");
			return;
		}
			empNames.push("${principal.realUser.empNm}");
	    $.ajax({
			url : "${cPath }/groupware/chat/insertChatRoom.do",
			method : "post",
			data : {"empId" : empIds,"empNm" : empNames},
			dataType : "json", // Accept vs Content-Type
			success : function(resp) {
				fn_roomList();
				$("#tooltippopovers").modal('hide');

		
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
	 	let span = $(this).find("span");
		
	 	if(span.data("value")!=null){
			
			
	 		$.ajax({
	 			url : "${cPath }/groupware/chat/updateNewChatRoom.do",
	 			method : "post",
	 			data : {"roomId" : value.val()},
	 			dataType : "json",
	 			success : function(res) {
						
	 				if(res=='OK'){
						
	 					span.remove();	
						
	 				}
		
	 			},
	 			error : function(xhr) {
	 				console.log(xhr.status);
	 			}
	 		});
	 	}
		
		//roomId 넣어놓기
		let localGetId = "${principal.realUser.empId}"+value.val();
		$("#hiddenId").val(value.val());
	    $("#messageArea").empty();
		subscribe(value.val());
		
		let getBody = []; 
		let getFinalMessage ="";
		getBodyObject = localStorage.getItem("messageArea"+localGetId);
		
		if(getBodyObject!=null){
		getBody = JSON.parse(getBodyObject);
		}
		
		console.log("getBody"+getBody[0]);	
		$.each(getBody, function(index,message){
			getFinalMessage += messageInputArea(message);
		});
			console.log("getFinalMessage"+getFinalMessage);
		$("#messageArea").append(getFinalMessage);
	
		
	  });
  
 //대화방 이름 변경에서 input태그로 바꿔주는 로직
  $(document).on('click','#reNameRoom',function(){
	let reNameRoomId = $(this).data("value");
	let mainDiv = $(this).parents(".mainDiv"); // 상위 요소를 일단 찾음
	let renameDiv = mainDiv.find("#renameDiv"); // 찾은 div의 하위요소를 다시 찾음
	renameDiv.empty(); 
	let inputTag = "<input type='text' id='newRoomName' style='width:140px;'>";
		inputTag += "<input class='btn btn-sm btn-send shadow-none' data-value="+reNameRoomId+" type='button' id='change' value='edit'>";
		inputTag += "<input class='btn btn-sm btn-send shadow-none' type='button' id='back' value='back' onclick='fn_roomList();'>";
	renameDiv.html(inputTag);
	$("#newRoomName").focus();

  });
 
 
  //대화방 이름 변경버튼 클릭
  $(document).on('click','#change',function(){
	let roomId = $(this).data("value");
	let roomName = $("#newRoomName").val();
	$.ajax({
		url : "${cPath }/groupware/chat/updateChatRoom.do",
		method : "post",
		data : {"roomId" : roomId, "roomName" : roomName},
		dataType : "json",
		success : function(res) {
			if(res=='OK'){
				fn_roomList()
			}
		},
		error : function(xhr) {
			console.log(xhr.status);
		}
	});

  });
  


  //대화방 삭제
  $(document).on('click','#deleteRoom',function(){
	let roomId = $(this).data("value");
	$.ajax({
		url : "${cPath }/groupware/chat/chatDelete.do",
		method : "post",
		data : {"roomId" : roomId},
		dataType : "json",
		success : function(res) {
				localId= "${principal.realUser.empId}"+roomId;
			if(res=='OK'){
				localStorage.removeItem("messageArea"+localId);
				disconnectMessageSend(roomId);
				fn_roomList()
				
			}

		},
		error : function(xhr) {
			console.log(xhr.status);
		}
	});

  });
  //메세지입력창에서 send 이벤트 
  $messageSend.on('submit',function(event){
	  event.preventDefault();
	 let rmId = $("#hiddenId").val();
	 let msgForm = $("#msgForm").html();
	 let msgForm1 = $("#msgForm").text();
	 if($.trim(msgForm1).length==0){
		 $("#msgForm").empty();
		 return false;
	 }else{
		
	  messageSend(rmId,msgForm);
		 
	 }
	  return false;
  });
  
  //연결 종료하기
  $("#exit").on('click',function(){
	  
	 let rmId = $("#hiddenId").val();
	 disconnect(rmId);
	
  });
  
  
  
  
  
		//stomp 연결 
		function init(event) {
			// stomp-endpoint로 양방향 통신 연결 수립
				console.log("event" + event);
			let roomId = event;
			var sockJS =
				new SockJS("${cPath}/stomp/echo");
			// sockJS 연결 기반하에 Stomp client 객체 생성
			client = Stomp.over(sockJS);
			// Stomp CONNECT frame 전송
			client.connect(headers, function (connectFrame) {
				console.log("headers"+headers);
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

					if(SUB_ID==headers.id){
						fn_subScribe();
					}
					
				});
			}, function (error) {
				console.log(error);
				alert(error.headers.message);
			});
		}
		
		
		
		
		
		

		
		
		
		
		
		
		//구독 메세지 
		function subscribe(roomId) {
			client.subscribe("/topic/echoed/"+roomId, function (messageFrame) {
				//body = messageVO임
				let body = JSON.parse(messageFrame.body);
				localId= "${principal.realUser.empId}"+body.roomId;
				let hiddenId = $("#hiddenId").val();
				
				//구독하면서 미리 그전에 담겨있는 메세지객체를 담는과정
				let parsebox=[];
				let messageBox = [];
				
				let jsonbox = localStorage.getItem("messageArea"+localId);
				if(jsonbox!=null){
				parsebox = JSON.parse(jsonbox);
				}
				//for문으로 메세지객체 담기
				$.each(parsebox, function(index,message){
					messageBox.push(message);
				});
				
				
				//검증구간 통과하면 대화 찍음
				let messageFinal = messageInputArea(body);
				if(body.roomId==hiddenId){
				$("#messageArea").append(messageFinal);
				}
				
				//로컬에 저장하기위한 작업 , 퇴장 메세지라면 저장 안됨
				messageBox.push(body); // 배열에 body 넣기
				console.log("messageBox"+JSON.stringify(body.msgCon));
				
				let stringVal = JSON.stringify(body.msgCon);
			    let substring = "님이 퇴장하셨습니다.";
				//포함여부 후 메세지저장 결정함
				if(stringVal.indexOf(substring)==-1){
				localStorage.setItem("messageArea"+localId, JSON.stringify(messageBox));//
				}
			
			}, { id: SUB_ID });
			
		}
		
		//보낸 메세지와 받은 메세지 집어 넣고 검증하여 리턴
		function messageInputArea(body) {
			let messageUserBody ="";       
			messageUserBody += `<div class="d-flex p-3">
								  <div class="avatar avatar-xl me-3">`;
// 				messageUserBody += 		 "<span>"++"</span>";
				messageUserBody += "<img class='rounded-circle' src='${cPath}/groupware/chat/chatProfileInfo.do?empId="+body.empId+"' onerror=\"this.src='${cPath}/resources/groupware/assets/img/profile_user_example.png'\">";							 	
				messageUserBody +=		`</div>
										 <div class="flex-1">
										   <div class="w-xxl-75">
									     <div class="hover-actions-trigger d-flex align-items-center">`
				messageUserBody +=        "<div class='chat-message bg-200 p-2 rounded-2'>"+body.msgCon+"</div>";
				messageUserBody +=  	`</div>
									
								     <div class="text-400 fs--2">`;
				messageUserBody +=		"<span class='fw-semi-bold me-2'>"+body.empNm+"</span><span>"+body.msgDay+"</span>";
				messageUserBody +=	`</div>
								   </div>
								 </div>
								</div>`;
								
			let messageMyBody ="";
			messageMyBody +=	`<div class="d-flex p-3">
						            <div class="flex-1 d-flex justify-content-end">
						              <div class="w-100 w-xxl-75">
						                <div class="hover-actions-trigger d-flex flex-end-center">`
				messageMyBody +=	      "<div class='bg-primary text-white p-2 rounded-2 chat-message light'>"+body.msgCon;
				messageMyBody +=		   `</div>
						                </div>`;
				messageMyBody +=           "<div class='text-400 fs--2 text-end'>"+body.msgDay+"<span class='fas fa-check-double ms-2'></span>";
				messageMyBody +=	    `</div>
						              </div>
						            </div>
						          </div>`;
				if (body.empId == SUB_ID){
					return messageMyBody;
				}else{
					return messageUserBody;
				}
		}
		
		//핸들러한테 메세지 전달
		function messageSend(hiddenId,msgForm) {
			let rmId = hiddenId;//room.jsp에서 온 데이타임
			let now = nowMsgDay();
			if (!client || !client.connected) throw "stomp 연결 수립 전";
			let body = {
				roomId : rmId					
				,empId: SUB_ID
				, msgCon: msgForm
				,empNm: "${principal.realUser.empNm}"
				,msgDay : now
			

			}
			console.log("bodytest : "+body);
			
			// 서버사이드의 메시지 핸들러에서 처리될 메시지 전송
			client.send("/app/handledEcho", headers, JSON.stringify(body));
			console.log("2");
			console.log("2 : "+msgForm);
		
			$("#msgForm").empty(); //대화창 비우기
			$("#msgForm").focus();
		}
		function connectMessageSend(roomId) {
			let rmId = roomId ;
			if (!client || !client.connected) throw "stomp 연결 수립 전";
		
			let body = {
				roomId : rmId					
				,empId: SUB_ID
				, msgCon: "${principal.realUser.empNm}" + "님이 입장하셨습니다."
			}
			client.send("/app/handledEcho", headers, JSON.stringify(body));
		}
		function disconnectMessageSend(roomId) {
			let rmId = roomId;
			let now = nowMsgDay();
			if (!client || !client.connected) throw "stomp 연결 수립 전";
		
			let body = {
				roomId : rmId					
				,empId: SUB_ID
				, msgCon: "${principal.realUser.empNm}" + "님이 퇴장하셨습니다."
				,empNm: "${principal.realUser.empNm}"
				,msgDay : now
				
				
			}
			client.send("/app/handledEcho", headers, JSON.stringify(body));
		}
		
		function disconnect(event) {
			if (!client || !client.connected) throw "stomp 연결 수립 전";
			disconnectMessageSend(event);
			client.disconnect();
			
			let msgTag = document.createElement("p");
			msgTag.innerHTML = "연결종료";
			messageArea.appendChild(msgTag);
		
			
		}
		//대화삭제
		function fn_localStorageClear() {
			$("#messageArea").empty(); //대화창 비우기
			localId= "${principal.realUser.empId}"+$("#hiddenId").val();
			
			let jsonbox = localStorage.getItem("messageArea"+localId);
			window.localStorage.removeItem("messageArea"+localId);
			
		}
		window.addEventListener("unload",disconnect);
		
		
 //지금 시간 구하기
     function nowMsgDay(){
    	 let today = new Date();
		 
		 let hours = today.getHours();
		 let minutes = today.getMinutes();
		 let h = hours < 12 ? "am" : "pm";
		 let now = hours+":"+minutes+h;
    	 return now;
     }
 

	</script>



    


