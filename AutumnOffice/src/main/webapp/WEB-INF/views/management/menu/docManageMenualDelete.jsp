<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>  
<form:form action="${cPath }/management/menu/docManageMenualDelete.do" method="post" modelAttribute="rule">
	<form:hidden path="rulNo"/>
	<table class="table table-bordered">
	<tr>
		<td colspan="2">
			<form:button type="submit" class="btn btn-success">삭제</form:button>
			<form:button type="reset" class="btn btn-danger">취소</form:button>
		</td>
	</tr>
</table>
</form:form>