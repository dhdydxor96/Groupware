<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
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
<div class="card mb-3" style="padding:1%; text-align: center; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<h3 style="font-weight: bold; font-size:30px; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left;"><span class="fas fa-chart-pie"></span>&nbsp;설문지 등록</h3>
	<hr>
	<br>
	<form:form method="post" modelAttribute="survey" enctype="multipart/form-data">
		<table class="table table-bordered" style="width: 90%; margin-left: 5%; vertical-align: middle;">
		<tr>
			<th>설문지 제목</th>
			<td>
				<form:input path="surTitle" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; "/>
				<form:errors path="surTitle" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>설문지 목적</th>
			<td>
				<form:input path="surPurpose" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; "/>
				<form:errors path="surPurpose" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>설문지 안내문구</th>
			<td>
				<form:input path="surGuide" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; "/>
				<form:errors path="surGuide" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>설문지 시작일</th>
			<td>
				<input type="date" required="required" name="surSdate" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; ">
			</td>
		</tr>
		<tr>
			<th>설문지 마감일</th>
			<td>
				<input type="date" required="required" name="surEdate" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; ">
			</td>
		</tr>
		</table>
		<br>
				<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; width: 25%;font-size: 15px;font-weight: bold;">설문지 등록</form:button>
				<a href="${cPath }/groupware/survey/surveyList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width: 25%; margin-left:5%;">취소</a>
	</form:form>
	<br>	
</div>