<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<c:set var="replyList" value="${reply}"/>
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
	<!-- -------------------------- -->
   	 <!-- 문의사항 상세보기 페이지(웹페이지) -->
   	<!-- -------------------------- -->
<div>
	<br><br><br>
	<h1 style="font-family: 'IBM Plex Sans KR', sans-serif;">문의사항 상세보기</h1>
			<c:url value="/web/matters/mattersUpdate.do" var="updateURL">
					<c:param name="what" value="${matters.matNo }"/>
			</c:url>
			<a href="${updateURL}" class="btn btn-primary" style="margin-left: 71%; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">수정</a>
			<a href="#" id="deleteBtn" class="btn btn-danger" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">삭제</a>
	<br><br>
	<table class="table table-bordered" style="width: 60%;
	    margin-left: 20%;">
		<tr>
			<th>게시글 제목</th>
			<td>${matters.matTit }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${matters.matNm }</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${matters.matDate }</td>
		</tr>	
		<tr>
			<th>첨부파일</th>
			<td>
				<c:forEach items="${matters.attatchList }" var="attatch" varStatus="vs">
					<c:url value="/web/matters/download.do" var="downloadURL">
						<c:param name="what" value="${attatch.attNo }"/>
					</c:url>
						<a href="${downloadURL }">${attatch.attFnm }</a>(${attatch.attFas })
						${not vs.last?"|":"" }
				</c:forEach>
			</td>
		</tr>
	</table>
	<form name="deleteForm" method="post" action="${cPath }/web/matters/mattersDelete.do">
		<input type="hidden" name="matNo" value="${matters.matNo }"/>
		<input type="hidden" name="matPass">
	</form>
	
	<h3>게시글 내용</h3>
	
	<div style="border: 1px solid #dee2e6;
	    text-align: left;
	    width: 60%;
	    margin-left: 20%;
	    height: 100%;
	    "
	    >
			${matters.matCon }
	</div>
	<br><br>
	<!-- -------------------------- -->
   	 <!-- 문의사항 댓글 목록(웹페이지) -->
   	<!-- -------------------------- -->
	<table class="table table-bordered table-strip" style="width: 60%;
	    margin-left: 20%;">
	    <h3>댓글 목록</h3>
		<tbody id="replyBody">
		<c:forEach items="${replyList }" var="reply">
			<tr>
				<td style="width: 3%; text-align: center;">${reply.mrepNo }</td>
				<td style="width: 5%; text-align: center;">${reply.mrepWri }</td>
				<td style="width: 29%;">${reply.mrepCon }</td>
				<td style="text-align: center; width: 11%;">${reply.mrepDate }</td>
				<td style="text-align: center; width: 7%;">
					<c:url value="/web/matters/replyDelete.do" var="deleteURL">
						<c:param name="reply" value="${reply.mrepNo }"/>
						<c:param name="matter" value="${matters.matNo }"/>
					</c:url>
					<a href="${deleteURL }" id="deleteReply" class="btn btn-danger">댓글 삭제</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
	<!-- -------------------------- -->
   	 <!-- 문의사항 댓글 작성(웹페이지) -->
   	<!-- -------------------------- -->
	<br>
	<div>
		<form action="${cPath}/web/matters/replyInsert.do" method="post" style="border: 1px solid #dee2e6;
	    width: 60%;
	    margin-left: 20%;
	    padding: 25px;">
			<div><input type="hidden" class="form-control" name="matNo" value="${matters.matNo }"/></div>
			<div>
				<h5 style="text-align: left;">댓글 작성자</h5>
				<input type="text" class="form-control" name="mrepWri" style="width: 20%; height: 50px;"/>
			</div>
			<br>
			<div>
				<h5 style="text-align: left;">댓글 내용</h5>
				<textarea rows="6" cols="110" name="mrepCon" style="width:100%;" class="form-control"></textarea>
			</div>
			<br>
			<button type="submit" class="btn btn-success" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">댓글 작성</button>
		</form>
	</div>
</div>
	<br><br>
	<!-- -------------------------- -->
   	 <!-- 문의사항 삭제 시 비밀번호 체크 후 삭제 기능 -->
   	<!-- -------------------------- -->
	<a href="${cPath }/web/matters/mattersList.do" id="backBtn" class="btn btn-danger" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width: 15%; margin-left:43%;">목록</a>
<script type="text/javascript">
	$("#deleteBtn").on("click", function(event){
		event.preventDefault();
		let password = prompt("비밀번호");
		if(password){
			document.deleteForm.matPass.value=password;
			$(document.deleteForm).submit();
			document.deleteForm.reset();
		}
		return false;
	});
	
</script>	



















