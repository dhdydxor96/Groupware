<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script src="${cPath}/resources/js/ckeditor/ckeditor.js"></script>
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
input {
	font-family: 'IBM Plex Sans KR', sans-serif;
	margin-top: 1%;
	margin-bottom: 1%
}
th{
	width: 13%;
}
</style>
<div class="card mb-3" style="padding:1%; text-align: center; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<h3 style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left;font-size: 30px"><span class="fas fa-volume-up"></span>&nbsp;공지사항 등록</h3>
	<hr>
	<form:form method="post" modelAttribute="notice" enctype="multipart/form-data" action="?${_csrf.parameterName}=${_csrf.token}">
		<input type="hidden"  name="nocVie" value="0" />
		<br>
		<table id="tableSetting" class="table table-bordered" >
			<tr>
				<th>제목</th>
				<td class="form-group" colspan="2" style="height: 70%">
					<form:input path="nocTit" required="true" class="form-control"/>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="2" style="height: 70%">
					<div>
						<input class="form-control-file" type="file" name="nocFiles" style="float: left; margin-left: 1%; width:22%;">
						<input class="form-control-file" type="file" name="nocFiles" style="float: left; margin-left: 1%; width:22%;">
						<input class="form-control-file" type="file" name="nocFiles" style="float: left; margin-left: 1%; width:22%;">
					</div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<div class="nocCon">
						<textarea class="form-control editable" name="nocCon" cols="30" rows="5"></textarea>
					</div>
				</td>	
		</table>
		<div>
			<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="width: 25%; font-weight: bold;">공지사항 등록</form:button>&nbsp;&nbsp;
			<a href="${cPath }/management/menu/noticeManage.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width:25%;margin-left:1%">취소</a>
		</div>
		<br>
	</form:form>
</div>	
<script>
	CKEDITOR.replace('nocCon', {
		height : 300,
		filebrowserImageUploadUrl:"${cPath}/management/menu/imageUpload.do?type=image"
	});
	
	// 취소버튼 선언(리스트페이지로 이동)
	let cancelButton = $(".mb-cancelButton");
	cancelButton.click(function javascript_onclick(){
	   location.href="${cPath }/management/menu/noticeManage.do";       
	});
</script>