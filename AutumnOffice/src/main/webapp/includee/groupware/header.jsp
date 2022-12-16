<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
	@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
	td{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-size: 15px;
	}
	th{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-size: 15px;
	}
	h3{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	h4{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight: bold;
	}
	h5{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight: bold;
	}
	a{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-size: 15px;
		font-weight: bold;
	}
	span{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-size: 15px;
	}
	button{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-size: 15px;
	}
	.btn{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight: bold;
	}
</style>
 

<!-- 시큐리티 설정 -->
<security:authorize access="isAuthenticated()">
			<security:authentication property="principal" var="principal"/>
</security:authorize>

<nav class="navbar navbar-light navbar-glass navbar-top navbar-expand" style="z-index:1018;">
	<button
		class="btn navbar-toggler-humburger-icon navbar-toggler me-1 me-sm-3"
		type="button" data-bs-toggle="collapse"
		data-bs-target="#navbarVerticalCollapse"
		aria-controls="navbarVerticalCollapse" aria-expanded="false"
		aria-label="Toggle Navigation">
		<span class="navbar-toggle-icon"><span class="toggle-line"></span></span>
	</button>
	<a class="navbar-brand me-1 me-sm-3" href="${pageContext.request.contextPath }/groupware/index.do">
		<div class="d-flex align-items-center">
			<img class="me-2" style="text-align: center"
				src="${cPath }/groupware/main/groupwareCompanyImageView.do"
				 onerror="this.src='${cPath}/resources/web/assets/img/Autumn_Office_logo.png'"
				alt="" width="40" /><span style="font-family: 'IBM Plex Sans KR', sans-serif;text-transform: uppercase;color: #232E3C;" >${principal.realUser.comCnm}</span>
		</div>
	</a>
	<ul class="navbar-nav align-items-center d-none d-lg-block">
		<li class="nav-item">
			<div class="search-box" data-list='{"valueNames":["title"]}'>
				<form class="position-relative" data-bs-toggle="search"
					data-bs-display="static">
					<!-- 					<input class="form-control search-input fuzzy-search" type="search" -->
					<!-- 						placeholder="Search..." aria-label="Search" /> <span -->
					<!-- 						class="fas fa-search search-box-icon"></span> -->
				</form>
				<div
					class="btn-close-falcon-container position-absolute end-0 top-50 translate-middle shadow-none"
					data-bs-dismiss="search">
					<button class="btn btn-link btn-close-falcon p-0"
						aria-label="Close"></button>
				</div>
				<div
					class="dropdown-menu border font-base start-0 mt-2 py-0 overflow-hidden w-100">
					<div class="scrollbar list py-3" style="max-height: 24rem;">
						<h6
							class="dropdown-header fw-medium text-uppercase px-card fs--2 pt-0 pb-2">Recently
							Browsed</h6>
						<a class="dropdown-item fs--1 px-card py-1 hover-primary"
							href="app/events/event-detail.html">
							<div class="d-flex align-items-center">
								<span class="fas fa-circle me-2 text-300 fs--2"></span>

								<div class="fw-normal title">
									Pages <span class="fas fa-chevron-right mx-1 text-500 fs--2"
										data-fa-transform="shrink-2"></span> Events
								</div>
							</div>
						</a> <a class="dropdown-item fs--1 px-card py-1 hover-primary"
							href="app/e-commerce/customers.html">
							<div class="d-flex align-items-center">
								<span class="fas fa-circle me-2 text-300 fs--2"></span>

								<div class="fw-normal title">
									E-commerce <span
										class="fas fa-chevron-right mx-1 text-500 fs--2"
										data-fa-transform="shrink-2"></span> Customers
								</div>
							</div>
						</a>

						<hr class="text-200 dark__text-900" />
						<h6
							class="dropdown-header fw-medium text-uppercase px-card fs--2 pt-0 pb-2">Suggested
							Filter</h6>
						<a class="dropdown-item px-card py-1 fs-0"
							href="app/e-commerce/customers.html">
							<div class="d-flex align-items-center">
								<span
									class="badge fw-medium text-decoration-none me-2 badge-soft-warning">customers:</span>
								<div class="flex-1 fs--1 title">All customers list</div>
							</div>
						</a> <a class="dropdown-item px-card py-1 fs-0"
							href="app/events/event-detail.html">
							<div class="d-flex align-items-center">
								<span
									class="badge fw-medium text-decoration-none me-2 badge-soft-success">events:</span>
								<div class="flex-1 fs--1 title">Latest events in current
									month</div>
							</div>
						</a> <a class="dropdown-item px-card py-1 fs-0"
							href="app/e-commerce/product/product-grid.html">
							<div class="d-flex align-items-center">
								<span
									class="badge fw-medium text-decoration-none me-2 badge-soft-info">products:</span>
								<div class="flex-1 fs--1 title">Most popular products</div>
							</div>
						</a>

						<hr class="text-200 dark__text-900" />
						<h6
							class="dropdown-header fw-medium text-uppercase px-card fs--2 pt-0 pb-2">Files</h6>
						<a class="dropdown-item px-card py-2" href="#!">
							<div class="d-flex align-items-center">
								<div class="file-thumbnail me-2">
									<img class="border h-100 w-100 fit-cover rounded-3"
										src="${pageContext.request.contextPath }/resources/groupware/assets/img/products/3-thumb.png"
										alt="" />
								</div>
								<div class="flex-1">
									<h6 class="mb-0 title">iPhone</h6>
									<p class="fs--2 mb-0 d-flex">
										<span class="fw-semi-bold">Antony</span><span
											class="fw-medium text-600 ms-2">27 Sep at 10:30 AM</span>
									</p>
								</div>
							</div>
						</a> <a class="dropdown-item px-card py-2" href="#!">
							<div class="d-flex align-items-center">
								<div class="file-thumbnail me-2">
									<img class="img-fluid"
										src="${pageContext.request.contextPath }/resources/groupware/assets/img/icons/zip.png"
										alt="" />
								</div>
								<div class="flex-1">
									<h6 class="mb-0 title">Falcon v1.8.2</h6>
									<p class="fs--2 mb-0 d-flex">
										<span class="fw-semi-bold">John</span><span
											class="fw-medium text-600 ms-2">30 Sep at 12:30 PM</span>
									</p>
								</div>
							</div>
						</a>

						<hr class="text-200 dark__text-900" />
						<h6
							class="dropdown-header fw-medium text-uppercase px-card fs--2 pt-0 pb-2">Members</h6>
						<a class="dropdown-item px-card py-2"
							href="pages/user/profile.html">
							<div class="d-flex align-items-center">
								<div class="avatar avatar-l status-online me-2">
									<img class="rounded-circle"
										src="${pageContext.request.contextPath }/resources/groupware/assets/img/team/1.jpg"
										alt="" />

								</div>
								<div class="flex-1">
									<h6 class="mb-0 title">Anna Karinina</h6>
									<p class="fs--2 mb-0 d-flex">Technext Limited</p>
								</div>
							</div>
						</a> <a class="dropdown-item px-card py-2"
							href="pages/user/profile.html">
							<div class="d-flex align-items-center">
								<div class="avatar avatar-l me-2">
									<img class="rounded-circle"
										src="${pageContext.request.contextPath }/resources/groupware/assets/img/team/2.jpg"
										alt="" />

								</div>
								<div class="flex-1">
									<h6 class="mb-0 title">Antony Hopkins</h6>
									<p class="fs--2 mb-0 d-flex">Brain Trust</p>
								</div>
							</div>
						</a> <a class="dropdown-item px-card py-2"
							href="pages/user/profile.html">
							<div class="d-flex align-items-center">
								<div class="avatar avatar-l me-2">
									<img class="rounded-circle"
										src="${pageContext.request.contextPath }/resources/groupware/assets/img/team/3.jpg"
										alt="" />

								</div>
								<div class="flex-1">
									<h6 class="mb-0 title">Emma Watson</h6>
									<p class="fs--2 mb-0 d-flex">Google</p>
								</div>
							</div>
						</a>

					</div>
					<div class="text-center mt-n3">
						<p class="fallback fw-bold fs-1 d-none">No Result Found.</p>
					</div>
				</div>
			</div>
		</li>
	</ul>
	<ul
		class="navbar-nav navbar-nav-icons ms-auto flex-row align-items-center">
		<li class="nav-item">
			<div class="theme-control-toggle fa-icon-wait px-2">
				<input class="form-check-input ms-0 theme-control-toggle-input"
					id="themeControlToggle" type="checkbox" data-theme-control="theme"
					value="dark" /> <label
					class="mb-0 theme-control-toggle-label theme-control-toggle-light"
					for="themeControlToggle" data-bs-toggle="tooltip"
					data-bs-placement="left" title="Switch to light theme"><span
					class="fas fa-sun fs-0"></span></label> <label
					class="mb-0 theme-control-toggle-label theme-control-toggle-dark"
					for="themeControlToggle" data-bs-toggle="tooltip"
					data-bs-placement="left" title="Switch to dark theme"><span
					class="fas fa-moon fs-0"></span></label>
			</div>
		</li>
<!-- 	===============================================알림================================   -->
<!-- 	===============================================알림================================   -->
		<li class="nav-item dropdown">
		<a class="nav-link notification-indicator-warning px-0 fa-icon-wait"
			id="navbarDropdownNotification" role="button"
			data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
			data-hide-on-body-scroll="data-hide-on-body-scroll"><span
				class="fas fa-bell" data-fa-transform="shrink-6"
				style="font-size: 33px;"></span><span id="notifyCount" class="notification-indicator-number">0</span></a>
			<div
				class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end dropdown-menu-card dropdown-menu-notification dropdown-caret-bg"
				aria-labelledby="navbarDropdownNotification">
				<div class="card card-notification shadow-none">
					<div class="card-header">
						<div class="row justify-content-between align-items-center">
							<div class="col-auto">
								<h6 class="card-header-title mb-0">알림메세지</h6>
							</div>
							<div class="col-auto ps-0 ps-sm-3">
								<a class="card-link fw-normal" href="#" onclick="fn_nofityAllRead();">모두 읽음</a>
								
							</div>
						</div>
					</div>
					<div class="scrollbar-overlay" style="max-height: 19rem">
						<div class="list-group list-group-flush fw-normal fs--1" id="notifyBody">
							
								<!--알림메세지 동적 생성 -->
							
						</div>
					</div>
					<div class="card-footer text-center border-top">
						<a class="card-link d-block" href="#" onclick="fn_notifyAllDelete();">전체 삭제</a>
					</div>
				</div>
			</div>
			</li>
<!-- 			==============================================알림 끝 ============================================= -->
		<li class="nav-item dropdown"><a class="nav-link pe-0 ps-2"
			id="navbarDropdownUser" role="button" data-bs-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false">
				<div class="avatar avatar-xl">
					<img class="rounded-circle"
						src="${cPath}/groupware/main/groupwareMainProfileInfo.do" onerror="this.src='${cPath}/resources/groupware/assets/img/profile_user_example.png'" />

				</div>
		</a>
			<div
				class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end py-0"
				aria-labelledby="navbarDropdownUser">
				<div class="bg-white dark__bg-1000 rounded-2 py-2">
					<h6 class="dropdown-header fw-bold text-warning">
						<span class="fas fa-crown me-1"></span>&nbsp;<span id="myInfoDropDown"></span>
					</h6>
					<div class="dropdown-divider"></div>
					<select id="condition" class="form-select form-select-sm"
						style="margin-left: 5%; margin-right: 5%; width: 90%">
						<option value="1">업무중</option>
						<option value="2">자리비움</option>
					</select>
					<div class="dropdown-divider"></div>
					<button class="dropdown-item" type="button" data-bs-toggle="modal"
						data-bs-target="#profile-img">프로필사진 변경</button>
					<a class="dropdown-item"
						href="${cPath }/groupware/profile/passwordUpdate.do">비밀번호 변경</a> <a
						class="dropdown-item"
						href="${cPath }/groupware/profile/loginHistoryList.do">로그인 내역
						확인</a>

					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#" onclick="fn_logout();">Logout</a>
					<form:form id="logoutForm"
						action="${cPath}/groupware/login/logout.do"
						method="post">
					</form:form>
				</div>
			</div></li>
		
	</ul>
</nav>
<script>
let connect = "OK";

fn_notifyYnData();

let notiUrl = "${cPath }/nt/pushMsg"
	let notiSock = new SockJS(notiUrl);
	
	notiSock.onopen=function(event){
		console.log("알림연결수립=============");		
		console.log(event); //발생한 이벤트의 레퍼런스		
	}
	
	notiSock.onclose=function(event){ 
		console.log("=============알림연결종료");		
		console.log(event); 		
	}
	notiSock.onmessage=function(event){ 
		fn_notifyYnData();
		console.log("메시지 수신"+event.data);
		//넘어온 데이터 언먀살링하기
		let newNoti = JSON.parse(event.data);
		let empId = newNoti.empId; //수신자
		let sendempId = newNoti.sendempId; //발신자
		let notName = newNoti.notName; //발신자이름
		let notCon = newNoti.notCon;
		let notUrl = "${cPath}"+newNoti.notUrl;
		let notiMsg="";
		notiMsg = "<a href="+notUrl+">"+empId+"님! "+notName+"님이 "+notCon+"</a>";
		if(newNoti.notType==0){
			  if(connect=="OK"){
				  init2(event);		
			  }else{
				  init(event);
				  fn_roomList();
			  }
		}
		$.notify({
			// optionss
			title: "새글 알림"
			,message:notiMsg
		},{
			// settings
			type: "info"
		   ,placement:{
			   from:"top"
			  ,align:"center"
		   }
		});
	}
	
	
//알림 전체삭제
function fn_notifyAllDelete(){
	$.ajax({
		url : "${cPath}/commons/notify/notifyAllDelete.do",
		method : "post",
		dataType : "json",
		success : function(res) {
	     if(res=='OK'){
	    	 fn_notifyYnData();
	    	 fn_notifyList();
	     }else if(res="FAIL"){
	    	 alert("삭제할 메세지가 없습니다!")
	     }
		},
		error : function(xhr) {
			console.log(xhr.status);
		}
	});
}
//알림 하나 삭제
$(document).on('click','#deleteNotify',function(event){
	event.stopPropagation(); //부모이벤트 막아줌
	
	
	let notNo = $(this).data("value");
	
	$.ajax({
		url : "${cPath}/commons/notify/notifyDelete.do",
		method : "post",
 		data : {notNo : notNo},
		dataType : "json",
		success : function(res) {
	     if(res=='OK'){
	    	 fn_notifyYnData();
	    	 fn_notifyList();
	     }else if(res="FAIL"){
	    	 alert("삭제할 메세지가 없습니다!")
	     }
		},
		error : function(xhr) {
			console.log(xhr.status);
		}
	});
	return false;
});

//알림yn데이터
function fn_notifyYnData(){
$.ajax({
		
		url : "${cPath}/commons/notify/notifyList.do",
		method : "get",
		dataType : "json",
		success : function(res) {
			let notifyList = res;
			let notifyYnCount = 0;
			
			$.each(notifyList, function(index,notify){
				if (notify.notYn == '0'){
					notifyYnCount = notifyYnCount+1;
				}
			});
			
			$("#notifyCount").text(notifyYnCount);
			if(notifyYnCount==0){
				$("#notifyCount").text("");
				$("#navbarDropdownNotification").removeClass("notification-indicator");
			}else{
				$("#navbarDropdownNotification").addClass("notification-indicator");
			}
		
		},
		error : function(xhr) {
			console.log(xhr.status);
		}
	});
}

//알림목록 리스트 
function fn_notifyList(){
	$.ajax({
		
		url : "${cPath}/commons/notify/notifyList.do",
		method : "get",
		dataType : "json",
		success : function(res) {
			let notifyList = res;
			let texts =[];
			let text = "";
			
			$.each(notifyList, function(index,notify){
				let notUrl = "${cPath}" + notify.notUrl;
				text +=		"<div class='list-group-item hover-actions-trigger hover-shadow'>";
				
				if (notify.notYn == '0'){
					text +=	"<a class='notification notification-flush notification-unread' data-url="+notUrl+" href='#!'>";
				}else{
					text += "<a class='border-bottom-0 notification notification-flush' data-url="+notUrl+" href='#!'>";
				}		
			
				text +=			`<div class="notification-avatar">
									<div class="avatar avatar-2xl me-3">`;
				text += 		 "<img class='rounded-circle' src='${cPath}/groupware/chat/chatProfileInfo.do?empId="+notify.sendempId+"' onerror=\"this.src='${cPath}/resources/groupware/assets/img/profile_user_example.png'\">";
				text +=				`</div>
								</div>`;
								
				text +=				`<div class="notification-body" >
									<p class="mb-1">`;
				text +=						"<strong>"+notify.notName+"</strong>님이 "+ notify.notCon;
				text +=				`</p>
										<span class="notification-time"><span class="me-2" role="img" aria-label="Emoji">`
				text +=		"💬</span>"+notify.notCrd.substr(0,notify.notCrd.length-2)+"</span></div>";
				text += `<div class="btn-group btn-group-ss z-index-2 hover-actions end-0 me-4" style="width: 1.5rem;">`;
				text +=     "<button id='deleteNotify' data-value='"+notify.notNo+"' class='btn btn-light hover-bg-50' type='button' data-bs-toggle='tooltip' data-bs-placement='top' title='Delete'><span class='far fa-trash-alt fs-1'></span></button></div></a></div>";
			});
			texts.push(text);
			$("#notifyBody").empty();
			$("#notifyBody").append(texts);
		},
		error : function(xhr) {
			console.log(xhr.status);
		}
	});
}

//알림 모두읽음
function fn_nofityAllRead(){
	$.ajax({
		url : "${cPath}/commons/notify/notifyAllRead.do",
		method : "get",
		dataType : "json",
		success : function(res) {
			if(res=='OK'){
				fn_notifyList()
			}else{
				alert("실패");
			}
			fn_notifyYnData();
		},
		error : function(xhr) {
			console.log(xhr.status);
		}
	});
}


//알림아이콘 클릭<
$("#navbarDropdownNotification").on('click',function(){
	
	fn_notifyList();
	
});

//알림 1개 읽음표시
$(document).on('click','.notification-flush',function(){
	let notNo = $(this).find("#deleteNotify").data("value");
	let notUrl = $(this).data("url");
	$.ajax({
		url : "${cPath}/commons/notify/notifyRead.do",
		method : "post",
		data : {"notNo" : notNo},
		dataType : "json",
		success : function(res) {
			if(res=="OK"){
				//url이동
				location.href=notUrl;
			}else{
				alert("로그인부터 하세요!");
			}
		},
		error : function(xhr) {
			console.log(xhr.status);
		}
	});
	
});

//로그아웃전에 상태 바꿔주는 로직
function fn_logout(){
	$.ajaxSetup({
	    beforeSend: function(xhr, settings) {
	        if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
	            xhr.setRequestHeader(header, token);
	        }
	    }
	});
	$.ajax({
		url : "${cPath}/groupware/profile/logout.do",
		method : "post",
		data : {empId : "${principal.realUser.empId}"},
		dataType : "json",
		success : function(res) {
			if(res=="OK"){
			$("#logoutForm").submit();
			}else{
				alert("로그인부터 하세요!")
			}
		},
		error : function(xhr) {
			console.log(xhr.status);
		}
	});
}
//사원 상태 업무중과 자리비움 변경로직
$("#condition").on('change',function(){
	let empSta = $(this).val();
	
	$.ajax({
		url : "${cPath}/groupware/profile/condition.do",
		method : "post",
		data : {"empSta" : empSta},
		dataType : "json",
		success : function(res) {
			if(res=="OK"){
			toastr.info("변경이 완료되었습니다!")
			}else{
				toastr.info("변경 실패! 다시 시도해주세요.")
			}
			
			$.ajax({
				url : "${cPath}/groupware/main/groupwareMainMyInfo.do",
				dataType : "JSON",
				success : function(employeeVO) {
					if(employeeVO.empSta == 1){
						myInfo.empty();
						myInfo.html("<span><span class='fas fa-sun'></span> "+employeeVO.empNm+"&nbsp;"+employeeVO.jobNm+"님</span><span>오늘도 좋은 하루 되세요!</span><hr><span class='badge badge-soft-secondary'>"+employeeVO.depNm+"</span><hr><span style='font-weight:bold;font-size:20px' ><span class='fas fa-smile' style='color:#48D1CC	'></span> 현재 업무중입니다.</span>");
					}else{ // 자리비움일때
						myInfo.empty();
						myInfo.html("<span><span class='fas fa-sun'></span> "+employeeVO.empNm+"&nbsp;"+employeeVO.jobNm+"님</span><span>오늘도 좋은 하루 되세요!</span><hr><span class='badge badge-soft-secondary'>"+employeeVO.depNm+"</span><hr><span style='font-weight:bold;font-size:20px'><span class='fas fa-chair' style='color:coral'></span> 자리비움 중입니다.</span>");
					}
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			})
		},
		error : function(xhr) {
			console.log(xhr.status);
		}
	});
	
});

//==================================================
// 프로필 관리에서 본인 정보 띄우기
//==================================================
let myInfoDropDown = $("#myInfoDropDown");

$.ajax({
	url : "${cPath}/groupware/main/groupwareMainMyInfo.do",
	dataType : "JSON",
	success : function(employeeVO) {
		myInfoDropDown.html(employeeVO.empNm+" "+employeeVO.jobNm);
	},
	error : function(errorResp) {
		console.log(errorResp.status);
	}
})


</script>

<!-- -------------- -->
<!-- 프로필사진 변경 모달 -->
<!-- -------------- -->
<div class="modal fade" id="profile-img" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document"
		style="max-width: 500px">
		<div class="modal-content position-relative">
			<form action="${cPath}/groupware/profile/profileUpdate.do" method="post" enctype="multipart/form-data">
			<div class="modal-body p-0">
				<div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
					<h4 class="mb-1" id="profile-img-label"><span class="fas fa-caret-right"></span> 프로필사진 변경</h4>
				</div>
				<div class="p-4 pb-0">
						<div class="mb-3" style="vertical-align: middle;">
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
								<table>
									<tr>
										<th style="width:30%">현재 프로필</th>
										<td>
											<div class="avatar avatar-5xl" id="profileInfoModal" >
												<img class="rounded-soft" id="previewImg" src="${cPath}/groupware/main/groupwareMainProfileInfo.do" 
												onerror="this.src='${cPath}/resources/groupware/assets/img/profile_user_example.png'"
												    />
											</div>
										</td>
									</tr>
									<tr>
										<th>프로필 사진 첨부</th>
										<td>
											<input class="form-control form-control-sm" id="customFile" type="file" name="empFiles" style="width:80%"
											 onchange="PreviewImage();" />
										</td>
									</tr>
								</table>
						</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-outline-primary me-1 mb-1" type="submit">변경</button>
				<button class="btn btn-outline-secondary me-1 mb-1" type="button" data-bs-dismiss="modal">닫기</button>
			</div>
			</form>
		</div>
	</div>
</div>

<script>
// ==================================================
// input type File에서 파일을 선택했을 때 미리보기 형식으로 띄우기
// ==================================================
function PreviewImage() {
    // 파일리더 생성 
    var preview = new FileReader();
    preview.onload = function (e) {
    // img id 값 
    document.getElementById("previewImg").src = e.target.result;
};
// input id 값 
preview.readAsDataURL(document.getElementById("customFile").files[0]);
};
</script>