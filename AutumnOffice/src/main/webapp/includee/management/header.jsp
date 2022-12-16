<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<style>
	@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>

<!-- 시큐리티 설정 -->
<security:authorize access="isAuthenticated()">
			<security:authentication property="principal" var="principal"/>
</security:authorize>

<div class="main-header">
	<div class="logo-header" data-background-color="light-blue2">
		<h2 style="text-transform: uppercase;"> 
			<a href="${cPath}/management/index.do" class="logo" style="color:white;font-family: 'IBM Plex Sans KR', sans-serif;font-weight: bold"> ${principal.realUser.comCnm}
			</a>
		</h2>
		<button class="navbar-toggler sidenav-toggler ml-auto" type="button"
			data-toggle="collapse" data-target="collapse" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"> <i class="icon-menu"></i>
			</span>
		</button>
		<button class="topbar-toggler more">
			<i class="icon-options-vertical"></i>
		</button>
		<div class="nav-toggle">
			<button class="btn btn-toggle toggle-sidebar">
				<i class="icon-menu"></i>
			</button>
		</div>
	</div>
	<nav class="navbar navbar-header navbar-expand-lg"
		data-background-color="light-blue2">
		<div class="container-fluid">
			<ul class="navbar-nav topbar-nav ml-md-auto align-items-center">
				<li class="nav-item">
					<a style="color:white;text-decoration: none;font-family: 'IBM Plex Sans KR', sans-serif;font-weight: bold;font-size: 25px" href="#" onclick="logoutForm.submit();"><span class="fas fa-sign-in-alt"></span></a>
					<form id="logoutForm"
						action="${cPath}/management/login/logout.do"
						method="post">
						<security:csrfInput />
					</form>
			</ul>
		</div>
	</nav>
</div>