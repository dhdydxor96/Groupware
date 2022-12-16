<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath}/resources/management/assets/js/core/jquery.3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/management/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/management/assets/js/plugin/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/management/assets/js/core/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/management/assets/js/core/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/management/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/management/assets/js/plugin/jqvmap/jquery.vmap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/management/assets/js/plugin/jqvmap/maps/jquery.vmap.world.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/resources/management/assets/js/plugin/chart-circle/circles.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/management/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/management/assets/js/atlantis.min.js"></script>

<script type="text/javascript">
	
	
	// handle links with @href started with '#' only
	$(document).on('click', 'a[href^="#"]', function(e) {
		// target element id
		var id = $(this).attr('href');

		// target element
		var $id = $(id);
		if ($id.length === 0) {
			return;
		}

		// prevent standard hash navigation (avoid blinking in IE)
		e.preventDefault();

		// top position relative to the document
		var pos = $id.offset().top - 80;

		// animated top scrolling
		$('body, html').animate({scrollTop: pos});
	});
</script>