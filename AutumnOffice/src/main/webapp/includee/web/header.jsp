<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
<header id="header" class="fixed-top ">
    <div class="container d-flex align-items-center">

      <h1 class="logo me-auto" style="font-size:25px;"><a href="${pageContext.request.contextPath }/web/index.do"><img src="${pageContext.request.contextPath }/resources/web/assets/img/Autumn_Office_logo.png" alt="Autumn"/></a>
      Autumn Office
      </h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo me-auto"><img src="web/img/logo.png" alt="" class="img-fluid"></a>-->

      <nav id="navbar" class="navbar">
        <ul>
          <li class="dropdown"><a href="#"><span>회사 소개</span> <i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a href="${pageContext.request.contextPath }/web/intro/officeintro.do">회사 소개</a></li>
              <li><a href="${pageContext.request.contextPath }/web/intro/officehistory.do">회사 연혁</a></li>
              <li><a href="${pageContext.request.contextPath }/web/intro/officefind.do">찾아 오시는 길</a></li>
            </ul>
          </li>
          <li class="dropdown"><a class="nav-link scrollto" href="${pageContext.request.contextPath }/web/application/applicationintro.do"><span>기능 소개</span><i class="bi bi-chevron-down"></i></a>
          	<ul>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationMail.do">메일</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationApproval.do">전자결재</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationWork.do">근태관리</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationAddress.do">주소록</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationCalendar.do">캘린더</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationSurvey.do">설문</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationReservation.do">예약</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationDocument.do">매뉴얼관리</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationBoard.do">공지사항</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationCommunity.do">커뮤니티</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationMessenger.do">메신저</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationFile.do">자료실</a></li>
              <li><a href="${pageContext.request.contextPath }/web/application/applicationManager.do">관리자 기능</a></li>
            </ul>
          </li>
          
          <li><a class="nav-link scrollto" href="${pageContext.request.contextPath }/web/experience/experienceInsert.do" style="font-family: 'IBM Plex Sans KR', sans-serif;">체험</a></li>
          <li><a class="nav-link scrollto" href="${pageContext.request.contextPath }/web/consulting/consultingProtect.do" style="font-family: 'IBM Plex Sans KR', sans-serif;">서비스 신청</a></li>
          <li class="dropdown"><a class="nav-link scrollto" href="#"><span>고객센터</span> <i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a href="${pageContext.request.contextPath }/web/matters/mattersList.do">문의사항</a></li>
              <li><a href="${pageContext.request.contextPath }/web/advice/adviceList.do">상담문의</a></li>
            </ul>
          </li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->
    </div>
  </header><!-- End Header -->