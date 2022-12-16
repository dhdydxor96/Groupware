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
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center;">
	<br>
	<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;  text-align:left; font-size:30px;"><span class="fas fa-sitemap"></span>&nbsp;부서 수정</h1>
	<hr>
	<br>
	<form:form method="post" modelAttribute="department">
		<table class="table table-bordered">
		<tr>
			<th style="text-align : left;">부서 코드</th>
			<td style="height: 70%">
				<form:input path="depId" required="true" class="form-control" readonly="true" style="font-family: 'IBM Plex Sans KR', sans-serif;  text-align : left; margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="depId" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align : left;">상위 부서 코드</th>
			<td style="height: 70%">
				<form:select path="depHdc" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; margin-top:1%; margin-bottom:1%; text-align : left;">
					<option value></option>
					<c:forEach items="${departmentList }" var="department">
						<form:option value="${department.depId }" label="${department.depId }" />
					</c:forEach>
				</form:select>
				<form:errors path="depHdc" element="span" cssClass="error" /> 
			</td>
		</tr>
		<tr>
			<th style="text-align : left;">상위 부서명</th>
			<td style="height: 70%">
				<form:select path="depTnm" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; margin-top:1%; margin-bottom:1%; text-align : left;">
					<option value></option>
					<c:forEach items="${departmentList }" var="department">
						<form:option value="${department.depNm }" label="${department.depNm }" />
					</c:forEach>
				</form:select>
				<form:errors path="depTnm" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align : left;">부서명</th>
			<td style="height: 70%">
				<form:input path="depNm" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;  text-align : left; margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="depNm" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align : left;"> 부서 책임자</th>
			<td style="height: 70%">
				<form:input path="depMag" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; text-align : left;margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="depMag" element="span" cssClass="error" />
			</td>
		</tr>
		</table>
		<br>
				<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="font-weight:bold; width: 25%; margin-right: 5%;">부서 수정</form:button>
				<a href="${cPath }/management/group/department/departmentList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-weight:bold; width:25%; font-family: 'IBM Plex Sans KR', sans-serif;">취소</a>
	</form:form>
	<br>	
</div>