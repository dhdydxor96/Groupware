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
<br><br><br>
<h1 style="font-family: 'IBM Plex Sans KR', sans-serif;">상담문의 수정</h1>
<br><br>
<form:form id="adviceForm" method="post" modelAttribute="advice" enctype="multipart/form-data" >
	
	<form:hidden path="advNo" />
	
	<table class="table table-bordered" style="width: 80%; margin-left: 10%; vertical-align: middle; text-align: center;">
		<tr>
			<th>제목</th>
			<td>
				<form:input path="advTit" required="true" class="form-control"/>
				<form:errors path="advTit" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<form:input path="advNm" class="form-control" readonly="true"/>
				<form:errors path="advNm" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<input type="password" name="advPass" class="form-control"/>
				<form:errors path="advPass" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				<form:input path="advPh" required="true" class="form-control"/>
				<form:errors path="advPh" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>기존 첨부파일</th>
			<td>
				<c:forEach items="${advice.attatchList }" var="attatch">
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
					<c:when test="${fn:length(advice.attatchList) == 0 }">
						<input type="file" name="advFiles" style="float: left; width: 30%;"/>
						<input type="file" name="advFiles" style="float: left; width: 30%;"/>
						<input type="file" name="advFiles" style="float: left; width: 30%;"/>
					</c:when>
					<c:when test="${fn:length(advice.attatchList) == 1 }">
						<input type="file" name="advFiles" style="float: left; width: 30%;"/>
						<input type="file" name="advFiles" style="float: left; width: 30%;"/>
					</c:when>
					<c:when test="${fn:length(advice.attatchList) == 2 }">
						<input type="file" name="advFiles" style="float: left; width: 30%;"/>
					</c:when>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<form:textarea path="advCon"/>
				<form:errors path="advCon" element="span" class="error"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<form:button type="submit" class="btn btn-success" style="width: 15%;font-size: 15px;font-weight: bold;float: left;margin-right: 5%; font-family: 'IBM Plex Sans KR', sans-serif; margin-left:32%;">상담문의 수정</form:button>
			<a href="${cPath }/web/advice/adviceList.do" id="backBtn" class="btn btn-danger" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width: 15%;">목록</a>
			</td>
		</tr>
	</table>
		
</form:form>   
<script>
	CKEDITOR.replace('advCon');
	let adviceForm = $("#adviceForm");
	$(".delBtn").on("click", function(event){
		let attNo = $(this).data("attNo");
		let newInput = $("<input>").attr({
			type:"hidden"
			, name:"delAttNos"
		}).val(attNo);
		adviceForm.append(newInput);
		$(this).parents("span.fileArea").hide();
		$("#reFile").append("<input type='file' name='advFiles' />")
	});
	
</script>