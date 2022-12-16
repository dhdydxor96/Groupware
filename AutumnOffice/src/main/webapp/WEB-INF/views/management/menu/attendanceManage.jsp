<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.card{
	padding :1%;
}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
h1{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
h2{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
h3{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
h4{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
h5{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
p{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
span{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif;  ">
	<br>
	<h4 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:30px;"><span class="fas fa-caret-right"></span> 근태 관리</h4>
	<hr>
	<div>출퇴근시간을 규정에 맞게 등록합니다.</div>
	<br>
	<br>
	<br>

	<!-- -------------------------- -->
	<!-- 관리자(근태) - 근무시간 등록/변경   -->
	<!-- -------------------------- -->
	<form class="formTime" method="post">
		<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
		<div class="row g-3 justify-content-left">
			<div class="col-auto">
				근무시간
			</div>
			<div class="col-auto">
				<input type="text" placeholder="09:00" class="form-control startTime" name="emtOnt"  value="${ timeVO.emtOnt}" required /> 
			</div>
			<div class="col-auto">
				~		
			</div>
			<div class="col-auto">
				 <input type="text" placeholder="18:00" class="form-control endTime" name="emtOft" value="${timeVO.emtOft}" required />
			</div>
		</div>
	
		<br>
		<br>
		<br>
		<div style="text-align: right">
			<button type="button" class="btn btn-outline-primary me-1 mb-1 changeTime" style="font-weight: bold;" >변경</button>
		</div>
	</form>
	<!-- -------------------------- -->
	<!--  관리자(근태) - 총 연차 수 변경     -->
	<!-- -------------------------- -->
	<hr>
	<div>
		근속연수에 맞게 총 연차수를 변경합니다.
	</div>
	<br>
	<br>
	<br>
	<br>
	<div style="text-align: right">
		<button type="button" class="btn btn-outline-primary me-1 mb-1 updateVacation" onclick="location.href='${cPath}/management/menu/updateVacation.do'"  style="font-weight: bold;" >
			<span class="fas fa-redo"></span>&nbsp;&nbsp;업데이트
		</button>
	</div>


</div>

<script>
//========================================================
// 버튼 클릭 시 근무시간 변경
//========================================================
	$('.changeTime').on('click', function(){
		

		let formData = $(".formTime").serialize();
		
		let startTime = $('.startTime').val();
		let endTime = $('.endTime').val();
		
		console.log(startTime)
		console.log(endTime)
		
		if (!startTime || !endTime){ 
			toastr.info("값을 입력해주세요");
			return false;
			
		}else{
			var objParam = {
					 
					"startTime":startTime,
					"endTime":endTime
			}
			
			$.ajax({
				url : "${cPath}/management/menu/attendanceManage.do?${_csrf.parameterName}=${_csrf.token}",
				method : "POST",
				data : objParam,
				dataType : "json",
				success : function(resp) {
					toastr.info("변경이 완료되었습니다");
					
					startTime = resp.emtOnt;
					endTime = resp.emtOft;
				},
				error : function(errorResp) {
					toastr.error("변경에 실패하였습니다");
					console.log(errorResp.status);
				}
			})
			
		}
	})
	
</script>

<c:if test="${not empty message}">
<span id="${message}" class="msg" ></span>
<script>
	let msg = $(".msg").attr("id");
	toastr.info(msg);
</script>
</c:if>
