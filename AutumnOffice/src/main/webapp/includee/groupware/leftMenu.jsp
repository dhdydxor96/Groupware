<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   
   <!-- 시큐리티 설정 -->
   <security:authorize access="isAuthenticated()">
            <security:authentication property="principal" var="principal"/>
   </security:authorize>

<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
.comTitle{
   font-size: 18px;
   font-family: 'IBM Plex Sans KR', sans-serif;
   text-transform: uppercase;
   color: #232E3C;
}
</style>
   
<script>
   var isFluid = JSON.parse(localStorage.getItem('isFluid'));
   if (isFluid) {
      var container = document.querySelector('[data-layout]');
      container.classList.remove('container');
      container.classList.add('container-fluid');
   }
</script>
<nav class="navbar navbar-light navbar-vertical navbar-expand-xl">
   <script>
      var navbarStyle = localStorage.getItem("navbarStyle");
      if (navbarStyle && navbarStyle !== 'transparent') {
         document.querySelector('.navbar-vertical').classList
               .add(`navbar-${navbarStyle}`);
      }
   </script>
   <div class="d-flex align-items-center">
      <div class="toggle-icon-wrapper">
         <button
            class="btn navbar-toggler-humburger-icon navbar-vertical-toggle"
            data-bs-toggle="tooltip" data-bs-placement="left"
            title="Toggle Navigation">
            <span class="navbar-toggle-icon"><span class="toggle-line"></span></span>
         </button>
      </div>
      <a class="navbar-brand" href="${cPath }/groupware/index.do">
         <div class="d-flex align-items-center py-3">
            <img class="me-2 logoImg" 
               src="${cPath }/groupware/main/groupwareCompanyImageView.do"
             onerror="this.src='${cPath}/resources/web/assets/img/Autumn_Office_logo.png'"
               alt="" width="40" style="width:80px;"/><span class="font-sans-serif comTitle" style="font-size:35px;">${principal.realUser.comCnm}</span>
         </div>
      </a>
   </div>
   
   <!-- 왼쪽 메뉴 시작 -->
   <!-- 홈 -->
   <div class="collapse navbar-collapse" id="navbarVerticalCollapse">
      <div class="navbar-vertical-content scrollbar">
         <ul class="navbar-nav flex-column mb-3" id="navbarVerticalNav">
            <li class="nav-item">
               <!-- parent pages--> 
               <a href="${cPath }/groupware/index.do" class="nav-link" >
                     <div class="d-flex align-items-center" style="margin-top:5%; margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;"><span class="fas fa-home"></span></span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">홈</span>
                     </div>
               </a>
            </li>
               <!-- 메일 -->
               <a class="nav-link dropdown-indicator"
                  href="#email" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="email">
                     <div class="d-flex align-items-center" style=" margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;">
                           <span class="fas fa-envelope-open"></span>
                        </span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">메일</span>
                     </div>
               </a>
                  <ul class="nav collapse" id="email">
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/mail/mailInsert.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">메일 쓰기</span>
                           </div>
                        </a> 
                     </li>
                     <li class="nav-item">
                        <!-- label-->
                        <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                           <div class="col-auto navbar-vertical-label" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:14px;">메일함</div>
                           <div class="col ps-0">
                              <hr class="mb-0 navbar-vertical-divider" />
                           </div>
                        </div> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/mail/mailList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">받은 메일함</span>
                           </div>
                        </a> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/mail/mailForwardList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">보낸 메일함</span>
                           </div>
                        </a>
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/mail/mailImportList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">중요 메일함</span>
                           </div>
                        </a>
                     </li>
               
               
                  </ul>
                  
               <!-- 전자결재 --> 
               <a class="nav-link dropdown-indicator"
                  href="#approval" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="approval">
                     <div class="d-flex align-items-center" style=" margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;">
                           <span class="far fa-clipboard"></span>
                        </span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">전자결재</span>
                     </div>
               </a> 
                  <ul class="nav collapse" id="approval">
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/approval/approvalInsert.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">새 결재 진행</span>
                           </div>
                        </a> 
                     </li>
                     <li class="nav-item">
                        <!-- label-->
                        <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                           <div class="col-auto navbar-vertical-label" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:14px;">결재하기</div>
                           <div class="col ps-0">
                              <hr class="mb-0 navbar-vertical-divider" />
                           </div>
                        </div> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/approval/doc/waitAppDocList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">결재 대기 문서</span>
                           </div>
                        </a>
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/approval/doc/dueAppDocList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">결재 예정 문서</span>
                           </div>
                        </a>
                     </li>
                     <li class="nav-item">
                        <!-- label-->
                        <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                           <div class="col-auto navbar-vertical-label" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:14px;">개인 문서함</div>
                           <div class="col ps-0">
                              <hr class="mb-0 navbar-vertical-divider" />
                           </div>
                        </div> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath}/groupware/approval/doc/draftDocList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">기안 문서함</span>
                           </div>
                        </a>
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath}/groupware/approval/doc/completedDocList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">결재 문서함</span>
                           </div>
                        </a>
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath}/groupware/approval/doc/refDocList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">참조/열람 문서함</span>
                           </div>
                        </a>
                     </li>
                     <li class="nav-item">
                        <!-- label-->
                        <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                           <div class="col-auto navbar-vertical-label" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:14px;">환경설정</div>
                           <div class="col ps-0">
                              <hr class="mb-0 navbar-vertical-divider" />
                           </div>
                        </div> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath}/groupware/approval/setting/signUpdate.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">환경설정</span>
                           </div>
                        </a>
                     </li>
                  </ul>
               
               <!-- 근태 관리 --> 
               <a class="nav-link dropdown-indicator"
                  href="#attendance" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="attendance">
                     <div class="d-flex align-items-center" style=" margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;">
                           <span class="fas fa-business-time"></span>
                        </span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">근태 관리</span>
                     </div>
               </a> 
                  <ul class="nav collapse" id="attendance">
                     <li class="nav-item">
                        <!-- label-->
                        <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                           <div class="col-auto navbar-vertical-label" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:14px;">내 근태 관리</div>
                           <div class="col ps-0">
                              <hr class="mb-0 navbar-vertical-divider" />
                           </div>
                        </div> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath}/groupware/attendance/my/status/myStatusList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">내 근태 현황</span>
                           </div>
                        </a> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath}/groupware/attendance/my/annual/myAnnualList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">내 연차 내역</span>
                           </div>
                        </a> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath}/groupware/attendance/my/privacy/myPrivacyList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">내 인사 정보</span>
                           </div>
                        </a> 
                     </li>
                     <c:forEach items="${authEmp.empRoles }" var="role">
                     	<c:if test='${ (role eq "ROLE_HEAD") or (role eq "ROLE_DIRECTOR")}'>
                     		<c:set var="roleCheck" value="ok"/>
                     	</c:if>
                     </c:forEach>
                     <c:if test="${roleCheck eq 'ok'}">
                     	<li class="nav-item">
	                        <!-- label-->
	                        <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
	                           <div class="col-auto navbar-vertical-label" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:14px;">부서 근태 관리</div>
	                           <div class="col ps-0">
	                              <hr class="mb-0 navbar-vertical-divider" />
	                           </div>
	                        </div> 
	                     </li>
	                     <li class="nav-item">
	                        <a class="nav-link" href="${cPath}/groupware/attendance/dept/status/deptStatusList.do">
	                           <div class="d-flex align-items-center">
	                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">부서 근태 현황</span>
	                           </div>
	                        </a>
	                     </li>
	                     <li class="nav-item">
	                        <a class="nav-link" href="${cPath}/groupware/attendance/dept/statistics/deptStatisticsList.do">
	                           <div class="d-flex align-items-center">
	                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">부서 근태 통계</span>
	                           </div>
	                        </a>
	                     </li>
	                     <li class="nav-item">
	                        <a class="nav-link" href="${cPath}/groupware/attendance/dept/annual/deptAnnualList.do">
	                           <div class="d-flex align-items-center">
	                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">부서 연차 현황</span>
	                           </div>
	                        </a>
	                     </li>
	                     <li class="nav-item">
	                        <a class="nav-link" href="${cPath}/groupware/attendance/deptAnnualHistoryList.do">
	                           <div class="d-flex align-items-center">
	                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">부서 연차 사용 내역</span>
	                           </div>
	                        </a>
	                     </li>
	                     <li class="nav-item">
	                        <a class="nav-link" href="${cPath}/groupware/attendance/dept/privacy/deptPrivacyList.do">
	                           <div class="d-flex align-items-center">
	                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">부서 인사 정보</span>
	                           </div>
	                        </a>
	                     </li>
                     </c:if>
                  </ul>
               
               <!-- 주소록--> 
               <a class="nav-link dropdown-indicator"
                  href="#address" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="address">
                     <div class="d-flex align-items-center" style=" margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;">
                           <span class="far fa-address-book"></span>
                        </span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">주소록</span>
                     </div>
               </a>
                  <ul class="nav collapse" id="address">
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/address/addressList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">전체 주소록</span>
                           </div>
                        </a> 
                     </li>
                  </ul>
               
               <!-- 일정 관리--> 
               <a class="nav-link dropdown-indicator"
                  href="#calendar1" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="calendar1">
                     <div class="d-flex align-items-center" style=" margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;">
                           <span class="far fa-calendar-alt"></span>
                        </span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">일정 관리</span>
                     </div>
               </a>
                  <ul class="nav collapse" id="calendar1">
                     <li class="nav-item">
                        <!-- label-->
                        <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                           <div class="col-auto navbar-vertical-label" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:14px;">일정 조회</div>
                           <div class="col ps-0">
                              <hr class="mb-0 navbar-vertical-divider" />
                           </div>
                        </div> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/calendar/empCalendarList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">개인 일정 조회</span>
                           </div>
                        </a> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/calendar/depCalendarList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">부서 일정 조회</span>
                           </div>
                        </a> 
                     </li>
                  </ul>
               
                <!-- 설문 --> 
               <a class="nav-link dropdown-indicator"
                  href="#survey" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="survey">
                     <div class="d-flex align-items-center" style=" margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;">
                           <span class="fas fa-chart-pie"></span>
                        </span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">전자 설문</span>
                     </div>
               </a>
                  <ul class="nav collapse" id="survey">
                  <c:if test="${roleCheck ne null }">
                  	<li class="nav-item">
                        <!-- label-->
                        <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                           <div class="col-auto navbar-vertical-label" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:14px;">설문조사 등록</div>
                           <div class="col ps-0">
                              <hr class="mb-0 navbar-vertical-divider" />
                           </div>
                        </div> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/survey/surveyInvestigationList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">설문 조사</span>
                           </div>
                        </a> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/survey/surveyList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">설문지</span>
                           </div>
                        </a> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/survey/surveyQuestionList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">설문 문항</span>
                           </div>
                        </a> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/survey/surveyArticleList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">설문 항목</span>
                           </div>
                        </a> 
                     </li>
                  </c:if>
                     <li class="nav-item">
                        <!-- label-->
                        <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                           <div class="col-auto navbar-vertical-label" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:14px;">설문조사 응답</div>
                           <div class="col ps-0">
                              <hr class="mb-0 navbar-vertical-divider" />
                           </div>
                        </div> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/survey/surveyProgressList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">진행중인 설문</span>
                           </div>
                        </a> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/survey/surveyDeadlineList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">마감된 설문</span>
                           </div>
                        </a> 
                     </li>
                  </ul>
                
                <!-- 회의실 예약 --> 
               <a class="nav-link dropdown-indicator"
                  href="#resource" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="resource">
                     <div class="d-flex align-items-center" style=" margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;">
                           <span class="fas fa-chalkboard-teacher"></span>
                        </span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">회의실 예약</span>
                     </div>
               </a>
                  <ul class="nav collapse" id="resource">
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath}/groupware/resource/resourceList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">회의실 예약</span>
                           </div>
                        </a> 
                     </li>
                  </ul>                
                
                <!-- 메신저 --> 
               <a class="nav-link dropdown-indicator"
                  href="#messenger" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="messenger">
                     <div class="d-flex align-items-center" style=" margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;">
                           <span class="far fa-comment"></span>
                        </span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">메신저</span>
                     </div>
               </a>
                  <ul class="nav collapse" id="messenger">
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/chat/chatHome.do">
<!--                         <a id="testA" class="nav-link" href="#"> -->
                        <script>
                           $("#testA").on("click",function(){
                              
                              alert("gd");
                              
                           })
                        </script>
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">메신저</span>
                           </div>
                        </a> 
                     </li>
                  </ul>                
                                
                <!-- 자료실 --> 
               <a class="nav-link dropdown-indicator"
                  href="#archive" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="archive">
                     <div class="d-flex align-items-center" style=" margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;">
                           <span class="fas fa-cloud-download-alt"></span>
                        </span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">자료실</span>
                     </div>
               </a>
                  <ul class="nav collapse" id="archive">
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath }/groupware/archive/personal.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">개인 자료실</span>
                           </div>
                        </a> 
                     </li>
                  </ul>                
                
                <!-- 게시판 --> 
               <a class="nav-link dropdown-indicator"
                  href="#board" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="board">
                     <div class="d-flex align-items-center" style=" margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;">
                           <span class="fas fa-book-open"></span>
                        </span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">게시판</span>
                     </div>
               </a>
                  <ul class="nav collapse" id="board">
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath}/groupware/board/noticeList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">공지사항</span>
                           </div>
                        </a> 
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath}/groupware/board/communicationList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">커뮤니티</span>
                           </div>
                        </a> 
                     </li>
                  </ul>   
                  
               <!-- 문서 관리--> 
               <a class="nav-link dropdown-indicator"
                  href="#docmanage" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="docmanage">
                     <div class="d-flex align-items-center" style=" margin-bottom:3%;">
                        <span class="nav-link-icon" style="font-size:18px; width:15%;">
                           <span class="far fa-list-alt"></span>
                        </span>
                        <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:18px;">매뉴얼/규정 조회</span>
                     </div>
               </a>
                  <ul class="nav collapse" id="docmanage">
                     <li class="nav-item">
                        <a class="nav-link" href="${cPath}/groupware/menual/menualList.do">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1" style="font-family: 'IBM Plex Sans KR', sans-serif;">매뉴얼/규정 조회</span>
                           </div>
                        </a> 
                     </li>
                  </ul>   

      </div>
   </div>
</nav>