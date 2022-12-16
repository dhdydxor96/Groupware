<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.card{
	padding : 1%;
}

table {
	margin-left: auto;
	margin-right: auto;
	border: 1px solid gray;
	border-collapse: collapse;
}

td {
	padding: 15px;
	vertical-align: middle;
}
th{
	width: 24%;
	text-align: center;
	vertical-align: middle;
}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
div{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
span{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
.attendImage{
	width:100px;
}
.workInfo{
	text-align: right;
	color:#C0C0C0;
	font-size: 14px;
}
h3{
	font-weight: bold;
	font-size: 30px;
}
</style>

<div class="card">
	<!-- -------------------------- -->
	<!--    	 현재 근무상태      	    -->
	<!-- -------------------------- -->
	<div class="workInfo">
	</div>

	<!-- 메뉴 명 -->
	<h3><span class="fas fa-business-time"></span>&nbsp;내 인사 정보</h3>
	<hr>
	<br> <br>


	<!-- -------------------------- -->
	<!--     내 인사 정보 확인            -->
	<!-- -------------------------- -->
	<table class="table table-bordered">
			<tr>
				<td rowspan="3" style="text-align: center;"><img src="${cPath}/groupware/attendance/my/privacy/privacyImageView.do" class="attendImage"
																onerror="this.src='${cPath}/resources/groupware/assets/img/profile_user_example.png'"	alt="프로필사진"></td>
				<th>이름</th>
				<th>부서명</th>
				<td>${empInfo.depNm }</td>
			</tr>
			<tr>
				<td rowspan="2" style="vertical-align: middle;text-align: center">${empInfo.empNm }</td>
				<th>직위</th>
				<td>${empInfo.jobNm }</td>
			</tr>
			<tr>
				<th>사번</th>
				<td>${empInfo.empId }</td>
			</tr>
			<tr>
				<th>휴대전화</th>
				<td>${empInfo.empPh }</td>
				<th>이메일</th>
				<td>${empInfo.empMail }</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${empInfo.empBid }</td>
				<th>입사일</th>
				<td>${empInfo.empHid }</td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3">${empInfo.empAddr }</td>
			</tr>
	</table>
	<pre>
	
	
	
	
	
	</pre>
</div>

<script>

//========================================================
//1분에 한번씩 돌아가도록 설정 - 현재 업무시간 (출근시간/퇴근시간/현재 업무시간)
//========================================================
let workInfo = $(".workInfo");

$(function() {
	const timer = function () {
		$.ajax({
			url : "${cPath}/groupware/attendance/my/status/myWorkInfo.do",
			dataType : "JSON",
			success : function(status) {
				workInfo.html("* "+status.empNm+"&nbsp;"+status.jobNm+" : "+status.staInd+" [ 오늘 업무시간 : "+status.sumTime+" ] 출근 시간 : "+status.staOnt+"  | 퇴근 시간 : "+status.staOft+" <span class='fas fa-stopwatch'></span>");
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
	}; 
	
	timer(); // loop 할 함수 실행
	setInterval(timer, 60000);
});


</script>