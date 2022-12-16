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
		<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; text-align:left; float:left; font-size:30px;"><span class="fas fa-user-tie"></span>&nbsp;사원 상세보기</h1>
			<c:url value="/management/group/employee/employeeUpdate.do" var="updateURL">
					<c:param name="what" value="${employee.empId }"/>
			</c:url>
			<c:url value="/management/group/employee/powerHeadInsert.do" var="powerHeadInsertURL">
					<c:param name="what" value="${employee.empId }"/>
			</c:url>
			<c:url value="/management/group/employee/powerDirectorInsert.do" var="powerDirectorInsertURL">
					<c:param name="what" value="${employee.empId }"/>
			</c:url>
			<c:url value="/management/group/employee/employeeDelete.do" var="deleteURL">
					<c:param name="what" value="${employee.empId }"/>
			</c:url>
		<div>
			<a href="${deleteURL}" class="btn btn-outline-primary me-1 mb-1" style="float:right;  font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; width:10%; margin-right:1%;">삭제</a>
			<a href="${updateURL}" class="btn btn-outline-primary me-1 mb-1" style="float:right;  font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; width:10%; margin-right:1%;">수정</a>
			<a href="${powerHeadInsertURL}" class="btn btn-outline-primary me-1 mb-1" style=" float:right;  font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; margin-right:1%;">부서장 권한 부여</a>
			<a href="${powerDirectorInsertURL}" class="btn btn-outline-primary me-1 mb-1" style="float:right;  font-family: 'IBM Plex Sans KR', sans-serif;font-weight:bold;margin-right:1%; ">임원 권한 부여</a>
		</div>
	</div>
	<hr>
	<br>
				
	<table class="table table-bordered">
		<tr>
			<th>사원 아이디</th>
			<td id="code" >${employee.empId }</td>
		</tr>
		<tr>
			<th>사원 프로필사진</th>
			<td >
				<c:url var="imageViewURL" value="/management/group/employee/employeeImageView.do">
					<c:param name="what" value="${employee.empId }"></c:param>
				</c:url>
				<img src="${imageViewURL}" alt="프로필사진"style="width: 250px;height: 250px; margin-top:1%; margin-bottom:1%;">
			</td>
		</tr>
		<tr>
			<th>사원명</th>
			<td>${employee.empNm }</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>${employee.empBid }</td>
		</tr>	
		<tr>
			<th>부서</th>
			<td>
				<table class="table table-bordered" style="margin-top:1%; margin-bottom:1%;">
					<thead>
						<tr>
							<th>부서명</th>
							<th>상위 부서명</th>
							<th>부서 책임자</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="department" value="${employee.department }"/>
						<tr>
							<td>${department.depNm }</td>
							<td>${department.depTnm }</td>
							<td>${department.depMag }</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>	
		<tr>
			<th>직위</th>
			<td>
				<table class="table table-bordered" style="margin-top:1%; margin-bottom:1%;">
					<thead>
						<tr>
							<th>직위명</th>
							<th>상위 직위명</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="job" value="${employee.job }"/>
						<tr>
							<td>${job.jobNm }</td>
							<td>${job.jobTnm }</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>	
		<tr>
			<th>이메일</th>
			<td>${employee.empMail }</td>
		</tr>	
		<tr>
			<th>핸드폰번호</th>
			<td>${employee.empPh }</td>
		</tr>	
		<tr>
			<th>주소</th>
			<td>${employee.empAddr }</td>
		</tr>	
		<tr>
			<th>입사일</th>
			<td>${employee.empHid }</td>
		</tr>	
		<tr>
			<th>퇴사일</th>
			<td>${employee.empEnd }</td>
		</tr>	
	</table>
	<br>
		<a href="${cPath }/management/group/employee/employeeList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-weight:bold; width:25%; margin-left:37%;  font-family: 'IBM Plex Sans KR', sans-serif;">목록</a>
	<br>
</div>
