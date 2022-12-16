<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<c:set var="advReplyList" value="${advReply }"/>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
th{
	width:20%;
	font-family: 'IBM Plex Sans KR', sans-serif;
}
td{
	width:40%;
	font-family: 'IBM Plex Sans KR', sans-serif;
}
p{
	text-align:left;
	padding: 30px 10px;
}
</style>
<br><br><br>
<h1 style="font-family: 'IBM Plex Sans KR', sans-serif;">상담문의 상세보기</h1>
		<c:url value="/web/advice/adviceUpdate.do" var="updateURL">
				<c:param name="what" value="${advice.advNo }"/>
		</c:url>
		<a href="${updateURL}" class="btn btn-primary" style="margin-left: 71%; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">수정</a>
			<a href="#" id="deleteBtn" class="btn btn-danger" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">삭제</a>
<br><br>
<table class="table table-bordered" style="width: 60%;
    margin-left: 20%;">
	<tr>
		<th>게시글 제목</th>
		<td>${advice.advTit }</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>${advice.advNm }</td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td>${advice.advPh }</td>
	</tr>
	<tr>
		<th>작성일</th>
		<td>${advice.advDate }</td>
	</tr>	
	<tr>
		<th>첨부파일</th>
		<td>
			<c:forEach items="${advice.attatchList }" var="attatch" varStatus="vs">
				<c:url value="/web/advice/download.do" var="downloadURL">
					<c:param name="what" value="${attatch.attNo }"/>
				</c:url>
					<a href="${downloadURL }">${attatch.attFnm }</a>(${attatch.attFas })
					${not vs.last?"|":"" }
			</c:forEach>
		</td>
	</tr>
</table>

<form name="deleteForm" method="post" action="${cPath }/web/advice/adviceDelete.do">
	<input type="hidden" name="advNo" value="${advice.advNo }"/>
	<input type="hidden" name="advPass">
</form>

<h3>게시글 내용</h3>

<div style="border: 1px solid #dee2e6;
	text-align: left;
    width: 60%;
    margin-left: 20%;
    height: 100%;">
		${advice.advCon }
</div>
<br><br>
<table class="table table-bordered table-strip" style="width: 50%;
	    margin-left: 25%;">
	    <h3>댓글 목록</h3>
		<tbody id="replyBody">
		<c:forEach items="${advReplyList }" var="advReply">
			<tr>
				<td style="width: 3%; text-align: center;">${advReply.arepNo }</td>
				<td style="width: 5%; text-align: center;">${advReply.arepWri }</td>
				<td style="width: 29%;">${advReply.arepCon }</td>
				<td style="text-align: center; width: 11%;">${advReply.arepDate }</td>
				<td style="text-align: center; width: 7%;">
					<c:url value="/web/advice/replyDelete.do" var="deleteURL">
						<c:param name="reply" value="${advReply.arepNo }"/>
						<c:param name="advice" value="${advice.advNo }"/>
					</c:url>
					<a href="${deleteURL }" id="deleteReply" class="btn btn-danger">댓글 삭제</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
	<br>
	<div>
		<form action="${cPath}/web/advice/replyInsert.do" method="post" style="border: 1px solid #dee2e6;
	    width: 60%;
	    margin-left: 20%;
	    padding: 25px;">
			<div><input type="hidden" class="form-control" name="advNo" value="${advice.advNo }"/></div>
			<div>
				<h5 style="text-align: left;">댓글 작성자</h5>
				<input type="text" class="form-control" name="arepWri" style="width: 20%; height: 50px;"/>
			</div>
			<br>
			<div>
				<h5 style="text-align: left;">댓글 내용</h5>
				<textarea rows="6" cols="110" name="arepCon" style="width:100%;" class="form-control"></textarea>
			</div>
			<br>
			<button type="submit" class="btn btn-success" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">댓글 작성</button>
		</form>
	</div>
	<br><br>
	<a href="${cPath }/web/advice/adviceList.do" id="backBtn" class="btn btn-danger" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width: 15%; margin-left:43%;">목록</a>



<script>
	$("#deleteBtn").on("click", function(event){
		event.preventDefault();
		let password = prompt("비밀번호");
		if(password){
			document.deleteForm.advPass.value=password;
			$(document.deleteForm).submit();
			document.deleteForm.reset();
		}
		return false;
	});
</script>	




















