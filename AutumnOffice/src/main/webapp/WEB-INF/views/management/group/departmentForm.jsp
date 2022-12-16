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
	<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; text-align: left;font-size: 30px "><span class="fas fa-sitemap"></span>&nbsp;부서 등록</h1>
	<hr>
	<br>
	<form:form method="post" modelAttribute="department">
		<table class="table table-bordered">
		<tr>
			<th style="text-align : left;">부서 코드</th>
			<td style="height: 70%">
				<form:input path="depId" id="depId" required="true" class="form-control" style="text-align : left; width: 70%; float: left; margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="depId" element="span" cssClass="error" />
   				<button class="btn btn-outline-primary me-1 mb-1" type="button" id="idChk" onclick="fn_idChk();" value="N" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float: left; width: 25%; margin-left: 5%; margin-top:1%;">중복 확인</button>
			</td>
		</tr>
		<tr>
			<th style="text-align : left;">상위 부서 코드</th>
			<td style="height: 70%">
				<form:select path="depHdc" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;text-align : left;  margin-top:1%; margin-bottom:1%;">
					<option value></option>
					<c:forEach items="${departmentList }" var="department">
						<form:option value="${department.depId }" label="${department.depId }" />
					</c:forEach>
				</form:select>
				<form:errors path="depHdc" element="span" cssClass="error" /> 
			</td>
		</tr>
		<tr>
			<th style="text-align : left;">상위 부서명</th>
			<td style="height: 70%">
				<form:select path="depTnm" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif;text-align : left;  margin-top:1%; margin-bottom:1%;">
					<option value></option>
					<c:forEach items="${departmentList }" var="department">
						<form:option value="${department.depNm }" label="${department.depNm }" />
					</c:forEach>
				</form:select>
				<form:errors path="depTnm" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align : left;">부서명</th>
			<td style="height: 70%">
				<form:input path="depNm" class="form-control" style="text-align : left;  margin-top:1%; margin-bottom:1%;"/>
				<form:errors path="depNm" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th style="text-align : left;">부서 책임자</th>
			<td style="height: 70%">
				<form:select path="depMag" required="true" class="form-control"  style="font-family: 'IBM Plex Sans KR', sans-serif; ">
					<option value></option>
					<c:forEach items="${powerList }" var="power">
						<form:option value="${power.empNm }" label="${power.empNm }" />
					</c:forEach>
				</form:select>
				<form:errors path="depMag" element="span" cssClass="error" />
			</td>
		</tr>
		</table>
		<br>
				<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="width: 25%; font-weight: bold;margin-right: 5%;" id="formBtn">부서 등록</form:button>
				<a href="${cPath }/management/group/department/departmentList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width: 25%;">취소</a>
	</form:form>
	<br>	
</div>

<script>

$("#formBtn").hide();

function fn_idChk(){
	$.ajax({
		url : "${cPath}/management/group/department/idChk",
		type : "get",
		dataType : "json",
		data : { "depId" : $("#depId").val() ,
		},
		success : function(data){
			if(data == 1){
				toastr.error("중복된 부서입니다.");
				$("#formBtn").hide();
			}else if(data == 0){
				$("#idChk").attr("value", "Y");
				toastr.info("사용가능한 부서입니다.");
				$("#formBtn").show();
			}
		}
	})
}
</script>