<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ======= Hero Section ======= -->
<section id="hero" class="d-flex align-items-center">
	<div class="container">
		<div class="row">
			<div class="col-lg-6 d-flex flex-column justify-content-center pt-4 pt-lg-0 order-2 order-lg-1"
				data-aos="fade-up" data-aos-delay="200">
				<h1>Better Solutions</h1>
				<h1>For Your Business</h1>
				<h2>당신의 업무에 날개를 달아줍니다.</h2>
				<div class="d-flex justify-content-center justify-content-lg-start">
					<a href="${pageContext.request.contextPath }/web/consulting/consultingProtect.do" class="btn-get-started scrollto">서비스 신청하기</a> 
				</div>
				<div class="d-flex justify-content-center justify-content-lg-start">
					<a href="${pageContext.request.contextPath }/groupware/login/login.do" class="btn-get-started scrollto">그룹웨어 접속하기</a> 
				</div>
			</div>
			<div class="col-lg-6 order-1 order-lg-2 hero-img" data-aos="zoom-in" data-aos-delay="200">
				<img src="${pageContext.request.contextPath }/resources/web/assets/img/hero-img.png" class="img-fluid animated" alt="">
			</div>
		</div>
	</div>
</section>
<!-- End Hero -->