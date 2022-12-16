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
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left;">
	<br>
	<h3 style="font-weight: bold; font-size:30px; font-family: 'IBM Plex Sans KR', sans-serif;"><span class="fas fa-chart-pie"></span>&nbsp;설문지 상세보기</h3>
			<c:url value="/groupware/survey/surveyUpdate.do" var="updateURL">
					<c:param name="what" value="${survey.surNo }"/>
			</c:url>
	<hr>
	<br>
	<c:set var="employee" value="${survey.employee }"/>	
	<table class="table table-bordered" style="width: 90%; margin-left: 5%; vertical-align: middle;">
		<tr>
			<th>설문지 제목</th>
			<td>${survey.surTitle }</td>
		</tr>
		<tr>
			<th>작성자명</th>
			<td>${survey.empNm }</td>
		</tr>
		<tr>
			<th>설문지 목적</th>
			<td>${survey.surPurpose }</td>
		</tr>	
		<tr>
			<th>설문지 안내 문구</th>
			<td>${survey.surGuide }</td>
		</tr>	
		<tr>
			<th>설문지 시작일</th>
			<td>${survey.surSdate }</td>
		</tr>	
		<tr>
			<th>설문지 마감일</th>
			<td>${survey.surEdate }</td>
		</tr>	
		<tr>
			<th>설문지 상태</th>
			<td>
			<c:if test="${survey.surState == 0 }">
				미진행
			</c:if>
			<c:if test="${survey.surState == 1 }">
				진행중
			</c:if>
			<c:if test="${survey.surState == 2 }">
				마감
			</c:if>
			</td>
		</tr>	
		<tr>
			<th>설문지 작성일</th>
			<td>${survey.surInsdat }</td>
		</tr>	
	</table>
	<br>
	<div>
		<a href="${updateURL}" class="btn btn-outline-primary me-1 mb-1" style="float:left; width:23%; margin-left:25%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">설문지 수정</a>
		<a href="${cPath }/groupware/survey/surveyList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="float: left; width: 23%; margin-left: 4%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">목록</a>
	</div>
	<br>
</div>
