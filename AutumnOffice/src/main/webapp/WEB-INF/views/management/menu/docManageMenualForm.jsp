<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/ckeditor/ckeditor.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
.card{
	padding : 1%;
}
th{
	width : 11%;
	text-align: center;
}
.att{
	font-size: 13px;
}
input {
	margin-top:1%;
	margin-bottom:1%;
}
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
}



</style>
<div class="card md-3">
<h4 style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight:bold; font-size:30px;margin-top:1%"><span class="far fa-list-alt"></span>&nbsp;매뉴얼 작성</h4>
<hr>
<form:form method="post" modelAttribute="rule" enctype="multipart/form-data">
	<table class="table table-bordered" style="width: 100%;">
		<tr>
			<th>제목</th>
			<td>
				<form:input path="rulTit" required="true" class="form-control"/>
				<form:errors path="rulTit" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<form:input path="" class="form-control" value="관리자" readonly="true"/>
				<form:errors path="" element="span" cssClass="error" />
			</td>
		</tr>		
		<tr>
		<th>첨부파일</th>
		<td>
			<input class="att" type="file" name="rulFiles" />
			<input class="att" type="file" name="rulFiles" />
			<input class="att" type="file" name="rulFiles" />
		</td>
	</tr>
		<tr>
			<th>내용</th>
			<td>
				<form:textarea path="rulCon" required="true" class="form-control"/>
				<form:errors path="rulCon" element="span" cssClass="error" />
			</td>
		</tr>
	</table>
	<br> 
	<div style="margin-left: 33%;">
		<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight:bold;width:25%" >매뉴얼 등록</form:button>&nbsp;&nbsp;&nbsp;
		<form:button type="button" id="toMenualList" class="btn btn-outline-secondary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight:bold;width:25%;" >취소</form:button>
	</div>
</form:form>
<br>
</div> 
<script>
	CKEDITOR.replace('rulCon', {
		filebrowserImageUploadUrl:"${cPath}/management/menu/imageUpload.do?type=image"
	});
	
	
	$("#toMenualList").on('click',function(){
		location.href="${cPath}/management/menu/docManageMenualList.do";
	});
</script>