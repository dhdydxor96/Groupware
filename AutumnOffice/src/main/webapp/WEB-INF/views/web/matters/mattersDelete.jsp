<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>  
	<!-- -------------------------- -->
   	 <!-- 믄의사항 삭제(웹페이지) -->
   	<!-- -------------------------- -->
<form:form method="post" modelAttribute="matters">
	<form:hidden path="matNo"/>
	<table class="table table-bordered">
	<tr>
		<th>비밀번호</th>
		<td>
			<input type="password" name="matPass" class="form-control"/>
			<form:errors path="matPass" element="span" class="error"/>
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