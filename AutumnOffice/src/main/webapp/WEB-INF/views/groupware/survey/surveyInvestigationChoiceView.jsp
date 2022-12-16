<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
.swal-footer{
	text-align:center;
}
</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<div>
	<h3 style="float:left; font-size:30px; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;"><span class="fas fa-chart-pie"></span>&nbsp;설문 조사 상세보기</h3>
			<c:url value="/groupware/survey/surveyInvestigationDelete.do" var="deleteURL">
					<c:param name="what" value="${surveyInvestigation.surinvNo }"/>
					<c:param name="surNo" value="${surveyInvestigation.surNo }"/>
					<c:param name="surqueNo" value="${surveyInvestigation.surqueNo }"/>
			</c:url>
			<div>
				<button id="delBtn" class="btn btn-outline-primary me-1 mb-1" style="float:right;width:15%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">설문 조사 삭제</button>
			</div>
	</div>
	<hr>
	<br>
	<c:set var="surveyInvestigation" value="${surveyInvestigation }"/>	
	<table class="table table-bordered" style="width: 90%; margin-left: 5%; vertical-align: middle;">
		<tr>
			<th>설문 조사 번호</th>
			<td>${surveyInvestigation.surinvNo }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${surveyInvestigation.empNm }</td>
		</tr>	
		<tr>
			<th>설문 제목</th>
			<td>${surveyInvestigation.surTitle }</td>
		</tr>
		<tr>
			<th>문항 내용</th>
			<td>${surveyInvestigation.surqueContent }</td>
		</tr>	
		<tr>
			<th>문항 타입</th>
			<td>${surveyInvestigation.surinvType }</td>
		</tr>	
		<c:if test="${not empty surveyInvestigation.surinvFirst }">
			<tr>
				<th>객관식 1번 항목</th>
				<td>${surveyInvestigation.surinvFirst }</td>
			</tr>
		</c:if>	
		<c:if test="${not empty surveyInvestigation.surinvSecond }">
			<tr>
				<th>객관식 2번 항목</th>
				<td>${surveyInvestigation.surinvSecond }</td>
			</tr>
		</c:if>	
		<c:if test="${not empty surveyInvestigation.surinvThird }">
			<tr>
				<th>객관식 3번 항목</th>
				<td>${surveyInvestigation.surinvThird }</td>
			</tr>	
		</c:if>
		<c:if test="${not empty surveyInvestigation.surinvFour }">
			<tr>
				<th>객관식 4번 항목</th>
				<td>${surveyInvestigation.surinvFour }</td>
			</tr>	
		</c:if>
		<c:if test="${not empty surveyInvestigation.surinvFive }">
			<tr>
				<th>객관식 5번 항목</th>
				<td>${surveyInvestigation.surinvFive }</td>
			</tr>	
		</c:if>
		<tr>
			<th>설문 조사 작성일</th>
			<td>${surveyInvestigation.surinvInsdat }</td>
		</tr>	
	</table>
	<br>
		<a href="${cPath }/groupware/survey/surveyInvestigationList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="width:25%; margin-left:37%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">목록</a>
	<br>
</div>
<script>
var link = '${deleteURL}';

$("#delBtn").click(function () {
	swal("경고","설문조사와 관련된 모든 정보가 삭제 됩니다.","warning")
	.then(function(){
		location.href=link;                   
	}) 
  });
</script>
