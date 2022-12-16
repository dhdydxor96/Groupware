<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
.card{
	padding : 1%;
}
a{
	color : black;
	text-decoration : none;
}
table {
	margin-left: auto;
	margin-right: auto;
	padding: 15%;
	text-align: center;
}


#period{
	text-align: center;
	font-size: 1.5em;
}
.month{
	color :	#C0C0C0;
}
.col-auto{
	font-weight: bold;
}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
div{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
.btn{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
.fw-medium{
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-weight: bold;
}
.workInfo{
	text-align: right;
	color:#C0C0C0;
	font-size: 14px;
}
h3{
	font-weight: bold;
	font-size: 30px;
}
</style>

<div class="card md-3">
	<!-- -------------------------- -->
	<!--    	 현재 근무상태      	    -->
	<!-- -------------------------- -->
	<div class="workInfo"></div>

	<!-- 메뉴 명 -->
	<h3><span class="fas fa-business-time"></span>&nbsp;내 근태 현황</h3>
	<hr>
	<br> <br>
	
	<!-- -------------------------- -->
	<!--     이번달 날짜 띄우기      	    -->
	<!-- -------------------------- -->
	<div id="period" style="font-weight: bold;">
			&nbsp;&nbsp;&nbsp;
			<c:set var="now" value="<%=new java.util.Date()%>" />
			<fmt:formatDate value="${now}" pattern="yyyy년 MM월" />
			&nbsp;&nbsp;&nbsp;
	</div>
	<br>
	
	<!-- -------------------------- -->
	<!--     이번주/이번달 근태 통계       -->
	<!-- -------------------------- -->
	<div style="text-align: center" class="border p-card rounded">
		<div class="row g-5 justify-content-center">
			<!-- 이번주 내역 -->
			<div  class="col-auto">
				<div>이번주 누적</div>
				<div id="weekSum">00h 00m</div>
			</div>
			<div  class="col-auto">
				<div>이번주 초과</div>
				<div id="weekOver">00h 00m</div>
			</div>
			<div  class="col-auto">
				<div>이번주 잔여</div>
				<div id="weekLeft">00h 00m</div>
			</div>
			<!-- 이번달 내역 -->
			<div  class="col-auto month">
				<div>이번달 누적</div>
				<div id="monSum">00h 00m</div>
			</div>
			<div  class="col-auto month">
				<div>이번달 초과</div>
				<div id="monOver">00h 00m</div>
			</div>
		</div>
	</div>

	<br>
	<br>
	<br>
	
	<!-- -------------------------- -->
	<!--     주차별 근태현황 확인  	    -->
	<!-- -------------------------- -->
	<div>
		<div class="accordion border rounded overflow-hidden"
			id="accordionFaq">
			<div class="shadow-none rounded-bottom-0 border-bottom">
				<div class="accordion-item border-0">
					<div class="card-header p-0" id="faqAccordionHeading1">
						<button
							class="accordion-button btn btn-link text-decoration-none d-block w-100 py-2 px-3 collapsed border-0 text-start rounded-0 shadow-none"
							data-bs-toggle="collapse" data-bs-target="#collapseFaqAccordion1"
							aria-expanded="false" aria-controls="collapseFaqAccordion1">
							<span class="fas fa-caret-right accordion-icon me-3"
								data-fa-transform="shrink-2"></span><span
								class="fw-medium font-sans-serif text-900">1주차</span>
						</button>
					</div>
					<div class="accordion-collapse collapse" id="collapseFaqAccordion1"
						aria-labelledby="faqAccordionHeading1" data-parent="#accordionFaq">
						<div class="accordion-body p-0">
							<div class="card-body pt-2">
								<p class="ps-3 mb-0">
								<table class="table">
									<thead>
										<tr>
											<th scope="col">일자</th>
											<th scope="col">업무시작시간</th>
											<th scope="col">업무종료시간</th>
											<th scope="col">총 근무시간</th>
											<th scope="col">변경 이력</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${statusList }" var="statusVO" begin="0" end="6" step="1">
											<c:if test="${empty statusVO.staOnt}">
												<tr style="background-color: #E6E6FA">
											</c:if>
											<c:if test="${not empty statusVO.staOnt}">
												<tr>
											</c:if>
												<td>${statusVO.dayVal }</td>
												<c:choose>
													<c:when test="${empty statusVO.staOnt}">
														<td>(미등록)</td>
													</c:when>
													<c:otherwise>
														<td>${statusVO.staOnt }</td>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${empty statusVO.staOft}">
														<td>(미등록)</td>
													</c:when>
													<c:otherwise>
														<td>${statusVO.staOft }</td>
													</c:otherwise>
												</c:choose>
												<td>${fn:substring(statusVO.sumSta, 2,statusVO.sumSta.indexOf('.'))  }</td>
												<td>
													<c:if test="${not empty statusVO.staCon }">
														<div style="color:gray;font-size: 0.7em">
															${statusVO.staNm } ${ statusVO.staJob } [ ${statusVO.staCht} ]
														</div>
														<div>
															${statusVO.staCon }
														</div>
													</c:if>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="shadow-none rounded-0 border-bottom">
				<div class="accordion-item border-0">
					<div class="card-header p-0" id="faqAccordionHeading2">
						<button
							class="accordion-button btn btn-link text-decoration-none d-block w-100 py-2 px-3 collapsed border-0 text-start rounded-0 shadow-none"
							data-bs-toggle="collapse" data-bs-target="#collapseFaqAccordion2"
							aria-expanded="false" aria-controls="collapseFaqAccordion2">
							<span class="fas fa-caret-right accordion-icon me-3"
								data-fa-transform="shrink-2"></span><span
								class="fw-medium font-sans-serif text-900">2주차</span>
						</button>
					</div>
					<div class="accordion-collapse collapse" id="collapseFaqAccordion2"
						aria-labelledby="faqAccordionHeading2" data-parent="#accordionFaq">
						<div class="accordion-body p-0">
							<div class="card-body pt-2">
								<p class="ps-3 mb-0">
								<table class="table">
									<thead>
										<tr>
											<th scope="col">일자</th>
											<th scope="col">업무시작시간</th>
											<th scope="col">업무종료시간</th>
											<th scope="col">총 근무시간</th>
											<th scope="col">변경 이력</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${statusList }" var="statusVO" begin="7" end="13" step="1">
											<c:if test="${empty statusVO.staOnt}">
												<tr style="background-color: #E6E6FA">
											</c:if>
											<c:if test="${not empty statusVO.staOnt}">
												<tr>
											</c:if>
												<td>${statusVO.dayVal }</td>
												<c:choose>
													<c:when test="${empty statusVO.staOnt}">
														<td>(미등록)</td>
													</c:when>
													<c:otherwise>
														<td>${statusVO.staOnt }</td>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${empty statusVO.staOft}">
														<td>(미등록)</td>
													</c:when>
													<c:otherwise>
														<td>${statusVO.staOft }</td>
													</c:otherwise>
												</c:choose>
												<td>${fn:substring(statusVO.sumSta, 2,statusVO.sumSta.indexOf('.'))  }</td>
												<td>
													<c:if test="${not empty statusVO.staCon }">
														<div style="color:gray;font-size: 0.7em">
															${statusVO.staNm } ${ statusVO.staJob } [ ${statusVO.staCht} ]
														</div>
														<div>
															${statusVO.staCon }
														</div>
													</c:if>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="shadow-none rounded-0 border-bottom">
				<div class="accordion-item border-0">
					<div class="card-header p-0" id="faqAccordionHeading3">
						<button
							class="accordion-button btn btn-link text-decoration-none d-block w-100 py-2 px-3 collapsed border-0 text-start rounded-0 shadow-none"
							data-bs-toggle="collapse" data-bs-target="#collapseFaqAccordion3"
							aria-expanded="false" aria-controls="collapseFaqAccordion3">
							<span class="fas fa-caret-right accordion-icon me-3"
								data-fa-transform="shrink-2"></span><span
								class="fw-medium font-sans-serif text-900">3주차</span>
						</button>
					</div>
					<div class="accordion-collapse collapse" id="collapseFaqAccordion3"
						aria-labelledby="faqAccordionHeading3" data-parent="#accordionFaq">
						<div class="accordion-body p-0">
							<div class="card-body pt-2">
								<p class="ps-3 mb-0">
									<table class="table">
										<thead>
											<tr>
												<th scope="col">일자</th>
												<th scope="col">업무시작시간</th>
												<th scope="col">업무종료시간</th>
												<th scope="col">총 근무시간</th>
												<th scope="col">변경 이력</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${statusList }" var="statusVO" begin="14" end="20" step="1">
											<c:if test="${empty statusVO.staOnt}">
												<tr style="background-color: #E6E6FA">
											</c:if>
											<c:if test="${not empty statusVO.staOnt}">
												<tr>
											</c:if>
												<td>${statusVO.dayVal }</td>
												<c:choose>
													<c:when test="${empty statusVO.staOnt}">
														<td>(미등록)</td>
													</c:when>
													<c:otherwise>
														<td>${statusVO.staOnt }</td>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${empty statusVO.staOft}">
														<td>(미등록)</td>
													</c:when>
													<c:otherwise>
														<td>${statusVO.staOft }</td>
													</c:otherwise>
												</c:choose>
												<td>${fn:substring(statusVO.sumSta, 2,statusVO.sumSta.indexOf('.'))  }</td>
												<td>
													<c:if test="${not empty statusVO.staCon }">
														<div style="color:gray;font-size: 0.7em">
															${statusVO.staNm } ${ statusVO.staJob } [ ${statusVO.staCht} ]
														</div>
														<div>
															${statusVO.staCon }
														</div>
													</c:if>
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="shadow-none rounded-0 border-bottom">
				<div class="accordion-item border-0">
					<div class="card-header p-0" id="faqAccordionHeading4">
						<button
							class="accordion-button btn btn-link text-decoration-none d-block w-100 py-2 px-3 collapsed border-0 text-start rounded-0 shadow-none"
							data-bs-toggle="collapse" data-bs-target="#collapseFaqAccordion4"
							aria-expanded="false" aria-controls="collapseFaqAccordion4">
							<span class="fas fa-caret-right accordion-icon me-3"
								data-fa-transform="shrink-2"></span><span
								class="fw-medium font-sans-serif text-900">4주차</span>
						</button>
					</div>
					<div class="accordion-collapse collapse" id="collapseFaqAccordion4"
						aria-labelledby="faqAccordionHeading4" data-parent="#accordionFaq">
						<div class="accordion-body p-0">
							<div class="card-body pt-2">
								<p class="ps-3 mb-0">
									<table class="table">
										<thead>
											<tr>
												<th scope="col">일자</th>
												<th scope="col">업무시작시간</th>
												<th scope="col">업무종료시간</th>
												<th scope="col">총 근무시간</th>
												<th scope="col">변경 이력</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${statusList }" var="statusVO" begin="21" step="1">
											<c:if test="${empty statusVO.staOnt}">
												<tr style="background-color: #E6E6FA">
											</c:if>
											<c:if test="${not empty statusVO.staOnt}">
												<tr>
											</c:if>
												<td>${statusVO.dayVal }</td>
												<c:choose>
													<c:when test="${empty statusVO.staOnt}">
														<td>(미등록)</td>
													</c:when>
													<c:otherwise>
														<td>${statusVO.staOnt }</td>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${empty statusVO.staOft}">
														<td>(미등록)</td>
													</c:when>
													<c:otherwise>
														<td>${statusVO.staOft }</td>
													</c:otherwise>
												</c:choose>
												<td>${fn:substring(statusVO.sumSta, 2,statusVO.sumSta.indexOf('.'))  }</td>
												<td>
													<c:if test="${not empty statusVO.staCon }">
														<div style="color:gray;font-size: 0.7em">
															${statusVO.staNm } ${ statusVO.staJob } [ ${statusVO.staCht} ]
														</div>
														<div>
															${statusVO.staCon }
														</div>
													</c:if>
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<br>

	</div>
</div>

<script>

	let weekSum = $('#weekSum');
	let weekOver = $('#weekOver');
	let weekLeft = $('#weekLeft');
	
	let monSum = $('#monSum');
	let monOver = $('#monOver');
	
	let workInfo = $(".workInfo");
	
//========================================================
// 1분에 한번씩 돌아가도록 설정
//========================================================
$(function() {
	const timer = function () {
		//========================================================
		// 이번주 누적/잔여/초과 시간 계산
		// 주 40시간을 기준으로 작성
		//========================================================
		$.ajax({
			url : "${cPath}/groupware/attendance/my/status/myStatusTime.do",
			dataType : "JSON",
			success : function(status) {
				weekSum.html(status.sumTime);
				weekOver.html(status.overTime);
				weekLeft.html(status.leftTime);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
		
		//========================================================
		// 이번달 누적/초과 시간 계산
		// 주 40시간 * 4 = 총 160 시간을 기준으로 작성
		//========================================================
		$.ajax({
			url : "${cPath}/groupware/attendance/my/status/myStatusMonthTime.do",
			dataType : "JSON",
			success : function(status) {
				monSum.html(status.sumTime);
				monOver.html(status.overTime);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
	
		//========================================================
		// 현재 업무시간 (출근시간/퇴근시간/현재 업무시간)
		//========================================================
		$.ajax({
			url : "${cPath}/groupware/attendance/my/status/myWorkInfo.do",
			dataType : "JSON",
			success : function(status) {
				workInfo.html("* "+status.empNm+"&nbsp;"+status.jobNm+" : "+status.staInd+" [ 오늘 업무시간 : "+status.sumTime+" ] 출근 시간 : "+status.staOnt+"  | 퇴근 시간 : "+status.staOft+" <span class='fas fa-stopwatch'></span>");
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
		
	}; 
	
	timer(); // loop 할 함수 실행
	setInterval(timer, 60000);
});

</script>