<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
</style>
	<!-- -------------------------- -->
   	 <!-- 체험하기 결과 페이지(웹페이지) -->
   	<!-- -------------------------- -->
	<br>
	<h1 id = "app-3" style="color:black; font-size:50px; font-family: 'IBM Plex Sans KR', sans-serif;">✨체험 신청이 완료되었습니다!✨</h1>
	<br><br>
	<h3 style="font-family: 'IBM Plex Sans KR', sans-serif;">[체험하기 계정 정보]</h3>
	<br>
	<table class="table table-bordered" style="width:40%; margin-left:30%; text-align:center; font-family: 'IBM Plex Sans KR', sans-serif;">
    		<tr>
    			<th style="font-size:25px; width:50%;">테스트용 ID</th>
    			<td style="font-family: 'IBM Plex Sans KR', sans-serif; font-size:25px; font-weight:bold;">
    				test
    			</td>
    		</tr>
    		<tr>
    			<th style="font-size:25px; width:50%;">테스트용 비밀번호</th>
    			<td style="font-family: 'IBM Plex Sans KR', sans-serif; font-size:25px; font-weight:bold;">
    				1234
    			</td>
    		</tr>
    </table>
	<br>
	<hr>
	<h3 style="color:red; font-family: 'IBM Plex Sans KR', sans-serif;">※주의사항※</h3>
	<p style="color:red; font-family: 'IBM Plex Sans KR', sans-serif;">
	체험하기용 계정으로 테스트 서버에서 모든 기능은 사용이 가능합니다.<br>
	단, 체험하기용 계정은 24시간이 지나면 자동 삭제됩니다.<br>
	따라서 체험하기를 사용하는 모든 고객님들은 하루동안만 체험하기가 가능합니다.<br>
	이러한 점 양해 부탁드리며, 항상 고객과 소통하는 AutumnOffice가 되겠습니다.<br>
	[AutumnOffice 올림]
	</p>
	<hr>
	<br>
	<a href="${cPath }/groupware/login/login.do" id="backBtn" class="btn btn-success" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width: 15%; margin-left: 35%; font-size:20px; margin-right:2%;">그룹웨어 접속하기</a>
	<a href="${cPath }/web/index.do" id="backBtn" class="btn btn-danger" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width: 15%;  font-size:20px;">메인으로 돌아가기</a>