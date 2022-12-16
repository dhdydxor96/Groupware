<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>


	<style type="text/css">
		.my {
			background-color: yellow;
		}
	</style>
	<!-- 시큐리티 설정 -->
	<security:authorize access="isAuthenticated()">
				<security:authentication property="principal" var="principal"/>
	</security:authorize>

<body onload="init(event);">
	
<%-- 	<c:forEach var="chatRoomVO" items="${chatList}"> --%>
<%--     <p><c:out value="${chatRoomVO.roomName}" /></p> --%>
<%-- 	</c:forEach> --%>
<!-- 	파라미터로 roomName과 roomId를 받았음 -->
	<p>대화방 제목 :${roomName}</p> 
	<input type="text" id="message" onchange="messageSend(event);" />
	<input type="button" value="종료" onclick="disconnect(event);">
	<div id="messagesArea"></div>
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

						localStorage.setItem("messageArea"+localId
								,messageArea.innerHTML);
						
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
</body>
