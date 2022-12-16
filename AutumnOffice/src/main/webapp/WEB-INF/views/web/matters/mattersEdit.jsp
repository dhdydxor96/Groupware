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
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>
	<!-- -------------------------- -->
   	 <!-- 문의사항 수정 페이지(웹페이지) -->
   	<!-- -------------------------- -->
<br><br><br>
<h1 style="font-family: 'IBM Plex Sans KR', sans-serif;">문의사항 수정</h1>
<br><br>
<form:form id="mattersForm" method="post" modelAttribute="matters" enctype="multipart/form-data" >
	
	<form:hidden path="matNo" />
	
	<table class="table table-bordered" style="width: 80%; margin-left: 10%; vertical-align: middle; text-align: center;">
		<tr>
			<th>제목</th>
			<td>
				<form:input path="matTit" required="true" class="form-control"/>
				<form:errors path="matTit" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<form:input path="matNm" class="form-control" readonly="true"/>
				<form:errors path="matNm" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<input type="password" name="matPass" class="form-control"/>
				<form:errors path="matPass" element="span" cssClass="error" />
			</td>
		</tr>
	<tr>
		<th>기존 첨부파일</th>
		<td>
			<c:forEach items="${matters.attatchList }" var="attatch">
				<div style="float:left; width:33%;">
				<span class="fileArea" style="float:left; width: 100%;">
					${attatch.attFnm }
					<span class="btn btn-danger delBtn" data-att-no="${attatch.attNo }" style="float: left; width: 30%;">삭제</span>
				</span>
				</div>
			</c:forEach>
		</td>
	</tr>
	<tr>
		<th>신규 첨부파일</th>
		<td id="reFile">
			<c:choose>
				<c:when test="${fn:length(matters.attatchList) == 0 }">
					<input type="file" name="matFiles" style="float: left; width: 30%;"/>
					<input type="file" name="matFiles" style="float: left; width: 30%;"/>
					<input type="file" name="matFiles" style="float: left; width: 30%;"/>
				</c:when>
				<c:when test="${fn:length(matters.attatchList) == 1 }">
					<input type="file" name="matFiles" style="float: left; width: 30%;"/>
					<input type="file" name="matFiles" style="float: left; width: 30%;"/>
				</c:when>
				<c:when test="${fn:length(matters.attatchList) == 2 }">
					<input type="file" name="matFiles" style="float: left; width: 30%;"/>
				</c:when>
			</c:choose>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
			<form:textarea path="matCon"/>
			<form:errors path="matCon" element="span" class="error"/>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<form:button type="submit" class="btn btn-success" style="width: 15%;font-size: 15px;font-weight: bold;float: left;margin-right: 5%; font-family: 'IBM Plex Sans KR', sans-serif; margin-left:30%;">문의사항 수정</form:button>
			<a href="${cPath }/web/matters/mattersList.do" id="backBtn" class="btn btn-danger" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width: 15%;">목록</a>
		</td>
	</tr>
	</table>
	
</form:form>   
<script>
	<!-- -------------------------- -->
	 <!-- 문의사항 수정 시 첨부파일 수정 기능 -->
	<!-- -------------------------- -->
	CKEDITOR.replace('matCon');
	let mattersForm = $("#mattersForm");
	$(".delBtn").on("click", function(event){
		let attNo = $(this).data("attNo");
		let newInput = $("<input>").attr({
			type:"hidden"
			, name:"delAttNos"
		}).val(attNo);
		mattersForm.append(newInput);
		$(this).parents("span.fileArea").hide();
		$("#reFile").append("<input type='file' name='matFiles' />")
	});
	
</script>