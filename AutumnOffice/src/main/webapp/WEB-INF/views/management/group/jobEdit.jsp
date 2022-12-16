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
	text-align : center;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center;">
	<br>	
	<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;  text-align:left; font-size:30px;"><span class="fas fa-user-friends"></span>&nbsp;직위 수정</h1>
	<hr>
	<br>
	<form:form method="post" modelAttribute="job">
		<table class="table table-bordered" >
		<tr>
			<th style="text-align:left;">직위 코드</th>
			<td style="height: 70%">
				<form:input path="jobId" required="true" class="form-control" readonly="true" style="font-family: 'IBM Plex Sans KR', sans-serif; margin-top:1%; margin-bottom:1%;  text-align:left;"/>
				<form:errors path="jobId" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">상위 직위명</th>
			<td style="height: 70%">
				<form:select path="jobHjc" id="jobHjc" onclick="fn_jobTnm()" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; margin-top:1%; margin-bottom:1%; text-align:left;">
					<option value></option>
					<c:forEach items="${jobList }" var="job">
						<form:option value="${job.jobId }" label="${job.jobNm }" />
					</c:forEach>
				</form:select>
				<input type="hidden" id="jobTnm" name="jobTnm" style="margin-top:1%; margin-bottom:1%;">
				<form:errors path="jobHjc" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">직위명</th>
			<td style="height: 70%">
				<form:input path="jobNm" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; margin-top:1%; margin-bottom:1%;  text-align:left;"/>
				<form:errors path="jobNm" element="span" cssClass="error" />
			</td>
		</tr>
		</table>
		<br>
				<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style=" font-weight:bold; width: 25%; margin-right:5%;">직위 수정</form:button>
				<a href="${cPath }/management/group/job/jobList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-weight:bold; width:25%; font-family: 'IBM Plex Sans KR', sans-serif;">취소</a>
	</form:form>
	<br>	
</div>
<script>
	let jobTnm = $("#jobTnm").val();
	let jobNm2 = $("#jobNm").val();
function fn_jobTnm(){
	jobNm = $("#jobHjc option:selected").text();
	$("input[name=jobTnm]").val(jobNm);
}
</script>