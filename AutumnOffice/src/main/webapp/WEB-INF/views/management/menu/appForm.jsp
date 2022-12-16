<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center;">
	<br>
	<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; text-align: left;font-size: 30px "><span class="fas fa-clipboard"></span>&nbsp;전자결재 양식 등록</h1>
	<hr>
	<br>
	<form:form method="post" modelAttribute="appForm">
		<table class="table table-bordered">
		<tr>
			<th style="text-align : left;">전자결재 양식명</th>
			<td>
				<form:input path="apfNm" id="apfNm" required="true" class="form-control" style="text-align : left; float: left; margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="apfNm" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align : left;">전자결재 종류</th>
			<td style="height: 70%">
				<select class="form-control" name="apfCat" id="apfCat" >
			    	<option class="option_slt" id="choice1" value="연차">연차</option>
			    	<option class="option_slt" id="choice2" value="협조">협조</option>
			    	<option class="option_slt" id="choice3" value="출장">출장</option>
			    	<option class="option_slt" id="choice4" value="휴가">휴가</option>
	    		</select>
			</td>
		</tr>
		</table>
		<br>
				<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="width: 25%; font-weight: bold;margin-right: 5%;" id="formBtn">전자설문 양식 등록</form:button>
				<a href="${cPath }/management/menu/appFormList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width: 25%;">취소</a>
	</form:form>
	<br>	
</div>
    