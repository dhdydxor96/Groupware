<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
.setting-content-wrapper{
/* 	border-top:1px solid #BDBDBD; */
/* 	border-bottom:1px solid #BDBDBD; */
	margin-top:15px;
	margin-bottom:15px;
	height:500px;
}
.setting-wrapper{
	padding:15px;
}
.setting-header-wrapper{
	margin-top:15px;
}
.btn-apply{
	float:right;
}
.sign-img{
	width:80px;
}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
div{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
select{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
h3{
	font-size: 30px;
	font-weight: bold
}
.btn{
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-weight: bold;
}

</style>
    
<div class="card mb-3 setting-wrapper">
	<br>
	<h3 style=" font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left; font-size:30px;"><span class="fas fa-tools"></span>&nbsp;전자 결재 환경 설정</h3>
	<hr>
	<form:form id="imgForm" action="${cPath }/groupware/approval/signUpdate.do" method="post" enctype="multipart/form-data">
	<div class="setting-header-wrapper">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<a class="nav-link active px-2 px-md-3nav-link px-2 px-md-3" id="all"  href="${cPath }/groupware/approval/setting/signUpdate.do" >
					서명설정
				</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link  px-2 px-md-3" id="progress"  href="${cPath }/groupware/approval/setting/absenceHome.do" tabindex="-1">
					부재/위임 설정
				</a>
			</li>
	    </ul>
		<div class="setting-content-wrapper">
		<table class="table table-hover" style="width: 70%; vertical-align: middle; margin-left:15%;">
			<tr>
				<td>
				<h3 style=" font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left; font-size:30px;"><span class="fas fa-stamp"></span>&nbsp;서명 관리</h3>
				</td>
			</tr>
			<tr>
				<td><input type="file" value="서명 변경" name="empSignImg" accept="image/*" required="required"/></td>
			</tr>
			<tr>
				<td>
					<div style="margin-left:30%;">
						<img class="sign-img" style="width: 300px; height: 300px;" src="data:image/*;base64,${authEmp.base64Img }"/>
					</div>
				</td>
			</tr>
		</table>
		</div>
	</div>
	<div class="setting-footer-wrapper">
		<button class="btn btn-outline-primary me-1 mb-1 btn-apply" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; width:15%; margin-right:25%;">적용</button>
	</div>
	</form:form>
	<br>
</div>
<script type="text/javascript" defer="defer">
	
</script>