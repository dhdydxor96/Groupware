<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
.profile {
	text-align: center;
	padding-top: 12%;
	padding-bottom:5%;
	padding-left:5%;
	padding-right:5%;
}

.time_btn {
	width: 120px;
}

#time_span {
	margin-top: 15px;
	margin-bottom: 30px;
	margin-left: 65px;
}

.card {
}
.profileImageMain{
	border : 1px solid #9DA9BB;
}
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
	color: #748194;
}
span{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
button{
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-size: 15px;
}
p{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
.groupware-main-left{
	width: 29%; 
	float: left;
}
#profileInfo{
	margin-left:38%;
}
#workTimeView{
	text-align: center;
	margin-top: 20px;
}
#time_span{
	padding-right:2%;
}
.btn{
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-weight: bold;
}
#mailBtn{
	text-align: center;
 	padding-top: 5%; 
 	padding-bottom: 5%; 
 	font-family: 'IBM Plex Sans KR', sans-serif;
}
#msgBtn{
	text-align: center; 
 	padding-top: 5%; 
 	padding-bottom: 5%; 
}
#weatherView{
	text-align: center; 
	padding: 5% 10%;
	background-color: #2C7BE5;
	color: white;
}
.groupware-main-right{
	width: 69%;
	float: right;
	color:#5E6E82;
}
</style>
<!-- popup -->
<c:if test="${popup.popupSta eq 1}">
	<jsp:include page="../management/base/popup.jsp"/>
</c:if>
<!-- ========================== -->
<!--     그룹웨어 메인 - 왼쪽 스크린      -->
<!-- ========================== -->
<div class="groupware-main-left">
	<!-- -------------------------- -->
	<!--  그룹웨어 메인 - 프로필/개인정보      -->
	<!-- -------------------------- -->
	<div class="card md-3 profile" >
		<div class="avatar avatar-4xl" id="profileInfo">
			<img class="rounded-soft profileImageMain" 
				src="${cPath}/groupware/main/groupwareMainProfileInfo.do" 
				onerror="this.src='${cPath}/resources/groupware/assets/img/profile_user_example.png'"   />
		</div>
		<div class="card-body d-flex flex-column justify-content-between" id="myInfo"></div>
	</div>
	<!-- -------------------------- -->
	<!-- 그룹웨어 메인 - 업무시간/출퇴근버튼    -->
	<!-- -------------------------- -->
	<br />
	<div class="card md-3">
		<span id="workTimeView">
			<h4><span class="fas fa-stopwatch"></span>&nbsp;업무시간 : 00h 00m</h4>
		</span> 
		<span id="time_span">
			<button style="width:40%"
				class="btn btn-outline-primary rounded-pill me-1 mb-1 time_btn" 
				type="button" id="goTo">출근</button>
			<button style="width:40%"
				class="btn btn-outline-primary rounded-pill me-1 mb-1 time_btn"
				type="button" id="endWork">퇴근</button>
		</span>
	</div>
	<br />
	<!-- -------------------------- -->
	<!--     그룹웨어 메인 - 메일쓰기          -->
	<!-- -------------------------- -->
	<div  class="card md-3" id="mailBtn"
			onclick="location.href='${cPath}/groupware/mail/mailInsert.do'">
			<h4>
				<span class="far fa-envelope"></span> 메일 
			</h4>
	</div>
	<br>
	<!-- -------------------------- -->
	<!--     그룹웨어 메인 - 메신저           -->
	<!-- -------------------------- -->
	<div class="card md-3" id="msgBtn"
		onclick="location.href='${cPath}/groupware/chat/chatHome.do'">
		<h4>
			<span class="far fa-comment"></span>&nbsp;메신저&nbsp;
		</h4>
	</div>
	<br />
	<!-- -------------------------- -->
	<!--     그룹웨어 메인 - 날씨             -->
	<!-- -------------------------- -->
	<div class="card md-3" id="weatherView">
		<div class="weather">
			<img class='CurrIcon'><span class='City'></span>
		</div>
	</div>
</div>

