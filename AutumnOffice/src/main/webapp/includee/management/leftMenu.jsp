<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

	<!-- 시큐리티 설정 -->
	<security:authorize access="isAuthenticated()">
				<security:authentication property="principal" var="principal"/>
	</security:authorize>
	
	
<%-- 	${principal.realUser.comDiv}  0이면 고객 1이면 운영자 --%>
<div class="sidebar sidebar-style-2">
	<div class="sidebar-background"></div>
	<div class="sidebar-wrapper scrollbar scrollbar-inner">
		<div class="sidebar-content">
			<ul class="nav nav-info">
				<li class="nav-item active">
					<a href="${cPath }/management/index.do">
						<i class="fas fa-home"></i>
						<p>HOME</p>
					</a>
				</li>
				
				<!-- 기본 관리 -->
				<li class="nav-item">
					<a data-toggle="collapse" href="#base">
						<i class="fas fa-layer-group"></i>
							<p>기본관리</p> 
							<span class="caret"></span>
					</a>
					<div class="collapse" id="base">
						<ul class="nav nav-collapse">
							<li>
								<a href="${cPath }/management/base/logoChange.do"> 
									<span class="sub-item">로고변경</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/base/popup.do"> 
									<span class="sub-item">팝업 공지</span>
								</a>
							</li>
						</ul>
					</div>
				</li>
				<!-- 조직 관리 -->
				<li class="nav-item">
					<a data-toggle="collapse" href="#group">
						<i class="fas fa-building"></i>
							<p>조직 관리</p> 
							<span class="caret"></span>
					</a>
					<div class="collapse" id="group">
						<ul class="nav nav-collapse">
							<li>
								<a href="${cPath }/management/group/department/departmentList.do"> 
									<span class="sub-item">부서 관리</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/group/job/jobList.do"> 
									<span class="sub-item">직위 관리</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/group/employee/employeeList.do"> 
									<span class="sub-item">사원 관리</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/group/employee/powerHeadList.do"> 
									<span class="sub-item">부서장 목록</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/group/employee/powerDirectorList.do"> 
									<span class="sub-item">임원 목록</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/group/employee/resignationList.do"> 
									<span class="sub-item">퇴사자 목록</span>
								</a>
							</li>
						</ul>
					</div>
				</li>
				
				<!-- 보안 관리 -->
				<li class="nav-item">
					<a data-toggle="collapse" href="#security">
						<i class="fas fa-lock"></i>
							<p>보안 관리</p> 
							<span class="caret"></span>
					</a>
					<div class="collapse" id="security">
						<ul class="nav nav-collapse">
							<li>
								<a href="${cPath }/management/security/loginTracking.do"> 
									<span class="sub-item">로그인 추적</span>
								</a>
							</li>
						</ul>
					</div>
				</li>
				
				<!-- 메뉴 관리 -->
				<li class="nav-item">
					<a data-toggle="collapse" href="#menu">
						<i class="fas fa-list"></i>
							<p>메뉴 관리</p> 
							<span class="caret"></span>
					</a>
					<div class="collapse" id="menu">
						<ul class="nav nav-collapse">
							<li>
								<a href="${cPath }/management/menu/appFormList.do"> 
									<span class="sub-item">전자결재 문서 관리</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/menu/attendanceManage.do"> 
									<span class="sub-item">근태 관리</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/menu/resourceManage.do"> 
									<span class="sub-item">회의실 관리</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/menu/noticeManage.do"> 
									<span class="sub-item">공지사항 관리</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/menu/communityManage.do"> 
									<span class="sub-item">게시판 관리</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/menu/docManageMenualList.do"> 
									<span class="sub-item">매뉴얼 관리</span>
								</a>
							</li>
						</ul>
					</div>
				</li>				
 				<c:choose>
 					<c:when test="${principal.realUser.comDiv  eq 0}">
				<!-- 서비스 관리 (사용자) -->
				<li class="nav-item">
					<a data-toggle="collapse" href="#service_user">
						<i class="far fa-hdd"></i>
							<p>그룹웨어 서비스</p> 
							<span class="caret"></span>
					</a>
					<div class="collapse" id="service_user">
						<ul class="nav nav-collapse">
							<li>
								<c:url value="/management/wareservice/userInfoView.do" var="viewURL">
									<c:param name="what" value="${principal.realUser.comCode }"/>
								</c:url>
								<a href="${viewURL}"> 
									<span class="sub-item">서비스 정보 확인</span>
								</a>
							</li>
							<li>
								<a href="${cPath }/management/wareservice/userInfoHistoryList.do">
									<span class="sub-item">서비스 이용내역 확인</span>
								</a>
							</li>
<!-- 							<li> -->
<%-- 								<a href="${cPath }/management/wareservice/userExtendService.do">  --%>
<!-- 									<span class="sub-item">서비스 연장 신청</span> -->
<!-- 								</a> -->
<!-- 							</li> -->
						</ul>
					</div>
				</li>
							</c:when>
				<c:otherwise>
				<!-- 서비스 관리 (운영자) -->
				<li class="nav-item">
					<a data-toggle="collapse" href="#service_op" id="test">
						<i class="far fa-hdd"></i>
							<p>그룹웨어 서비스</p> 
							<span class="caret"></span>
					</a>
					<div class="collapse" id="service_op">
						<ul class="nav nav-collapse">
							<li>
								<a href="${cPath }/management/wareservice/serviceHistoryList.do"> 
									<span class="sub-item">서비스 내역</span>
								</a>								  
							</li>
<!-- 							<li> -->
<%-- 								<a href="${cPath }/management/wareservice/serviceHistoryList.do">  --%>
<!-- 									<span class="sub-item">사용자 결제 내역</span> -->
<!-- 								</a>								   -->
<!-- 							</li> -->
<!-- 							<li> -->
<%-- 								<a href="${cPath }/management/wareservice/serviceHistoryList.do">  --%>
<!-- 									<span class="sub-item">사용자 미납 현황</span> -->
<!-- 								</a>								   -->
<!-- 							</li> -->
						</ul>
					</div>
				</li>				
					</c:otherwise>
					</c:choose>
			</ul>
		</div>
	</div>
</div>
