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
}
</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center;">
	<br>
	<div>
	<h1 style=" float:left;font-family: 'IBM Plex Sans KR', sans-serif; font-size:30px; text-align:left; font-weight:bold; "><span class="fas fa-user-friends"></span>&nbsp;직위 상세보기</h1>
			<c:url value="/management/group/job/jobUpdate.do" var="updateURL">
					<c:param name="what" value="${job.jobId }"/>
			</c:url>
				<c:url value="/management/group/job/jobDelete.do" var="deleteURL">
						<c:param name="what" value="${job.jobId }"/>
				</c:url>
			<div>
				<a href="${deleteURL}" class="btn btn-outline-primary me-1 mb-1" style=" float:right;  font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif; ">삭제</a>
				<a href="${updateURL}" class="btn btn-outline-primary me-1 mb-1" style=" float:right; margin-right:1%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif; ">수정</a>
			</div>
	</div>
	<hr>
	<br><br>
	<table class="table table-bordered">
		<tr>
			<th>직위 코드</th>
			<td id="code" >${job.jobId }</td>
		</tr>
		<c:if test = "${not empty job.jobHjc  }">
			<tr>
				<th>상위 직위 코드</th>
				<td>${job.jobHjc }</td>
			</tr>
		</c:if>
		<c:if test = "${not empty job.jobHjc  }">
		<tr>
			<th>상위 직위명</th>
			<td>${job.jobTnm }</td>
		</tr>
		</c:if>
		<tr>
			<th>직위명</th>
			<td>${job.jobNm }</td>
		</tr>	
		<tr>
			<th>직위 생성일</th>
			<td>${job.jobCrd }</td>
		</tr>	
		<tr>
			<th>직위 수정일</th>
			<td>${job.jobUpd }</td>
		</tr>	
	</table>
		<br>
		<a href="${cPath }/management/group/job/jobList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="width:25%; margin-left:37%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">목록</a>
	<br>
</div>
    