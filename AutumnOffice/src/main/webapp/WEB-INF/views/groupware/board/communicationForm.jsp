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
select{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
 }
</style>
	<c:set var="board" value="${post.boardList }"/>
	<div class="card mb-3" style="padding:1%; text-align: center; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<h3 style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left; font-size: 30px;"><span class="fas fa-book-open"></span>&nbsp;게시글 등록</h3>
	<hr>
	<br>
		<form:form method="post" modelAttribute="post" enctype="multipart/form-data" action="?${_csrf.parameterName}=${_csrf.token}">
			<input type="hidden"  name="empId" value="${post.empId}" />
			<input type="hidden"  name="poVie" value="0" />
			<input type="hidden" id="boCode" name="boCode" >
			<table class="table table-bordered" style="text-align:center; vertical-align: middle;" >
			<tr>
				<th style="padding: 1%; width: 15%;">게시판</th>
				<td>
					<select class="form-control addrSelector" id="selectCategory">
						<option >게시판</option>
						<c:forEach items="${post.boardList }" var="board" varStatus="vs">
					    	<option value="${board.boCode }">${board.boType}</option>
					    </c:forEach>
					</select>
					<form:errors path="boCode" element="span" />
				</td>
			</tr>
				<tr>
					<th style="padding: 1%; width: 15%;">제목</th>
					<td class="form-group" colspan="2">
						<form:input path="poTit" required="true" class="form-control"/>
					</td>
				</tr>
				<tr>
					<th style="padding: 1%; width: 15%;">첨부파일</th>
					<td colspan="2">
						<div>
							<input class="form-control-file" type="file" name="poFiles" style="float: left; width:30%;">
							<input class="form-control-file" type="file" name="poFiles" style="float: left; width:30%;">
							<input class="form-control-file" type="file" name="poFiles" style="float: left; width:30%;">
						</div>
					</td>
				</tr>
				<tr>
					<th style="padding: 1%; width: 15%;">내용</th>
					<td>
						<div class="poCon">
							<textarea class="form-control editable" name="poCon" cols="30" rows="5"></textarea>
						</div>
					</td>	
			</table>
			<br>
				<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; width: 25%; font-weight: bold;">등록</form:button>
				<a href="${cPath }/groupware/board/communicationList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="margin-left: 5%; font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width:25%; ">취소</a>
		</form:form>
			<br>
	</div>
	<script>
	CKEDITOR.replace('poCon', {
		height : 300,
		filebrowserImageUploadUrl:"${cPath}/groupware/board/imageUpload.do?type=image"
	});
	
	
	$("#selectCategory").on("change", function(){
		let selectBoardCategory = $("#selectCategory option:selected").val();
		let boCode = $("#boCode").val(selectBoardCategory);
		console.log(boCode.val());
	})

</script>