<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center; ">
	<br>
	<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; text-align:left; font-size:30px;"><span class="fas fa-user-tie"></span>&nbsp;사원 수정</h1>
	<hr>
	<br>
	<form:form id="employeeForm" method="post" modelAttribute="employee" enctype="multipart/form-data">
		<table class="table table-bordered">
		<tr>
			<th style="text-align:left;">사원 아이디</th>
			<td style="height: 70%">
				<form:input path="empId" required="true" class="form-control" readonly="true" style="font-family: 'IBM Plex Sans KR', sans-serif; text-align:left; margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="empId" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">부서</th>
			<td style="height: 70%">
				<form:select path="depId" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; text-align:left; margin-top:1%; margin-bottom:1%;">
					<option value>부서</option>
					<c:forEach items="${departmentList }" var="department">
						<form:option value="${department.depId }" label="${department.depNm }" />
					</c:forEach>
				</form:select>
				<form:errors path="depId" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">직위</th>
			<td style="height: 70%">
				<form:select path="jobId" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;  text-align:left; margin-top:1%; margin-bottom:1%;">
					<option value>직위</option>
					<c:forEach items="${jobList }" var="job">
						<form:option value="${job.jobId }" label="${job.jobNm }" />
					</c:forEach>
				</form:select>
				<form:errors path="jobId" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 비밀번호</th>
			<td style="height: 70%">
				<form:password path="empPass" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;  text-align:left; margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="empPass" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 이름</th>
			<td style="height: 70%">
				<form:input path="empNm" class="form-control" readonly="true" style="font-family: 'IBM Plex Sans KR', sans-serif;  text-align:left; margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="empNm" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 이메일</th>
			<td style="height: 70%">
				<form:input path="empMail" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;  text-align:left;margin-top:1%; margin-bottom:1%; "/>
				<form:errors path="empMail" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 핸드폰번호</th>
			<td style="height: 70%">
				<form:input path="empPh" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;  text-align:left; margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="empPh" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 주소</th>
			<td style="height: 70%">
				<form:input path="empAddr" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;  text-align:left; margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="empAddr" element="span" cssClass="error" />
			</td>
		</tr>
		</table>
		<br>
				<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="font-weight:bold; width: 25%;margin-right: 5%;">사원 수정</form:button>
				<a href="${cPath }/management/group/employee/employeeList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-weight:bold; width:25%; font-family: 'IBM Plex Sans KR', sans-serif; ">취소</a>
	</form:form>	
	<br>
</div>