<!-- ========================== -->
<!--    그룹웨어 메인 - 오른쪽 스크린      -->
<!-- ========================== -->
<div class="groupware-main-right">
	<!-- -------------------------- -->
	<!--    그룹웨어 메인 - 오늘일정            -->
	<!-- -------------------------- -->
	<div class="card md-3">
		<div class="card-header d-flex flex-between-center py-2 border-bottom">
			<h5><span class="fas fa-caret-right"></span>&nbsp;오늘 일정</h5>
			<a href="${cPath}/groupware/calendar/empCalendarList.do"><span class="fas fa-plus"></span></a>
		</div>
		<div class="card-body d-flex flex-column justify-content-between calendarView" style="padding: 2%">
		</div>
	</div>
	<br />
	<br />
	<!-- -------------------------- -->
	<!--     그룹웨어 메인 - 결재함            -->
	<!-- -------------------------- -->
	<div class="card md-3" style="margin-top: -3%;">
		<div class="card-header d-flex flex-between-center py-2 border-bottom">
			<h5><span class="fas fa-caret-right"></span>&nbsp;결재함</h5>
			<a href="${cPath}/groupware/approval/doc/waitAppDocList.do"><span class="fas fa-plus"></span></a>
		</div>
		<div class="card-body d-flex flex-column justify-content-between" style="padding: 1%">
			<div class="table-responsive scrollbar">
				<table class="table table-hover" >
					<tbody id="approvalView">
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<br />
	<!-- -------------------------- -->
	<!--     그룹웨어 메인 - 공지사항          -->
	<!-- -------------------------- -->
	<div class="card md-3">
		<div class="card-header d-flex flex-between-center py-2 border-bottom">
			<h5><span class="fas fa-caret-right"></span>&nbsp;공지사항</h5>
			<a href="${cPath}/groupware/board/noticeList.do"><span class='fas fa-plus'></span></a>
		</div>
		<div class="card-body d-flex flex-column justify-content-between"  style="padding: 1%" >
				<table class="table table-hover" >
					<tbody id="noticeView">
					</tbody>
				</table>
		</div>
	</div>
</div>


