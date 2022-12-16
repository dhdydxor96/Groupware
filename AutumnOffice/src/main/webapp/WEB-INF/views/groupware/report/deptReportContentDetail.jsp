<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="${cPath}/resources/js/ckeditor/ckeditor.js"></script>
 
<style>
.box{
	margin:15px;

}
.box-sm{
	margin:10px;
}
button{
	width:100px;
	
}
</style>
    
<div class="card md-3">

	<div>
		<h3>주간업무보고</h3>
		<h6>| 개발팀</h6>
		<h6>작성자 : 윤정식  &nbsp;&nbsp;&nbsp;작성일시 : 2022-10-10 11:52:00</h6>
	</div>
</div>
<br>
<div class="card md-3">

	<h4>보고합니다</h4>
	<hr>
	<div>
		(보고내용)<br>
		1<br>
		2<br>
		3<br>
		4<br>
		5
	</div>	

	<hr>
	<a href="#">
		<span class="fas fa-paperclip"></span> 2022_10_10_final.jpg
	</a>
	<br>
	<br>
	<br>
	<div style="text-align: center">
		<button class="btn btn-primary me-1 mb-1" onclick="location.href='${cPath}/groupware/report/dept/deptReportDetail.do'">목록으로</button>
	</div>
</div>
