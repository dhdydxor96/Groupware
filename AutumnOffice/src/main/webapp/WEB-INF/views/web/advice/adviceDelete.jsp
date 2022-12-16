<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>  
<form:form method="post" modelAttribute="advice">
	<form:hidden path="advNo"/>
	<table class="table table-bordered">
	<tr>
		<th>비밀번호</th>
		<td>
			<input type="password" name="advPass" class="form-control"/>
			<form:errors path="advPass" element="span" class="error"/>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<form:button type="submit" class="btn btn-success">삭제</form:button>
			<form:button type="reset" class="btn btn-danger">취소</form:button>
		</td>
	</tr>
</table>
</form:form>