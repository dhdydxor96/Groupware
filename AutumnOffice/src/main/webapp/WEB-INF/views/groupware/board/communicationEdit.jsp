<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/ckeditor/ckeditor.js"></script> 

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
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
select{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>
	<c:set var="board" value="${post.boardList }"/>
	<div class="card mb-3" style="padding:1%; text-align: center; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<h3 style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left; font-size: 30px;"><span class="fas fa-book-open"></span>&nbsp;게시글 수정</h3>
	<hr>
	<br>
		<form:form id="postForm" method="post" modelAttribute="post" enctype="multipart/form-data" action="?${_csrf.parameterName}=${_csrf.token}">
		<form:hidden path="empId" />
		<form:hidden path="poVie" />
			<form:input type="hidden" path="poNo" required="true" class="form-control poNo" />	
			<table  class="table table-bordered" style="text-align:center; vertical-align: middle;">
				<tr>
					<th style="padding: 1%; width: 15%;">제목</th>
					<td colspan="2">
						<form:input path="poTit" required="true" class="form-control"/>
						<form:errors path="poTit" element="span" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th style="padding: 1%; width: 15%;">내용</th>
					<td>
						<div class="poCon">
							<form:textarea path="poCon" class="form-control" cols="30" rows="5" />
						</div>
					</td>
				</tr>
				<tr>
					<th style="padding: 1%; width: 15%;">기존 첨부파일</th>
					<td>
						<c:forEach items="${post.attatchList }" var="attatch">
							<c:if test="${attatch.attNo != null}">
								<span class="fileArea" style="float: left; margin-left: 1%;">
									${attatch.attFnm }
									<span class="btn btn-primary delBtn" data-att-no="${attatch.attNo }">삭제</span>
								</span>
							</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th style="padding: 1%; width: 15%;">신규 첨부파일</th>
					<td id="reFile">
						<c:choose>
							<c:when test="${fn:length(post.attatchList) == 0 }">
								<input type="file" name="poFiles" class = "poFiles" style="float: left; width:30%;"/>
								<input type="file" name="poFiles" class = "poFiles" style="float: left; width:30%;"/>
								<input type="file" name="poFiles" class = "poFiles" style="float: left; width:30%;"/>
							</c:when>
							<c:when test="${fn:length(post.attatchList) == 1 }">
								<c:forEach items="${post.attatchList }" var="attatch">
									<c:if test="${attatch.attNo != null}">
										<input type="file" name="poFiles" class = "poFiles" style="float: left; width:30%;"/>
										<input type="file" name="poFiles" class = "poFiles" style="float: left; width:30%;"/>
									</c:if>
									<c:if test="${attatch.attNo == null}">
										<input type="file" name="poFiles" class = "poFiles" style="float: left; width:30%;"/>
										<input type="file" name="poFiles" class = "poFiles" style="float: left; width:30%;"/>
										<input type="file" name="poFiles" class = "poFiles" style="float: left; width:30%;"/>
									</c:if>
								</c:forEach>
							</c:when>
							<c:when test="${fn:length(post.attatchList) == 2 }">
								<input type="file" name="poFiles" class = "poFiles" style="float: left; width:30%;"/>
							</c:when>
						</c:choose>
					</td>
				</tr>
			</table>
			<br>
				<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style=" width: 25%; font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; margin-right: 5%;">수정</form:button>
				<a href="javascript:onclick()" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="margin-left:5%; font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width:25%;">취소</a>
			<br>
		</form:form>
		<br>
	</div>
<script>
	CKEDITOR.replace('poCon', {
		height : 300,
		filebrowserImageUploadUrl:"${cPath}/groupware/board/imageUpload.do?type=image"
	});
	let postForm = $("#postForm");
	$(".delBtn").on("click", function(event){
		let attNo = $(this).data("attNo");
		let newInput = $("<input>").attr({
			type:"text"
			, name:"delAttNos"
		}).val(attNo);
		postForm.append(newInput);
		newInput.hide();
		$(this).parents("span.fileArea").hide();
		$("#reFile").append("<input type='file' name='poFiles' style='float: left; margin-left: 1%; margin-top: 1%; width:34%;'/>")
	});
	
	//취소버튼 선언(리스트페이지로 이동)
	let cancelButton = $(".mb-cancelButton");
	function onclick(){
	   location.href="${cPath}/groupware/board/communicationView.do?what="+${post.poNo};       
	};
	
</script>