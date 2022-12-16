<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>	
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<title>관리자페이지</title>
	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	
	<!-- preScript -->
	<tiles:insertAttribute name="preScript"/>
	<!-- preScript end -->
	
</head>
<body>
	<div class="wrapper">
		
		<!-- header  -->
		<tiles:insertAttribute name="header"/>
		<!-- header end -->
		
		<!-- leftMenu -->
		<tiles:insertAttribute name="leftMenu"/>
		<!-- leftMenu end -->
		<div class="main-panel">
			<div class="content content-documentation">
				<div class="container-fluid">
					<!-- main -->
					<tiles:insertAttribute name="main"/>
					<!-- end -->
				</div>
			</div>
		</div>
	</div>
</body>
<!-- postScript -->
<tiles:insertAttribute name="postScript"/>
<!-- postScript end -->
</html>