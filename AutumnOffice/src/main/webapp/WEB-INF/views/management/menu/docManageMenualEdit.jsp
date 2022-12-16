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
.menualEdit{
	padding : 1%;
}
.card{
	padding : 1%;
}
th{
	width : 17%;
}
.att{
	font-size : 13px;
}
input{
	margin-top : 1%;
	margin-bottom : 1%;
	font-family: 'IBM Plex Sans KR', sans-serif
}
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>

<div class="card md-3">
<h4 style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight:bold; font-size:30px;margin-top:1%"><span class="far fa-list-alt"></span>&nbsp;매뉴얼 수정</h4>
<hr>
<br>
<form:form id="docManageMenualForm" method="post" modelAttribute="rule" enctype="multipart/form-data" >
	
	<form:hidden path="rulNo" />
	
	<table class="table table-bordered">
		<tr>
			<th>제목</th>
			<td>
				<form:input path="rulTit" required="true" class="form-control"/>
				<form:errors path="rulTit" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<form:input path="" class="form-control" value="관리자" readonly="true"/>
				<form:errors path="" element="span" cssClass="error" />
			</td>
		</tr>		
	<tr>
		<th>기존 첨부파일</th>
		<td>
			<c:forEach items="${rule.attatchList }" var="attatch">
				<span class="fileArea">
					${attatch.attFnm }&nbsp;
					<span class="btn btn-outline-primary me-1 mb-1 delBtn" data-att-no="${attatch.attNo }" style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight: bold">삭제</span>
				</span>
			</c:forEach>
		</td>
	</tr>
	<tr>
		<th>신규 첨부파일</th>
		<td id="reFile">
			<c:choose>
				<c:when test="${fn:length(rule.attatchList) == 0 }">
					<input class="att" type="file" name="rulFiles" />
					<input class="att" type="file" name="rulFiles" />
					<input class="att" type="file" name="rulFiles" />
				</c:when>
				<c:when test="${fn:length(rule.attatchList) == 1 }">
					<input class="att" type="file" name="rulFiles" />
					<input class="att" type="file" name="rulFiles" />
				</c:when>
				<c:when test="${fn:length(rule.attatchList) == 2 }">
					<input class="att" type="file" name="rulFiles" />
				</c:when>
			</c:choose>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
			<form:textarea path="rulCon" style="font-family: 'IBM Plex Sans KR', sans-serif;"/>
			<form:errors path="rulCon" element="span" class="error"/>
		</td>
	</tr>
	</table>
	<div style="text-align: center">
		<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="margin-top:1%;font-family: 'IBM Plex Sans KR', sans-serif;font-weight:bold;width:25%">매뉴얼 수정</form:button>
		<a href="${cPath }/management/menu/docManageMenualView.do?what=${rule.rulNo}" class="btn btn-outline-secondary me-1 mb-1" style="width: 100px;
 				margin-left: 1%; margin-top: 1%;font-family: 'IBM Plex Sans KR', sans-serif;font-weight:bold;width:25%;">취소</a>
	</div>
	<br>
</form:form>  
</div>
<script>
	CKEDITOR.replace('rulCon');
	let docManageMenualForm = $("#docManageMenualForm");
	$(".delBtn").on("click", function(event){
		let attNo = $(this).data("attNo");
		let newInput = $("<input>").attr({
			type:"hidden"
			, name:"delAttNos"
		}).val(attNo);
		docManageMenualForm.append(newInput);
		$(this).parents("span.fileArea").hide();
		$("#reFile").append("<input type='file' name='rulFiles' />")
	});
	
</script>