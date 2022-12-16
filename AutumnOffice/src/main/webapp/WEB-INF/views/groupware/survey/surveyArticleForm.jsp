<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<div class="card mb-3" style="text-align:center; padding:1%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<h3 style="font-weight: bold; font-size:30px; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left;"><span class="fas fa-chart-pie"></span>&nbsp;설문 항목  등록</h3>
	<hr>
	<br>
	<form:form method="post" modelAttribute="surveyArticle" enctype="multipart/form-data">
		<table class="table table-bordered" style="width: 90%; margin-left: 5%; vertical-align: middle;">
		<tr>
			<th>문항 제목</th>
			<td>
				<form:select path="surqueNo" required="true" class="form-select"  style="font-family: 'IBM Plex Sans KR', sans-serif; ">
					<option value>문항 제목</option>
					<c:forEach items="${surveyQuestionList }" var="surveyQuestion">
						<form:option value="${surveyQuestion.surqueNo }" label="${surveyQuestion.surqueContent }" />
					</c:forEach>
				</form:select>
				<form:errors path="surqueNo" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>항목 순번</th>
			<td>
				<form:input path="surarcTurn" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;"/>
				<form:errors path="surarcTurn" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>항목 내용</th>
			<td>
				<form:input path="surarcContent" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; "/>
				<form:errors path="surarcContent" element="span" cssClass="error" />
			</td>
		</tr>
		</table>
		<br>
			<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; width: 25%;font-size: 15px;font-weight: bold;">설문 항목 등록</form:button>
			<a href="${cPath }/groupware/survey/surveyArticleList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; margin-left:5%; font-weight: bold; width: 25%;">취소</a>
	</form:form>
	<br>	
</div>