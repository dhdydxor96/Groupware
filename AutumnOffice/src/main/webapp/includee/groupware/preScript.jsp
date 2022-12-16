<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>


<!-- ======================캘린더 전용==================================== -->
<%--     <script src="${cPath}/resources/FullCalendar/vendor/js/bootstrap.min.js"></script> --%>
    <script src="${cPath}/resources/FullCalendar/vendor/js/moment.min.js"></script>
    <script src="${cPath}/resources/FullCalendar/vendor/js/fullcalendar.min.js"></script>
<%--     <script type="text/javascript" src='${cPath}/resources/FullCalendar/vendor/js/jquery.min.js'></script> --%>
    <script src="${cPath}/resources/FullCalendar/vendor/js/ko.js"></script>
    <script src="${cPath}/resources/FullCalendar/vendor/js/select2.min.js"></script>
    <script src="${cPath}/resources/FullCalendar/vendor/js/bootstrap-datetimepicker.min.js"></script>
<!-- =================================================================-->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


 <!-- ==============================캘린더 전용 ==============================================-->
 	<link rel="stylesheet" href="${cPath}/resources/FullCalendar/vendor/css/fullcalendar.min.css" />
<%--     <link rel="stylesheet" href="${cPath}/resources/FullCalendar/vendor/css/bootstrap.min.css"> --%>
    <link rel="stylesheet" href='${cPath}/resources/FullCalendar/vendor/css/select2.min.css' />
    <link rel="stylesheet" href='${cPath}/resources/FullCalendar/vendor/css/bootstrap-datetimepicker.min.css' />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="${cPath}/resources/FullCalendar/css/main.css">
 <!-- ==================================================================================== -->


<!-- ===============================================-->
<!--    Favicons-->
<!-- ===============================================-->
<link rel="apple-touch-icon" sizes="180x180" href="${cPath }/groupware/main/groupwareCompanyImageView.do">
<link rel="icon" type="image/png" sizes="32x32" href="${cPath }/groupware/main/groupwareCompanyImageView.do">
<link rel="icon" type="image/png" sizes="16x16" href="${cPath }/groupware/main/groupwareCompanyImageView.do">
<link rel="shortcut icon" type="image/x-icon" href="${cPath }/groupware/main/groupwareCompanyImageView.do">
<link rel="manifest" href="${pageContext.request.contextPath}/resources/groupware/assets/img/favicons/manifest.json">
<meta name="msapplication-TileImage" content="${cPath }/groupware/main/groupwareCompanyImageView.do">
<meta name="theme-color" content="#ffffff">
<script src="${pageContext.request.contextPath}/resources/groupware/assets/js/config.js"></script>
<script src="${pageContext.request.contextPath}/resources/groupware/vendors/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/groupware/assets/js/flatpickr.js"></script>
<!-- 채팅전용 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<!-- ===============================================-->
<!--    Stylesheets-->
<!-- ===============================================-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/groupware/vendors/simplebar/simplebar.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/groupware/assets/css/theme-rtl.min.css" rel="stylesheet" id="style-rtl">
<link href="${pageContext.request.contextPath}/resources/groupware/assets/css/theme.min.css" rel="stylesheet" id="style-default">
<link href="${pageContext.request.contextPath}/resources/groupware/assets/css/user-rtl.min.css" rel="stylesheet" id="user-style-rtl">
<link href="${pageContext.request.contextPath}/resources/groupware/assets/css/user.min.css" rel="stylesheet" id="user-style-default">
<link href="${pageContext.request.contextPath}/resources/groupware/vendors/flatpickr/flatpickr.min.css" rel="stylesheet" />
<link rel="stylesheet" href="${cPath }/resources/toast/css/toastr.css"/>



<script>
	var isRTL = JSON.parse(localStorage.getItem('isRTL'));
	if (isRTL) {
	  var linkDefault = document.getElementById('style-default');
	  var userLinkDefault = document.getElementById('user-style-default');
	  linkDefault.setAttribute('disabled', true);
	  userLinkDefault.setAttribute('disabled', true);
	  document.querySelector('html').setAttribute('dir', 'rtl');
	} else {
	  var linkRTL = document.getElementById('style-rtl');
	  var userLinkRTL = document.getElementById('user-style-rtl');
	  linkRTL.setAttribute('disabled', true);
	  userLinkRTL.setAttribute('disabled', true);
	}
</script>

