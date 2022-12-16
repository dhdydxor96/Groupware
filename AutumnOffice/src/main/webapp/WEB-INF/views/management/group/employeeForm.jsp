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
	<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; text-align:left; font-size:30px; font-weight:bold; "><span class="fas fa-user-tie"></span>&nbsp;사원 등록</h1>
	<hr>
	<br>
	<form:form method="post" modelAttribute="employee" enctype="multipart/form-data">
		<table class="table table-bordered">
		<tr>
			<th style="text-align:left;">사원 아이디</th>
			<td style="height: 70%">
				<form:input path="empId" required="true" class="form-control" style="text-align:left; width: 70%; float: left; margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="empId" element="span" cssClass="error" />
				<button class="btn btn-outline-primary me-1 mb-1" type="button" id="idChk" onclick="fn_idChk();" value="N" style="font-weight:bold; font-family: 'IBM Plex Sans KR', sans-serif; float: left; width: 25%; margin-left: 5%;margin-top: 1%">중복 확인</button>
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">부서</th>
			<td style="height: 70%">
				<form:select path="depId" class="form-control"  style="font-family: 'IBM Plex Sans KR', sans-serif; margin-top:1%; margin-bottom:1%; text-align:left;">
					<option value></option>
					<c:forEach items="${departmentList }" var="department">
						<form:option value="${department.depId }" label="${department.depNm }" />
					</c:forEach>
				</form:select>
				<form:errors path="depId" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">직위</th>
			<td style="height: 70%">
				<form:select path="jobId" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;margin-top:1%; margin-bottom:1%;text-align:left; ">
					<option value></option>
					<c:forEach items="${jobList }" var="job">
						<form:option value="${job.jobId }" label="${job.jobNm }" />
					</c:forEach>
				</form:select>
				<form:errors path="jobId" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 비밀번호</th>
			<td style="height: 70%">
				<form:password path="empPass" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;margin-top:1%; margin-bottom:1%; text-align:left;"/>
				<form:errors path="empPass" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 이름</th>
			<td style="height: 70%">
				<form:input path="empNm" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; margin-top:1%; margin-bottom:1%; text-align:left;"/>
				<form:errors path="empNm" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 생년월일</th>
			<td style="height: 70%">
				<input type="date" name="empBid" required="required" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;margin-top:1%; margin-bottom:1%; text-align:left;">
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 이메일</th>
			<td style="height: 70%">
				<form:input path="empMail" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;margin-top:1%; margin-bottom:1%; text-align:left;"/>
				<form:errors path="empMail" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 핸드폰번호</th>
			<td style="height: 70%">
				<form:input path="empPh" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;margin-top:1%; margin-bottom:1%; text-align:left;"/>
				<form:errors path="empPh" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 주소</th>
			<td style="height: 70%">
				<form:input path="empAddr" required="true" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;margin-top:1%; margin-bottom:1%; text-align:left;"/>
				<form:errors path="empAddr" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">사원 입사일</th>
			<td style="height: 70%">
				<input type="date" required="required" name="empHid" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;margin-top:1%; margin-bottom:1%; text-align:left;">
			</td>
		</tr>
		<tr>
			<th style="text-align:left;">프로필 사진</th>
			<td style="height: 70%">
				<input type="file" name="empFiles" style="float: left; font-family: 'IBM Plex Sans KR', sans-serif;margin-top:1%; margin-bottom:1%; text-align:left;"/>
			</td>
		</tr>
		</table>
		<br>
			<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="width: 25%; margin-right: 5%; font-weight:bold;" id="formBtn">사원 등록</form:button>
			<a href="${cPath }/management/group/employee/employeeList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-weight:bold; font-family: 'IBM Plex Sans KR', sans-serif;  width: 25%; ">취소</a>
	</form:form>	
		<br>
</div>

<script>

$("#formBtn").hide();

function fn_idChk(){
	$.ajax({
		url : "${cPath}/management/group/employee/idChk",
		type : "get",
		dataType : "json",
		data : { "empId" : $("#empId").val() ,
		},
		success : function(data){
			if(data == 1){
				toastr.error("중복된 사원아이디입니다.");
				$("#formBtn").hide();
			}else if(data == 0){
				$("#idChk").attr("value", "Y");
				toastr.info("사용가능한 사원아이디입니다.");
				$("#formBtn").show();
			}
		}
	})
}
</script>