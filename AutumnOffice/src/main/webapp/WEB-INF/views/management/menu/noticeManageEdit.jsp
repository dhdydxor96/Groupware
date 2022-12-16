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
	width:14%
}
.nocFiles{
	width : 30%;
}
</style>
	<div class="card mb-3" style="padding:1%; text-align: center; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<h3 style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left;font-size: 30px"><span class="fas fa-volume-up"></span>&nbsp;공지사항 수정</h3>
	<hr>
	<br>
		<form:form id="noticeForm" method="post" modelAttribute="notice" enctype="multipart/form-data" action="?${_csrf.parameterName}=${_csrf.token}">
		<form:hidden path="nocVie" />
		<form:input type="hidden" path="nocNo" required="true" class="form-control" />	
			<table  class="table table-bordered" style="width: 100%; ">
				<tr>
					<th>제목</th>
					<td class="form-group comtitle" colspan="2" style="height: 70%">
						<form:input path="nocTit" required="true" class="form-control" style="margin-top:1%;margin-bottom:1%" />
						<form:errors path="nocTit" element="span" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td  colspan="2" style="height: 70%">
						<div class="nocCon">
							<form:textarea path="nocCon" class="form-control" cols="30" rows="5" />
							<form:errors path="nocCon" element="span" class="error"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>기존 첨부파일</th>
					<td style="height: 70%">
						<c:forEach items="${notice.attatchList }" var="attatch">
							<c:if test="${attatch.attNo != null}">
								<span class="fileArea" style="float: left; margin-left: 2%;">
									${attatch.attFnm }
									<span class="btn btn-outline-primary delBtn" data-att-no="${attatch.attNo }">삭제</span>
								</span>
							</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th class="newAttatch">신규 첨부파일</th>
					<td id="reFile" style="height: 70%">
						<c:choose>
							<c:when test="${fn:length(notice.attatchList) == 0 }">
								<input type="file" name="nocFiles" class = "nocFiles" style="float: left; margin-left: 1%;"/>
								<input type="file" name="nocFiles" class = "nocFiles" style="float: left; margin-left: 1%;"/>
								<input type="file" name="nocFiles" class = "nocFiles" style="float: left; margin-left: 1%;"/>
							</c:when>
							<c:when test="${fn:length(notice.attatchList) == 1 }">
								<c:forEach items="${notice.attatchList }" var="attatch">
									<c:if test="${attatch.attNo != null}">
										<input type="file" name="nocFiles" class = "nocFiles" style="float: left; margin-left: 1%;"/>
										<input type="file" name="nocFiles" class = "nocFiles" style="float: left; margin-left: 1%;"/>
									</c:if>
									<c:if test="${attatch.attNo == null}">
										<input type="file" name="nocFiles" class = "nocFiles" style="float: left; margin-left: 1%;"/>
										<input type="file" name="nocFiles" class = "nocFiles" style="float: left; margin-left: 1%;"/>
										<input type="file" name="nocFiles" class = "nocFiles" style="float: left; margin-left: 1%;"/>
									</c:if>
								</c:forEach>
							</c:when>
							<c:when test="${fn:length(notice.attatchList) == 2 }">
								<input type="file" name="nocFiles" class = "nocFiles" style="float: left; margin-left: 1%;"/>
							</c:when>
						</c:choose>
					</td>
				</tr>
			</table>
			<br>
			<div>
				<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="width: 25%; font-weight: bold;">수정</form:button>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:onclick()" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width:25%; ">취소</a>
			</div>
		</form:form>
		<br>
		<br>
	</div>
<script>
	CKEDITOR.replace('nocCon', {
		height : 250,
		filebrowserImageUploadUrl:"${cPath}/groupware/board/imageUpload.do?type=image"
	});
	let noticeForm = $("#noticeForm");
	$(".delBtn").on("click", function(event){
		let attNo = $(this).data("attNo");
		let newInput = $("<input>").attr({
			type:"text"
			, name:"delAttNos"
		}).val(attNo);
		noticeForm.append(newInput);
		newInput.hide();
		$(this).parents("span.fileArea").hide();
		$("#reFile").append("<input type='file' name='nocFiles' style='float: left; margin-left: 1%;'/>")
	});
	
	//취소버튼 선언(리스트페이지로 이동)
	let cancelButton = $(".mb-cancelButton");
	function onclick(){
	   location.href="${cPath}/management/menu/noticeView.do?what="+${notice.nocNo };       
	};							
	
</script>