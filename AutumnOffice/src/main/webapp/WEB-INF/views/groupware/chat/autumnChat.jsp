<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
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
  
  
    <div class="container">
   
            <div>
            	 <p>채팅방</p>
                <ul id="roomList">
				
                </ul>
                 
            </div>
        </div>
 		<input type="button" value="+"  id="employeeList"
                class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#tooltippopovers" >
        <form id="createForm"  method="post">
            <input type="text" name="name" class="form-control">
            <input type="submit" class="btn btn-secondary" value="개설하기"/>
        </form>
 
 
<!--  모달창 -->
<div class="modal fade" id="tooltippopovers" tabindex="-1" aria-labelledby="tooltippopoversLabel" aria-hidden="true">
  <div class="modal-dialog mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1"><button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
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
</div>
 
	<script type="text/javascript">
		alert("${principal.realUser.empId}");
		
	
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
					let viewURL = "${cPath }/groupware/chat/chat.do?roomId="+chatRoom[0].roomId+"&roomName="+chatRoom[0].roomName;
					 let text =  $("<li>").html(
							$("<a>").attr("href",viewURL)
							.attr("id","room")
							.attr("data-value",chatRoom[0].roomId)
							.text(chatRoom[0].roomName)
							);
				
					 
				texts.push(text);
					
						
					
					
				});
				$("#roomList").append(texts);
					
				
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
// 	});	
		
 </script>
<script>
$("#createForm").on("submit", function(event){
	event.preventDefault();
	
	let method = this.method;
	let data = $(this).serialize();
	$.ajax({
		url : "${cPath }/chat/roomCreate.do",
		method : method,
		data : data,
		dataType : "json", // Accept vs Content-Type
		success : function(resp) {
			
// 			location.href = "${cPath }/chat/room.do";
			let chatRoom = resp;
			
			let viewURL = "${cPath }/groupware/chat/chat.do?roomId="+chatRoom.roomId+"&roomName="+chatRoom.roomName;
			
				let room = $("<li>").html($("<a>").attr("href", viewURL)
											.text(chatRoom.roomName));
				
			let ul = $("#roomList");
			
			ul.prepend(room);
			},
		
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	})
	return false;
});

$("#employeeList").on("click", function(){
	$.ajax({
		url : "${cPath }/groupware/chat/allEmployeeList.do",
		
// 		url : cf_getContextPath()+"/chat/allemployeeList.do",
		method : "get",
		
		dataType : "json", // Accept vs Content-Type
		success : function(resp) {
			console.log(resp);
			
		
						
			let list = resp;
			let texts =[];
			$.each(list, function(index,employee){
			
			let url = "${cPath }/groupware/chat/chat.do?roomId="+employee.empId+"&roomName="+employee.empNm 

// 				let text =  $("<li>").html(
// 							$("<a>").attr("href",url)
// 							.attr("id","amem")
// 							.attr("data-value",employee.empSta)
// 							.text(employee.empNm+"상태:"+employee.empSta)
// 							);

			 let text = $("<li>").html(
				 		$("<input>")
			 			.attr("type","checkbox")
			 			.attr("name","empId")
			 			.attr("value",employee.empId)
			 			).append(employee.empNm+"상태:"+employee.empSta);
				texts.push(text);
						
			});
			console.log(texts);
// 			$("#onLineUser").append(texts);
			$("#modalList").append(texts);

		
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	})
	
});

// let token = $("meta[name='_csrf']").attr("content");
// let header = $("meta[name='_csrf_header']").attr("content");

$(document).on("click","#create",function(event){
	
	event.preventDefault();
	let empIds = [];
	$("[name=empId]:checked").each(function(){
		let checkempId = $(this).val();
		empIds.push(checkempId);
	});
	

//     $.ajaxSetup({
//         beforeSend: function(xhr) {
//             if (!/^(GET|HEAD|OPTIONS)$/i.test(settings.type) && !this.crossDomain) {
//                 xhr.setRequestHeader(header, token)
//             }
//         }
//     });
    
	$.ajax({
		url : "${cPath }/groupware/chat/insertChatRoom.do",
		
// 		url : cf_getContextPath()+"/chat/allemployeeList.do",
		method : "post",
		data : {"empId" : empIds},
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

</script>