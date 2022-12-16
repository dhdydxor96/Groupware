<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>    
    <script src="${cPath}/resources/FullCalendar/vendor/js/moment.min.js"></script>
    
  
<!-- ===============================================-->
<!--    JavaScripts-->
<!-- ===============================================-->
<script src="${pageContext.request.contextPath}/resources/groupware/vendors/popper/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/groupware/vendors/bootstrap/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/groupware/vendors/anchorjs/anchor.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/groupware/vendors/is/is.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/groupware/vendors/echarts/echarts.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/groupware/vendors/fontawesome/all.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/groupware/vendors/lodash/lodash.min.js"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
<script src="${pageContext.request.contextPath}/resources/groupware/vendors/list.js/list.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/groupware/assets/js/theme.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/bootstrap-notify.min.js"></script>
<script src="${cPath }/resources/toast/js/toastr.min.js"></script>

<!-- 시큐리티 설정 -->
	<security:authorize access="isAuthenticated()">
				<security:authentication property="principal" var="principal"/>
	</security:authorize>
<!-- 알림기능 전용 -->
<script type="text/javascript">
	// toast setting================================
	toastr.options.positionClass="toast-top-center";
	toastr.options.timeOut = 2000;
	// =============================================

	console.log("connect"+connect);

	  let headers2 = {}
      let SUB_ID2 = null;
	  let client2 = null;
	 
	  if(connect=="OK"){
	  init2(event);		
	  }
	 //stomp 연결 
	function init2(event) {
		// stomp-endpoint로 양방향 통신 연결 수립
			
		let roomId = event;
		var sockJS =
			new SockJS("${cPath}/stomp/echo");
		// sockJS 연결 기반하에 Stomp client2 객체 생성
		client2 = Stomp.over(sockJS);
		// Stomp CONNECT frame 전송
		client2.connect(headers2, function (connectFrame) {
			console.log("headers2"+headers2);
			// CONNECTED frame 을 받은 후,
			// echo 메시지 프레임을 수신을 위한
			// SUBSCRIBE frame에서 사용할 구독 아이디를 생성하기 위해
			// 구독 요청 핸들러 쪽으로 전송되는 SUBSCRIBE frame
			// 단 한번의 응답만을 수신함.
			client2.subscribe("/app/handledEcho", function (messageFrame) {
				console.log("1");
				console.log(messageFrame);
				SUB_ID2 = messageFrame.body;
				headers2.id = SUB_ID2;
				
				if(SUB_ID2==headers2.id){
					fn_subScribe2();
				}
				
			});
		}, function (error) {
			console.log(error);
			
		});
	}	
		

	  //미리 내가 가지고 있는 방 구독
	  function fn_subScribe2(init){	
			$.ajax({
				url : "${cPath }/groupware/chat/chatRoomList.do",
				data : {empId : "${principal.realUser.empId}"},
				method : "get",
				dataType : "json", 
				success : function(resp) {
					let messageList = resp;
				
					console.log("messageList"+messageList);
					
					let texts =[];
					
					$.each(messageList, function(index,message){
						let chatRoom = message.chatRoomList;
						console.log(chatRoom[0].roomId);
						subscribe2(chatRoom[0].roomId);
					});
				  },
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
		  };	
		
		  
			//구독 메세지 
			function subscribe2(roomId) {
				client2.subscribe("/topic/echoed/"+roomId, function (messageFrame) {
					//body = messageVO임
					let body = JSON.parse(messageFrame.body);
					let localId= "${principal.realUser.empId}"+body.roomId;
					
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
					let messageFinal = messageInputArea2(body);
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
				
				}, { id: SUB_ID2 });
				
			}	
			
			//보낸 메세지와 받은 메세지 집어 넣고 검증하여 리턴
			function messageInputArea2(body) {
				let messageUserBody ="";       
				messageUserBody += `<div class="d-flex p-3">
									  <div class="avatar avatar-xl me-3">`;
//	 				messageUserBody += 		 "<span>"++"</span>";
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
					if (body.empId == SUB_ID2){
						return messageMyBody;
					}else{
						return messageUserBody;
					}
			}			

</script>