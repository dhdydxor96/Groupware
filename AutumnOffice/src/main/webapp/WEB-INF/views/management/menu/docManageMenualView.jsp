<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
	.boardContent{
		text-align: center;
	}
	.card{
		padding : 1%;
	}
	td{
		font-family: 'IBM Plex Sans KR', sans-serif;
		text-align : center;
	}
	th{
		font-family: 'IBM Plex Sans KR', sans-serif;
		text-align : center;
		width: 25%;
	}
</style>

<div class="card md-3">
	<div>
		<h4 style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight:bold; font-size:30px;float: left;margin-top: 1%"><span class="far fa-list-alt"></span>&nbsp;매뉴얼 상세정보</h4>
		<c:url value="/management/menu/docManageMenualUpdate.do" var="updateURL">
				<c:param name="what" value="${rule.rulNo }"/>
		</c:url>
		<div style="text-align:right;margin-top: 1%">
			<a href="${updateURL}" style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight: bold;width:10%;" class="btn btn-outline-primary me-1 mb-1" >수정</a>&nbsp;&nbsp;
			<a href="#" onclick="deleteForm.submit();" id="deleteBtn" class="btn btn-outline-primary me-1 mb-1"  style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight: bold;width: 10%">삭제</a>
		</div>
	</div>
	<hr> 
	<table class="table table-bordered" >
		<tr>
			<th>제목</th>
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
					<c:url value="/management/menu/download.do" var="downloadURL">
						<c:param name="what" value="${attatch.attNo }"/>
					</c:url>
						<c:if test="${not empty attatch.attFnm}">
							<a href="${downloadURL }">${attatch.attFnm }</a>(${attatch.attFas })
							${not vs.last?"|":"" }
						</c:if>
				</c:forEach>
			</td>
		</tr>
	</table>
	<form:form id="deleteForm" action="${cPath }/management/menu/docManageMenualDelete.do" method="post">
		<input type="hidden" name="rulNo" value="${rule.rulNo }"/>
	</form:form>
	
	<h3 class="menualWrite" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold" align="center">게시글 내용</h3>
	
	<div style="border: 1px solid #dee2e6;
	    text-align: left;
	    width: 100%;
	    margin-left: 0%;
	    height: 100%;
	    padding-left: 3%;
	    padding-right: 3%;
	    padding-top: 3%;
	    padding-bottom: 15%;
	    font-family: 'IBM Plex Sans KR', sans-serif;"
	    >
			${rule.rulCon }
	</div>
	<br>
	<div style="text-align:center; padding : 2%;">
		<a style="width:25%;font-family: 'IBM Plex Sans KR', sans-serif;font-weight: bold" href="${cPath }/management/menu/docManageMenualList.do"  id="ListBtn" class="btn btn-outline-secondary me-1 mb-1">목록</a>		
	</div>
</div>
