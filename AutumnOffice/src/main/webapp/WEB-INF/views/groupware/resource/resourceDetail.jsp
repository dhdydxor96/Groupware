<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
.card {
	padding:1%;
}

table {
	border-collapse: collapse;
}
.rightSpan{
	text-align: right;	
}
.leftA{
	text-align: left;
}
th{
	width:12.5%;
} 
.tooltip-inner {
	white-space: pre-wrap; 
}
.selectTd{
	background-color: #6495ED;color: white;font-weight: bold;
}

/* 가상 툴팁 생성 */
#normalTooltip {
  position: relative;
  display: inline-block;
}

#normalTooltip #normalTooltipText {
  visibility: hidden;
  width: 120px;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;
  position: absolute;
  z-index: 1;
  bottom: 150%;
  left: 50%;
  margin-left: -60px;
}

#normalTooltip #normalTooltipText::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: black transparent transparent transparent;
}

#normalTooltip:hover #normalTooltipText {
  visibility: visible;
}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
select{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
h3{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
label{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
textarea{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
.btn{
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-weight: bold;
}

</style>

<div id="rectangle"></div>
<div class="card mb-3">
	<!-- -------------------------- -->
	<!--  		  회의실 정보		   	-->
	<!-- -------------------------- -->
	<div style="text-align: left">
		<br>	
		<div>
			<h3 style="font-weight: bold;"><span class="fas fa-chalkboard-teacher"></span>&nbsp;${resourceInfoVO.meetNm }</h3>
		</div>	
		<hr>
		<table class="table">
			<tr>
				<td colspan="4">
					<h5>${resourceInfoVO.meiPla } <button class="btn btn-outline-primary me-1 mb-1" type="button" data-bs-toggle="modal" data-bs-target="#reserv-modal" style="float:right;">예약하기</button></h5> 
				</td>
				<td rowspan="4" style="width: 50%;height: 40%">
					<c:url var="imageViewURL" value="/groupware/resource/resourceImageView.do">
						<c:param name="what" value="${resourceInfoVO.meetNo }"></c:param>
					</c:url>
					<img src="${imageViewURL}" alt="회의실사진"style="width: 100%;height: 100%">
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div>회의실 수용 인원 : ${resourceInfoVO.meiPer}</div>
				</td>
			</tr>
			
			<tr style="text-align: center">
				<th><span data-bs-toggle="tooltip" data-bs-placement="top" title="빔프로젝터"><span class="fas fa-video"></span></span></th>
				<th><span data-bs-toggle="tooltip" data-bs-placement="top" title="스크린"><span class="fas fa-chalkboard-teacher" ></span></span></th>
				<th><span data-bs-toggle="tooltip" data-bs-placement="top" title="화이트보드"><span class="fas fa-chalkboard" ></span></span></th>
				<th><span data-bs-toggle="tooltip" data-bs-placement="top" title="사무용품"><span class="fas fa-pen-alt" ></span></span></th>
			</tr>
			<tr style="text-align: center">
				<td>
					<c:if test="${resourceInfoVO.meiBeam eq 'Y' }">
						<span class="far fa-check-circle" style="color:green"></span>
					</c:if>
					<c:if test="${resourceInfoVO.meiBeam eq 'N' }">
						<span class="far fa-times-circle" style="color:red"></span>
					</c:if>
				</td>
				<td>
					<c:if test="${resourceInfoVO.meiScr eq 'Y' }">
						<span class="far fa-check-circle" style="color:green"></span>
					</c:if>
					<c:if test="${resourceInfoVO.meiScr eq 'N' }">
						<span class="far fa-times-circle" style="color:red"></span>
					</c:if>
				</td>
				<td>
					<c:if test="${resourceInfoVO.meiBod eq 'Y' }">
						<span class="far fa-check-circle" style="color:green"></span>
					</c:if>
					<c:if test="${resourceInfoVO.meiBod eq 'N' }">
						<span class="far fa-times-circle" style="color:red"></span>
					</c:if>
				</td>
				<td>
					<c:if test="${resourceInfoVO.meiItem eq 'Y' }">
						<span class="far fa-check-circle" style="color:green"></span>
					</c:if>
					<c:if test="${resourceInfoVO.meiItem eq 'N' }">
						<span class="far fa-times-circle" style="color:red"></span>
					</c:if>
				</td>
			</tr>
		</table>
		<hr>
	</div>
	<br><br><br>
	
	<br>
	
	<!-- -------------------------- -->
	<!--  		이번주 날짜 조회		   	-->
	<!-- -------------------------- -->
	<h3 style="text-align: center;font-weight: bold">${reservVO.startDay } ~ ${reservVO.endDay }</h3>
	
	
	<!-- -------------------------- -->
	<!--  		예약 현황 테이블		   	-->
	<!-- -------------------------- -->
	<table class="table reservTable" style="text-align: center">
		<thead>
		<tr>
			<th></th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
		</tr>
		</thead>
		<tbody id="tbody">
			<c:forEach items="${reservVOList}" var="reservResultVO" varStatus="status">
				<c:if test="${reservResultVO.timeTxt eq '09:00~10:00' }">
					<c:choose>
						<c:when test="${empty statusNum }">
								<tr>
								<td>${reservResultVO.timeTxt }</td>
							<c:set var="statusNum" value="${status.current }"></c:set>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${fn:contains(reservResultVO.rsvNms, resourceInfoVO.meetNo)}">
							<td style="background-color: #6495ED;color: white;font-weight: bold;" data-bs-toggle="tooltip" data-bs-placement="top" title="${reservResultVO.dayVal}&#010;${reservResultVO.timeTxt}&#010;[${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }]&nbsp;${reservResultVO.revCon}">${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>
					<c:if test="${status.last eq true }">
						<tr>
					</c:if>
				</c:if>
			</c:forEach>
			<c:remove var="statusNum"/>
			<c:forEach items="${reservVOList}" var="reservResultVO" varStatus="status">
				<c:if test="${reservResultVO.timeTxt eq '10:00~11:00' }">
					<c:choose>
						<c:when test="${empty statusNum }">
								<tr>
								<td>${reservResultVO.timeTxt }</td>
							<c:set var="statusNum" value="${status.current }"></c:set>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${fn:contains(reservResultVO.rsvNms, resourceInfoVO.meetNo)}">
							<td style="background-color: #6495ED;color: white;font-weight: bold;" data-bs-toggle="tooltip" data-bs-placement="top" title="${reservResultVO.dayVal}&#010;${reservResultVO.timeTxt}&#010;[${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }]&nbsp;${reservResultVO.revCon}">${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>
					<c:if test="${status.last eq true }">
						<tr>
					</c:if>
				</c:if>
				</c:forEach>
				<c:remove var="statusNum"/>
				<c:forEach items="${reservVOList}" var="reservResultVO" varStatus="status">
				<c:if test="${reservResultVO.timeTxt eq '11:00~12:00' }">
					<c:choose>
						<c:when test="${empty statusNum }">
								<tr>
								<td>${reservResultVO.timeTxt }</td>
							<c:set var="statusNum" value="${status.current }"></c:set>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${fn:contains(reservResultVO.rsvNms, resourceInfoVO.meetNo)}">
							<td style="background-color: #6495ED;color: white;font-weight: bold;" data-bs-toggle="tooltip" data-bs-placement="top" title="${reservResultVO.dayVal}&#010;${reservResultVO.timeTxt}&#010;[${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }]&nbsp;${reservResultVO.revCon}">${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>
					<c:if test="${status.last eq true }">
						<tr>
					</c:if>
				</c:if>
				</c:forEach>
				<c:remove var="statusNum"/>
				<c:forEach items="${reservVOList}" var="reservResultVO" varStatus="status">
				<c:if test="${reservResultVO.timeTxt eq '12:00~13:00' }">
					<c:choose>
						<c:when test="${empty statusNum }">
								<tr>
								<td>${reservResultVO.timeTxt }</td>
							<c:set var="statusNum" value="${status.current }"></c:set>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${fn:contains(reservResultVO.rsvNms, resourceInfoVO.meetNo)}">
							<td style="background-color: #6495ED;color: white;font-weight: bold;" data-bs-toggle="tooltip" data-bs-placement="top" title="${reservResultVO.dayVal}&#010;${reservResultVO.timeTxt}&#010;[${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }]&nbsp;${reservResultVO.revCon}">${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>
					<c:if test="${status.last eq true }">
						<tr>
					</c:if>
				</c:if>
				</c:forEach>
				<c:remove var="statusNum"/>
				<c:forEach items="${reservVOList}" var="reservResultVO" varStatus="status">
				<c:if test="${reservResultVO.timeTxt eq '13:00~14:00' }">
					<c:choose>
						<c:when test="${empty statusNum }">
								<tr>
								<td>${reservResultVO.timeTxt }</td>
							<c:set var="statusNum" value="${status.current }"></c:set>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${fn:contains(reservResultVO.rsvNms, resourceInfoVO.meetNo)}">
							<td style="background-color: #6495ED;color: white;font-weight: bold;" data-bs-toggle="tooltip" data-bs-placement="top" title="${reservResultVO.dayVal}&#010;${reservResultVO.timeTxt}&#010;[${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }]&nbsp;${reservResultVO.revCon}">${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>
					<c:if test="${status.last eq true }">
						<tr>
					</c:if>
				</c:if>
				</c:forEach>
				<c:remove var="statusNum"/>
				<c:forEach items="${reservVOList}" var="reservResultVO" varStatus="status">
				<c:if test="${reservResultVO.timeTxt eq '14:00~15:00' }">
					<c:choose>
						<c:when test="${empty statusNum }">
								<tr>
								<td>${reservResultVO.timeTxt }</td>
							<c:set var="statusNum" value="${status.current }"></c:set>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${fn:contains(reservResultVO.rsvNms, resourceInfoVO.meetNo)}">
							<td style="background-color: #6495ED;color: white;font-weight: bold;" data-bs-toggle="tooltip" data-bs-placement="top" title="${reservResultVO.dayVal}&#010;${reservResultVO.timeTxt}&#010;[${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }]&nbsp;${reservResultVO.revCon}">${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>
					<c:if test="${status.last eq true }">
						<tr>
					</c:if>
				</c:if>
				</c:forEach>
				<c:remove var="statusNum"/>
				<c:forEach items="${reservVOList}" var="reservResultVO" varStatus="status">
				<c:if test="${reservResultVO.timeTxt eq '15:00~16:00' }">
					<c:choose>
						<c:when test="${empty statusNum }">
								<tr>
								<td>${reservResultVO.timeTxt }</td>
							<c:set var="statusNum" value="${status.current }"></c:set>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${fn:contains(reservResultVO.rsvNms, resourceInfoVO.meetNo)}">
							<td style="background-color: #6495ED;color: white;font-weight: bold;" data-bs-toggle="tooltip" data-bs-placement="top" title="${reservResultVO.dayVal}&#010;${reservResultVO.timeTxt}&#010;[${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }]&nbsp;${reservResultVO.revCon}">${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>
					<c:if test="${status.last eq true }">
						<tr>
					</c:if>
				</c:if>
				</c:forEach>	
				<c:remove var="statusNum"/>
				<c:forEach items="${reservVOList}" var="reservResultVO" varStatus="status">
				<c:if test="${reservResultVO.timeTxt eq '16:00~17:00' }">
					<c:choose>
						<c:when test="${empty statusNum }">
								<tr>
								<td>${reservResultVO.timeTxt }</td>
							<c:set var="statusNum" value="${status.current }"></c:set>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${fn:contains(reservResultVO.rsvNms, resourceInfoVO.meetNo)}">
							<td style="background-color: #6495ED;color: white;font-weight: bold;" data-bs-toggle="tooltip" data-bs-placement="top" title="${reservResultVO.dayVal}&#010;${reservResultVO.timeTxt}&#010;[${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }]&nbsp;${reservResultVO.revCon}">${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>
					<c:if test="${status.last eq true }">
						<tr>
					</c:if>
				</c:if>
				</c:forEach>
				<c:remove var="statusNum"/>
				<c:forEach items="${reservVOList}" var="reservResultVO" varStatus="status">
				<c:if test="${reservResultVO.timeTxt eq '17:00~18:00' }">
					<c:choose>
						<c:when test="${empty statusNum }">
								<tr>
								<td>${reservResultVO.timeTxt }</td>
							<c:set var="statusNum" value="${status.current }"></c:set>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${fn:contains(reservResultVO.rsvNms, resourceInfoVO.meetNo)}">
							<td style="background-color: #6495ED;color: white;font-weight: bold;" data-bs-toggle="tooltip" data-bs-placement="top" title="${reservResultVO.dayVal}&#010;${reservResultVO.timeTxt}&#010;[${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }]&nbsp;${reservResultVO.revCon}">${fn:substring(reservResultVO.rsvNms, fn:indexOf(reservResultVO.rsvNms,resourceInfoVO.meetNo)+4,7) }</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>
					<c:if test="${status.last eq true }">
						<tr>
					</c:if>
				</c:if>
			</c:forEach>
			<c:remove var="statusNum"/>
					
		</tbody>
	</table>
	<br>
	<br>
	<button type="button" onclick="location.href='${cPath}/groupware/resource/resourceList.do'" class="btn btn-outline-secondary me-1 mb-1" style="width:20%;margin-left:40%" >목록으로</button>
	<br>

	<!-- -------------------------- -->
	<!--  		예약하기 모달		   	-->
	<!-- -------------------------- -->
	<div class="modal fade" id="reserv-modal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
	    <div class="modal-content position-relative">
	      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1">
	        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body p-0">
	        <div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
	          <h4 class="mb-1" id="modalExampleDemoLabel"><span class="fas fa-caret-right"></span>&nbsp;${meetInfoVO.meetNm } 예약하기</h4>
	        </div>
	        <div class="p-4 pb-0">
	          <form  id="InsertForm" >
	            <div class="mb-3">
	              <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	              <input type="hidden" value="${resourceInfoVO.meetNo }" name="meetNo" />
	              <label class="col-form-label" for="recipient-name">예약 날짜</label>
	              <input class="form-control" id="recipient-name" type="date" name="revStart" required  />
	              <label class="col-form-label" for="recipient-name">예약 시간</label>
	              <select class="form-select" name="metTime" required>
	              	<c:forEach items="${meetTimeVOList}" var="time">
		              	<option value="${time.metTime}">${time.metCon }</option>
	              	</c:forEach>
	              	
	              </select> 
	            </div>
	            <div class="mb-3">
	              <label class="col-form-label" for="message-text" >이용사유</label>
	              <textarea class="form-control" id="message-text" name="revCon" required ></textarea>
	            </div>
	          </form>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button class="btn btn-outline-primary me-1 mb-1" type="button" id="reservBtn">예약하기</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>

<form>
	<input type="hidden" id="hiddenMsg" value="${message}">
</form>

<c:if test="${not empty message}">
<script>
	let hiddenMsg = $("#hiddenMsg").val();

	toastr.info(hiddenMsg);
</script>
</c:if>

<script>
	let reservBtn = $("#reservBtn");
	
	let meetReser = $("#InsertForm").serialize() ;
	
	let table = $(".reservTable");
	let tableBody = $( '.reservTable > tbody');
	let reservModal = $('#reserv-modal');
	
	//========================================================
	// 예약 버튼을 클릭했을 때
	//========================================================
	reservBtn.on("click", function(){
		let revStart = $("[name=revStart]").val();
		let metTime = $("select[name=metTime]").val();
		let revCon = $("[name=revCon]").val()
		
		if(revStart && metTime && revCon){
			 var objParams = {
	                        "meetNo"      : ${resourceInfoVO.meetNo },
	                        "revStart" : revStart ,
	                        "metTime" : metTime,
	                        "revCon" : revCon
	         };
			
			$.ajax({
				url : "${cPath}/groupware/resource/resourceInsert.do",
				method : "post",
				data: objParams ,
				dataType : "JSON",
				success : function(reservVOList) {
					tableBody.empty();
					let lastIndex = reservVOList.length;
					
					console.log("list:",reservVOList);
					let tbodyStr ="";
					for(let i=0; i<reservVOList.length; i++) {
						if((i%5) == 0){
							tbodyStr +="<tr><td>"+reservVOList[i].timeTxt+"</td>";	
						}
						
						if(reservVOList[i].revCon == null){
							tbodyStr += "<td></td>";
						}else{
						  tbodyStr +="<td style='background-color: #6495ED;color: white;font-weight: bold;' ><div id='normalTooltip'>"+reservVOList[i].rsvNms.substring(4,7);
						  tbodyStr +="<span id='normalTooltipText'>"+reservVOList[i].dayVal+"&#010;"+reservVOList[i].timeTxt+"<br>["+reservVOList[i].rsvNms.substring(4,7)+"]<br>"+reservVOList[i].revCon+"</span>";
						  tbodyStr +="</div></td>";
						}
						
						if((i%5) == 4){
						  tbodyStr +="</tr>";
						}
					}
	
					tableBody.html(tbodyStr);
	
					reservModal.modal('hide');
					reservModal.find('form')[0].reset();
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
		}else{
			//========================================================
			// 예약 내용을 정확히 입력하지 않은 경우
			//========================================================
			toastr.error("예약 내용을 정확히 입력해주세요.");
		}
	});
	
</script>