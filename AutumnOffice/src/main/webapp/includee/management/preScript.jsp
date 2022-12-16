<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="icon" href="${cPath }/groupware/main/groupwareCompanyImageView.do" type="image/x-icon"/>
<script src="${pageContext.request.contextPath}/resources/management/assets/js/plugin/webfont/webfont.min.js"></script>
<script>
	WebFont.load({
		google: {"families":["Lato:300,400,700,900"]},
		custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands", "simple-line-icons"], urls: ['${pageContext.request.contextPath}/resources/management/assets/css/fonts.min.css']},
		active: function() {
			sessionStorage.fonts = true;
		}
	});
</script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/management/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/management/assets/css/atlantis.min.css">
<link rel="stylesheet" href="${cPath }/resources/toast/css/toastr.css"/>
<link href="${pageContext.request.contextPath}/resources/management/assets/css/customcss.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/management/assets/js/plugin/chart.js/chart.min.js"></script>
<script src="${cPath }/resources/toast/js/toastr.min.js"></script>
<script>
//toast setting================================
toastr.options.positionClass="toast-bottom-right";
toastr.options.timeOut = 1500;
// =============================================
</script>


