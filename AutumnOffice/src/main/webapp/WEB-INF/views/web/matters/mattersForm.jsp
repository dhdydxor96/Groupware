<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/ckeditor/ckeditor.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>
	<!-- -------------------------- -->
   	 <!-- 문의사항 등록 페이지(웹페이지) -->
   	<!-- -------------------------- -->
<br><br><br>
<h1 style="font-family: 'IBM Plex Sans KR', sans-serif;">문의사항 등록</h1>
<br><br>
<form:form method="post" modelAttribute="matters" enctype="multipart/form-data">
	<table class="table table-bordered" style="width: 80%; margin-left: 10%; vertical-align: middle; text-align: center;">
		<tr>
			<th style="width:10%;">제목</th>
			<td>
				<form:input path="matTit" required="true" class="form-control"/>
				<form:errors path="matTit" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<form:input path="matNm" class="form-control"/>
				<form:errors path="matNm" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<form:password path="matPass" class="form-control"/>
				<form:errors path="matPass" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
		<th>첨부파일</th>
		<td>
			<input type="file" name="matFiles" style="float: left; width: 30%;"/>
			<input type="file" name="matFiles" style="float: left; width: 30%;"/>
			<input type="file" name="matFiles" style="float: left; width: 30%;"/>
		</td>
	</tr>
		<tr>
			<th>내용</th>
			<td>
				<form:textarea path="matCon" required="true" class="form-control"/>
				<form:errors path="matCon" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
		<td colspan="2" >
			<form:button type="submit" class="btn btn-success" style="width: 15%;font-size: 15px;font-weight: bold;float: left;margin-right: 5%; font-family: 'IBM Plex Sans KR', sans-serif; margin-left:32%;">문의사항 등록</form:button>
			<a href="${cPath }/web/matters/mattersList.do" id="backBtn" class="btn btn-danger" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width: 15%;">목록</a>
		</td>
	</tr>
	</table>
</form:form>
<script>
	<!-- -------------------------- -->
	 <!-- 문의사항 내용(CK editor) -->
	<!-- -------------------------- -->
	CKEDITOR.replace('matCon', {
		filebrowserImageUploadUrl:"${cPath}/web/matters/imageUpload.do?type=image"
	});
</script>