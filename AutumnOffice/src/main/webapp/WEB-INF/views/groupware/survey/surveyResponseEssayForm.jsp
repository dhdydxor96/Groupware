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
	font-weight: bold;
}
</style>
<div class="card mb-3" style="padding:1%; text-align: center;  font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<h3 style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left; font-size:30px;"><span class="fas fa-chart-pie"></span>&nbsp;주관식 설문 조사 응답</h3>
	<hr>
	<br>
	<c:set var="surveyInvestigation" value="${surveyInvestigation }"/>	
	<table class="table table-bordered" style="width: 100%;">
		<tr>
			<th>설문조사 번호</th>
			<td>${surveyInvestigation.surinvNo }</td>
		</tr>
		<tr>
			<th>설문 제목</th>
			<td>${surveyInvestigation.surTitle }</td>
		</tr>
		<tr>
			<th>설문 목적</th>
			<td>${surveyInvestigation.surPurpose }</td>
		</tr>	
		<tr>
			<th>설문작성 안내내용</th>
			<td>${surveyInvestigation.surGuide }</td>
		</tr>
		<tr>
			<th>설문 기간</th>
			<td>${surveyInvestigation.surSdate } ~ ${surveyInvestigation.surEdate }</td>
		</tr>
	</table>	
	<form:form method="post" modelAttribute="surveyResponse">
		<input type="hidden" id="surinvNo" name="surinvNo" value="${surveyInvestigation.surinvNo}" />
		<input type="hidden" id="empId" name="empId" value="${surveyInvestigation.empId}">
		<table class="table table-bordered">
			<tr>
				<td style="font-weight:bold;">${surveyInvestigation.surqueContent }</td>
			</tr>
			<tr>
				<td>
					<textarea rows="5" cols="50" name="surresEssay" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold;"></textarea>
				</td>
			</tr>
		</table>
		<br>
				<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="width: 25%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;" id="formBtn">응답 제출</form:button>
				<a href="${cPath }/groupware/survey/surveyProgressList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="width:25%; margin-left:5%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">목록</a>
	</form:form>
	<br>
		
</div>
<script>
fn_idChk();

$(document).ready(function(){
	let surinvNo = $("[name=surinvNo]");
	let empId = $("[name=empId]");
	
	console.log(surinvNo.val());
	console.log(empId.val());
	
})

$("#formBtn").hide();

function fn_idChk(){
	$.ajax({
		url : "${cPath}/groupware/survey/idChk",
		type : "get",
		dataType : "json",
		data : { "empId" : $("#empId").val() ,
			 	 "surinvNo" : $("#surinvNo").val()
		},
		success : function(data){
			if(data == 1){
				toastr.error("이미 응답한 설문입니다.");
				$("#formBtn").hide();
			}else if(data == 0){
				$("#formBtn").show();
			}
		}
	})
}
</script>

















