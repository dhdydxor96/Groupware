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
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center;">
	<br>
	<div>
	<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; float:left; font-weight:bold; text-align:left; font-size:30px;"><span class="fas fa-sitemap"></span>&nbsp;부서 상세보기</h1>
			<c:url value="/management/group/department/departmentUpdate.do" var="updateURL">
					<c:param name="what" value="${department.depId }"/>
			</c:url>
				<c:url value="/management/group/department/departmentDelete.do" var="deleteURL">
						<c:param name="what" value="${department.depId }"/>
				</c:url>
			<div>
				<a href="${deleteURL}" class="btn btn-outline-primary me-1 mb-1" style="width:10%; float:right; font-weight:bold; font-family: 'IBM Plex Sans KR', sans-serif; ">삭제</a>
				<a href="${updateURL}" class="btn btn-outline-primary me-1 mb-1" style="width:10%;  margin-right:1%; float:right; font-weight:bold; font-family: 'IBM Plex Sans KR', sans-serif; ">수정</a>
			</div>
	</div>
	<hr>
	<br>
	<br><br>
	<table class="table table-bordered">
		<tr>
			<th>부서 코드</th>
			<td id="code">${department.depId }</td>
		</tr>
		<c:if test = "${not empty department.depHdc  }">
		<tr>
			<th>상위 부서 코드</th>
			<td>${department.depHdc }</td>
		</tr>
		</c:if>
		<c:if test = "${not empty department.depHdc  }">
		<tr>
			<th>상위 부서명</th>
			<td>${department.depTnm }</td>
		</tr>
		</c:if>
		<tr>
			<th>부서명</th>
			<td>${department.depNm }</td>
		</tr>	
		<tr>
			<th>부서 책임자</th>
			<td>${department.depMag }</td>
		</tr>	
		<tr>
			<th>부서 생성일</th>
			<td>${department.depCrd }</td>
		</tr>	
		<tr>
			<th>부서 수정일</th>
			<td>${department.depUpd }</td>
		</tr>	
	</table>
	<br>
		<a href="${cPath }/management/group/department/departmentList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-weight:bold; width:25%; margin-left:37%; font-family: 'IBM Plex Sans KR', sans-serif;">목록</a>
	<br>
</div>