<script>
	//========================================================
	// 날씨 API
	//========================================================
	var apiURI = "https://api.openweathermap.org/data/2.5/weather?q=seongnam&appid=f4b1c6882c589c4f858bc7e7c459df9c";
	
	$(function() {
		$.ajax({
			url : apiURI,
			dataType : "json",
			type : "GET",
			async : "false",
			success : function(resp) {
				console.log(resp);
				console.log("현재온도 : " + (resp.main.temp - 273.15));
				console.log("현재습도 : " + resp.main.humidity);
				console.log("날씨 : " + resp.weather[0].main);
				console.log("상세날씨설명 : " + resp.weather[0].description);
				console.log("날씨 이미지 : " + resp.weather[0].icon);
				console.log("바람   : " + resp.wind.speed);
				console.log("나라   : " + resp.sys.country);
				console.log("도시이름  : " + resp.name);
				console.log("구름  : " + (resp.clouds.all) + "%");

				imgURL = "http://openweathermap.org/img/wn/"
						+ resp.weather[0].icon + ".png";
				$(".CurrIcon").attr("src", imgURL);
				$(".City").html(
						"성남  현재온도 : "
								+ parseInt(resp.main.temp - 273.15)
								+ "℃");
			}
		})
	
	})
	//========================================================
	// 출근하기 버튼 클릭 후 Disabled 설정
	//========================================================
	let goTo = $("#goTo");

	$(document).ready(function(){
		
		$.ajax({
			url : "${cPath}/groupware/attendance/my/status/goToWorkList.do",
			dataType : "JSON",
			success : function(resp) {
				
				if(resp == 0){
					goTo.prop("disabled", false);
				}else{
					goTo.prop("disabled", true);
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
		
	})

	//========================================================
	// 공지사항
	//========================================================
	let noticeView = $("#noticeView");
		
	$.ajax({
		url : "${cPath}/groupware/main/groupwareMainNoticeList.do",
		dataType : "JSON",
		success : function(noticeList) {
			noticeView.empty();
			let makeTrTags = [];
			let noticeTable;
			console.log("공지사항 list 길이"+noticeList.length);
			if(noticeList.length > 0){
				$.each(noticeList, function(index, noticeVO){ 
					noticeTable = "<tr class='cTr' id="+noticeVO.nocNo+"><td>"+(index+1)+"</td><td>"+noticeVO.nocTit+"</td><td>관리자</td><td>"+noticeVO.nocDate+"</td></td>";
					makeTrTags.push(noticeTable);
				});
			}else{
				noticeTable = "<tr><td><span class='far fa-times-circle' /> 등록된 공지사항이 없습니다.</td></tr>";
				makeTrTags.push(noticeTable);
			}
			noticeView.append(makeTrTags);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	})
	$(document).on('click','#noticeView > .cTr', function(event){
			let noticeId = $(this).attr('id');
			location.href="${cPath}/groupware/board/noticeView.do?what="+noticeId;
	})
	
	
	//========================================================
	// 오늘 일정
	//========================================================
	let calendarView = $(".calendarView");
		
	$.ajax({
		url : "${cPath}/groupware/main/groupwareMainCalendarList.do",
		dataType : "JSON",
		success : function(calendarList) {
			calendarView.empty();
			let makeTrTags = [];
			let calendarTable;
			console.log("캘린더 list 길이"+calendarList.length);
			if(calendarList.length > 0){
				$.each(calendarList, function(index, calendarVO){
					if(calendarVO.calSta == 0){
						
						calendarTable = "<div class='row g-3 timeline timeline-primary timeline-past pb-card' style='margin-bottom: 1%'>";
						calendarTable += 	"<br><div class='col-auto ps-4 ms-2'>";
						calendarTable += 		"<div class='ps-2'>";
						calendarTable += 			"<div class='icon-item icon-item-sm rounded-circle bg-200 shadow-none'>";
						calendarTable += 				"<span style='color:#2C7BE5' class='fas fa-calendar-check'></span>";
						calendarTable += 			"</div>";
						calendarTable += 		"</div>";
						calendarTable += 	"</div>";
						calendarTable += 	"<div class='col'>";
						calendarTable += 		"<div class='row gx-0 border-bottom pb-card' style='text-align: left'>";
						calendarTable += 			"<div class='col'>";
						calendarTable += 				"<h6 class='text-800 mb-1'><span class='badge badge-soft-warning'>부서 일정</span></h6>";
						calendarTable += 				"<p class='fs--1 text-600 mb-0' style='font-family: 'IBM Plex Sans KR', sans-serif;'>"+calendarVO.calTit+"</p>";
						calendarTable += 			"</div>";
						calendarTable += 			"<div class='col-auto'>";
						if(calendarVO.calAllday==0){
							calendarTable += 				"<p class='fs--1 text-500 mb-0' style='font-family: 'IBM Plex Sans KR', sans-serif;'>"+calendarVO.calStart+"~"+calendarVO.calEnd+"</p>";
						}else{
							calendarTable += 				"<p class='fs--1 text-500 mb-0' style='font-family: 'IBM Plex Sans KR', sans-serif;'>하루종일</p>";
						}
						calendarTable += 			"</div>";
						calendarTable += 		"</div>";
						calendarTable += 	"</div>";
						calendarTable += "</div>";
						
					}else {
						calendarTable = "<div class='row g-3 timeline timeline-primary timeline-past pb-card' style='margin-bottom: 1%'>";
						calendarTable += 	"<br><div class='col-auto ps-4 ms-2'>";
						calendarTable += 		"<div class='ps-2'>";
						calendarTable += 			"<div class='icon-item icon-item-sm rounded-circle bg-200 shadow-none'>";
						calendarTable += 				"<span style='color:#2C7BE5' class='far fa-calendar-check'></span>";
						calendarTable += 			"</div>";
						calendarTable += 		"</div>";
						calendarTable += 	"</div>";
						calendarTable += 	"<div class='col'>";
						calendarTable += 		"<div class='row gx-0 border-bottom pb-card' style='text-align: left'>";
						calendarTable += 			"<div class='col'>";
						calendarTable += 				"<h6 class='text-800 mb-1'><span class='badge badge-soft-primary'>개인 일정</span></h6>";
						calendarTable += 				"<p class='fs--1 text-600 mb-0' style='font-family: 'IBM Plex Sans KR', sans-serif;'>"+calendarVO.calTit+"</p>";
						calendarTable += 			"</div>";
						calendarTable += 			"<div class='col-auto'>";
						if(calendarVO.calAllday==0){ 
							calendarTable += 				"<p class='fs--1 text-500 mb-0' style='font-family: 'IBM Plex Sans KR', sans-serif;'>"+calendarVO.calStart+"~"+calendarVO.calEnd+"</p>";
						}else{
							calendarTable += 				"<p class='fs--1 text-500 mb-0' style='font-family: 'IBM Plex Sans KR', sans-serif;'>하루종일</p>";
						}
						calendarTable += 			"</div>";
						calendarTable += 		"</div>";
						calendarTable += 	"</div>";
						calendarTable += "</div>";
						
					}
						makeTrTags.push(calendarTable);
				});
			}else{
				calendarTable = "<table><tr class='not-click'><td><span class='far fa-times-circle' /> 등록된 일정이 없습니다.</td></tr></table>";
				makeTrTags.push(calendarTable);
			}
			calendarView.append(makeTrTags);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	})
	
	//========================================================
	// 결재 대기 문서
	//========================================================
	let approvalView = $("#approvalView");
	
	$.ajax({
		url : "${cPath}/groupware/main/groupwareMainApprovalList.do",
		dataType : "JSON",
		success : function(approvalList) {
			approvalView.empty();
			let makeTrTags = [];
			let approvalTable;
			console.log("전자결재 list 길이"+approvalList.length);
			if(approvalList.length > 0){
				$.each(approvalList, function(index, approvalVO){
						approvalTable = "<tr class='cTr' id="+approvalVO.eleNo+"><td>"+(index+1)+"</td><td><span class='badge badge-soft-light'>"+approvalVO.appForm.apfCat+"</span></td><td>"+approvalVO.eleTit+"</td><td>"+approvalVO.eleCrd+"</td></td><td>"+approvalVO.empNm+"</td>";
						makeTrTags.push(approvalTable);
				});
			}else{
				approvalTable = "<tr><td><span class='far fa-times-circle' /> 새로운 결재 대기 문서가 없습니다.</td></tr>";
				makeTrTags.push(approvalTable);
			}
			approvalView.append(makeTrTags);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	})
	$(document).on('click','#approvalView > .cTr', function(event){
			let approvalId = $(this).attr('id');
			location.href="${cPath}/groupware/approval/doc/waitAppDocDetail.do?eleNo="+approvalId;
	})
	
	//========================================================
	// 본인 정보 띄우기
	//========================================================
	let myInfo = $("#myInfo");
	
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
	
	//========================================================
	// 본인 업무시간 띄우기
	//========================================================
	let workTimeView = $("#workTimeView");
	$(function() {
		const timer = function () {
			$.ajax({
				url : "${cPath}/groupware/main/groupwareMainWorkTimeInfo.do",
				dataType : "JSON",
				success : function(status) {
					workTimeView.html("<h4 style='font-weight: bold;'><span class='fas fa-stopwatch'></span>&nbsp;업무시간 : "+status.sumTime+"</h4>");
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			})
		}; 
		
		timer(); // loop 할 함수 실행
		setInterval(timer, 60000);
	});
	
	//========================================================
	// 출근버튼
	//========================================================
	goTo.on('click', function(){
		$.ajax({
			url : "${cPath}/groupware/attendance/my/status/goToWork.do",
			dataType : "JSON",
			success : function(resp) {
				if(resp==1){
					toastr.info("출근체크가 완료되었습니다.<br> 오늘도 힘내세요!");
					
					$.ajax({
						url : "${cPath}/groupware/attendance/my/status/goToWorkList.do",
						dataType : "JSON",
						success : function(resp) {
							
							if(resp == 0){
								goTo.prop("disabled", false);
							}else{
								goTo.prop("disabled", true);
							}
						},
						error : function(errorResp) {
							console.log(errorResp.status);
						}
					})
					
					
				}else{
					toastr.info("출근 체크에 실패하였습니다.<br> 잠시 후 다시 시도해주세요");
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
	})
	
	//========================================================
	// 퇴근버튼
	//========================================================
	let endWork = $("#endWork");
	
	endWork.on('click',function(){
		$.ajax({
			url : "${cPath}/groupware/attendance/my/status/endWork.do",
			dataType : "JSON",
			success : function(resp) {
				if(resp==1){
					toastr.info("퇴근 체크가 완료되었습니다.<br> 오늘도 수고하셨습니다!");
				}else{
					toastr.info("퇴근 체크에 실패하였습니다.<br> 잠시 후 다시 시도해주세요");
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
	})
</script>