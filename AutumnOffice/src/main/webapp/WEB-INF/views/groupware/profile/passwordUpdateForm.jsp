<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
.password-wrapper {
/* 	padding:15px; */
	padding:1%; 
	text-align:center; 
	font-family: 'IBM Plex Sans KR', sans-serif;
}

.writeArea {
	height: 500px;
}

.app-line-wrapper{
	display: flex;
	justify-content: space-between;
	padding-left:10px;
	padding-right:10px;
}
.groupMenu{
	width:200px;
}
.selected-group{
	width:400px;
}
.card{
	padding : 1%;
}
h3{
	font-family: 'IBM Plex Sans KR', sans-serif; 
	font-weight:bold; 
	text-align:left; 
	float:left; 
	font-size:30px;
}
.updateBtn{
	font-family: 'IBM Plex Sans KR', sans-serif; 
	width: 25%;
	font-size: 15px;
	font-weight: bold;
}
#backBtn{
	font-family: 'IBM Plex Sans KR', sans-serif; 
	font-weight: bold; 
	width: 25%; 
	margin-left:5%;
}
</style>

<div class="password-wrapper card md-3">
	<br>
	<h3><span class="fas fa-exchange-alt"></span>&nbsp;비밀번호 변경</h3>
	<hr>
	<br>
	<form id="passwordUpdateForm">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		<table class="table table-bordered" style="width: 90%; margin-left: 5%; vertical-align: middle;">
		<tr>
			<th>현재 비밀번호</th>
			<td>
				<input type="password" name="currentPassword" class="form-control" value="1234" />
			</td>
		</tr>
		<tr>
			<th>새로운 비밀번호</th>
			<td>
				<input type="password" name="newPassword"  class="form-control" value="1324"  />
			</td>
		</tr>
		<tr>
			<th>새로운 비밀번호 확인&nbsp;<span id="check"></span></th>
			<td>
				<input type="password" name="newPasswordConfirm"  onchange="check_pw()"  class="form-control" value="1324" />
			</td>
		</tr>
		</table>
		<br>
		<div class="password-footer">
			<input class="btn btn-outline-primary me-1 mb-1 updateBtn" type="button" value="변경">
			<a class="btn btn-outline-secondary me-1 mb-1" id="backBtn" href="${cPath }/groupware/index.do" >취소</a>
		</div>
	</form>
	<br>
</div>

<script>
	let updateBtn = $(".updateBtn");
	let passwordUpdateForm = $("#passwordUpdateForm");
	
	let currentPassword = $("[name=currentPassword]");
	let newPassword = $("[name=newPassword]");
	let newPasswordConfirm = $("[name=newPasswordConfirm]");
	let check = $("#check");
	
	// ====================================
	// 변경 버튼을 클릭했을 때
	// ====================================
	updateBtn.on('click', function(){

		if(newPassword.val()==newPasswordConfirm.val() 
			&& newPassword.val()!=null && newPasswordConfirm.val() != null
			&& newPassword.val()!='' && newPasswordConfirm.val() != ''){
			event.preventDefault();
			
			let data = passwordUpdateForm.serialize();

			$.ajax({
				url : "${cPath}/groupware/profile/passwordUpdate.do",
				method : "POST",
				data : data,
				dataType : "html",
				success : function(message) {
					toastr.info(message);
					
					setTimeout(function() {
						   location.href = "${cPath}/groupware/index.do";						
					}, 1500);
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			})
			
		}else{
			toastr.info("비밀번호를 입력해주세요");
		}
	})
	
	// ====================================
	// 새로운 비밀번호를 입력하고
	// 확인차원으로 재입력했을 때 일치 여부 확인
	// ====================================
    function check_pw(){
		check.empty();
		
		if(newPassword.val()!='' && newPasswordConfirm.val()!=''){
			if(newPassword.val()==newPasswordConfirm.val()){
				check.html("<span class='far fa-check-circle'></span>");
				check.css('color','blue');
			}else{
				check.html("변경할 비밀번호를 재확인해주세요.");
				check.css('color','red');
				
			}
		}
	}
</script>