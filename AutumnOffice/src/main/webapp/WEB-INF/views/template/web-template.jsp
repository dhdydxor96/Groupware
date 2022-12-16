<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>	
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Autumn Office</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- ====== preScript Section =====-->
<tiles:insertAttribute name="preScript" />
<!-- ====== preScript End ========= -->

<!-- =======================================================
  * Template Name: Arsha - v4.9.1
  * Template URL: https://bootstrapmade.com/arsha-free-bootstrap-html-template-corporate/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>
	<!-- ======= Header ======= -->
	<tiles:insertAttribute name="header"/>
	<!-- ======= Header End ======= -->
	
	<!-- ======= Hero Section ======= -->
	<tiles:insertAttribute name="hero"/>
	<!-- ======= Hero End ======= -->
	
	<main id="main">
		<tiles:insertAttribute name="main"/>
	</main>
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<tiles:insertAttribute name="footer"/>
	<!-- End Footer -->

	<div id="preloader"></div>
	<a href="#" class="back-to-top d-flex align-items-center justify-content-center">
		<i class="bi bi-arrow-up-short"></i>
	</a>
	
	<!-- postScript Section -->
	<tiles:insertAttribute name="postScript"/>
</body>

</html>