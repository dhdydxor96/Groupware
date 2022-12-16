<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<div class="card mb-3" style="padding:1%; text-align: center; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<h1 style="font-weight: bold; font-size:30px; text-align:left; font-family: 'IBM Plex Sans KR', sans-serif;"><span class="fas fa-caret-right"></span>&nbsp;이용중인 서비스 정보 확인</h1>
	<hr>
	<div style="text-align: left;">현재 이용중인 그룹웨어 서비스 정보를 확인합니다.</div>
	<br>
	<br>
	<br>
	<table class="table table-bordered">
		<tr>
			<th>회사코드</th>
			<td>${serviceHistory.comCode }</td>
		</tr>
		<tr>
			<th>사원수</th>
			<td>${serviceHistory.serEmp }</td>
		</tr>
		<tr>
			<th>이용기간</th>
			<td>${serviceHistory.serPeri }</td>
		</tr>	
		<tr>
			<th>결제금액</th>
			<td><fmt:formatNumber value="${serviceHistory.servicePay }" pattern="#,###,###,###"/></td>
		</tr>	
		<tr>
			<th>시작일</th>
			<td>${serviceHistory.serStd }</td>
		</tr>	
		<tr>
			<th>종료일</th>
			<td>${serviceHistory.serEnd }</td>
		</tr>
		<tr>
			<th>서비스명</th>
			<td>${serviceHistory.serName }</td>
		</tr>	
	</table>
</div>
