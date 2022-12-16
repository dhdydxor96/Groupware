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
	width:30%;
}
</style>
<div class="card md-3" style="padding:1%; font-size:15px; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center;">
	<br>
	<div>			
	<h3 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left; font-size: 30px;"><span class="fas fa-list-alt"></span>&nbsp;매뉴얼 상세보기</h3>
	</div>
	<hr>
	<br>
<div>
	<table class="table table-bordered">
		<tr>
			<th>게시글 제목</th>
			<td>${rule.rulTit }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>관리자</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${rule.rulDate }</td>
		</tr>	
		<tr>
			<th>첨부파일</th>
			<td>
				<c:forEach items="${rule.attatchList }" var="attatch" varStatus="vs">
					<c:url value="/groupware/menual/download.do" var="downloadURL">
						<c:param name="what" value="${attatch.attNo }"/>
					</c:url>
						<a href="${downloadURL }">${attatch.attFnm }</a> (${attatch.attFas })
						${not vs.last?"|":"" }
				</c:forEach>
			</td>
		</tr>
	</table>

	
	
	<div style="border: 1px solid #dee2e6;
	    text-align: left;
	    width: 100%;
	    margin-left: 0%;
	    height: 100%;
	    padding: 5%;"
	    >
			${rule.rulCon }
	</div>
	<div style="padding : 1%;">
	<br>
				<a href="${cPath }/groupware/menual/menualList.do"  id="ListBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-weight:bold; width:25%; font-family: 'IBM Plex Sans KR', sans-serif;">목록</a>		
			</div>
</div>
</div>