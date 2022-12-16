<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
	font-weight:bold;
}
</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<h3 style="font-weight: bold; font-size:30px; font-family: 'IBM Plex Sans KR', sans-serif;"><span class="fas fa-chart-pie"></span>&nbsp;설문 항목 상세보기</h3>
			<c:url value="/groupware/survey/surveyArticleUpdate.do" var="updateURL">
					<c:param name="what" value="${surveyArticle.surarcNo }"/>
			</c:url>
	<hr>
	<br>
	<c:set var="surveyArticle" value="${surveyArticle }"/>	
	<table class="table table-bordered" style="width: 90%; margin-left: 5%; vertical-align: middle;">
		<tr>
			<th>문항 제목</th>
			<td>${surveyArticle.surqueContent }</td>
		</tr>
		<tr>
			<th>항목 순번</th>
			<td>${surveyArticle.surarcTurn }</td>
		</tr>
		<tr>
			<th>항목 내용</th>
			<td>${surveyArticle.surarcContent }</td>
		</tr>	
		<tr>
			<th>항목 작성일</th>
			<td>${surveyArticle.surarcInsdat }</td>
		</tr>	
	</table>
	<br>
	<div>
		<a href="${updateURL}" class="btn btn-outline-primary me-1 mb-1" style="float:left; width:23%; margin-left:25%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">설문 항목 수정</a>
		<a href="${cPath }/groupware/survey/surveyArticleList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="float: left; width: 23%; margin-left: 4%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">목록</a>
	</div>
	<br>
</div>
