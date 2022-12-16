<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.card {
	padding: 1%;
}

a {
	color: black;
	text-decoration: none;
}

#period {
	text-align: center;
	font-size: 1.5em;
}

.month {
	color: #C0C0C0;
}

.col-auto {
	font-weight: bold;
}
.justify-content-left{
	padding-bottom: 5px;
}

.day{
	width:9%;
}
.info{
	width:13%;
}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
div{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
span{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
th, td{
	text-align: center;
}
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
a{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
.btn{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
select{
	font-family: 'IBM Plex Sans KR', sans-serif;
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
	<h3 style=""><span class="fas fa-business-time"></span>&nbsp;부서 근태 현황</h3>
	<hr>
	<br> <br>

	<!-- -------------------------- -->
	<!--     이번주 날짜 띄우기      	    -->
	<!-- -------------------------- -->
	<div id="period" style="font-weight: bold">
		&nbsp;&nbsp;&nbsp;${thisWeek}&nbsp;&nbsp;&nbsp; 
	</div>
	<br> 

	<!-- -------------------------- -->
	<!--     부서 근태 현황      	   		 -->
	<!-- -------------------------- -->
	<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col" class="info">이름</th>
				<th scope="col" class="info">부서</th>
				<th scope="col" class="info">누적근무시간</th>
				<th scope="col" class="day">월</th>
				<th scope="col" class="day">화</th>
				<th scope="col" class="day">수</th>
				<th scope="col" class="day">목</th>
				<th scope="col" class="day">금</th>
				<th scope="col" class="day" style="color: skyblue">토</th>
				<th scope="col" class="day" style="color: coral">일</th>
			</tr>
		</thead>
		<tbody id="listBody">
		</tbody>
	</table>
	<br>
	<form id="searchForm">
		<input type="hidden" name="page" />
		<input type="hidden" name="searchType" />
		<input type="hidden" name="searchWord" />
	</form>
	<br>
	<div class="pagingArea"></div>
	<br>
	<!-- (제목-title, 작성자-writer, 내용-content, 전체) -->
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-select">
				<option value>전체</option>
				<option value="name" >이름</option>
				<option value="dept">부서</option>
			</select>
		</div>
		<div class="col-auto">
			<input type="text" name="searchWord" placeholder="검색키워드"
				class="form-control" value=""
			/>
		</div>
		<div class="col-auto">
			<input type="button" value="검색" id="searchBtn"
				class="btn btn-outline-secondary me-1 mb-1"
				style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight: bold"
			/>
		</div>
	</div>


</div>

<!-- -------------------------- -->
<!--  부서원의 근태 상태를 변경하는 모달    -->
<!-- -------------------------- -->
<div class="modal fade" id="status-modal" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document"
		style="max-width: 500px">
		<div class="modal-content position-relative">
			<div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1">
				<button
					class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
					data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
					<h4 class="mb-1" id="modalExampleDemoLabel"><span class="fas fa-caret-right"></span>&nbsp;근태 상태 변경</h4>
				</div>
				<form action="${cPath}/groupware/attendance/dept/status/updateDeptEmployeeStatus.do" method="post">
				<div class="p-4 pb-0">
					<!-- 변경하기 -->
						<div class="row g-3 justify-content-left">
							<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
							<div class="col-auto">상태 *</div>
							<div class="col-auto">
								<select class="form-select" style="width:267%" name="escCode" required >
									<option value="B">퇴근</option>
									<option value="C">지각</option>
									<option value="F">조퇴</option>
									<option value="G">결근</option>
								</select>
							</div>
						</div>
						<div class="row g-3 justify-content-left">
							<input type="hidden" id="hiddenId" name="empId">
							<div class="col-auto">일시 *</div>
							<div class="col-auto">
								<input type="datetime-local" class="form-control" name="updateDay" required  />
							</div>
						</div>
						<div class="row g-3 justify-content-left">
							<div class="col-auto">내용 *</div>
							<div class="col-auto">
								<input type="text"  style="width:108%" class="form-control" name="staCon" required />
							</div>
						</div>
				</div>
				<div class="p-4 pb-0" >
					<div class="row g-3  justify-content-right" style="text-align: right;">
						<div >
							<button class="btn btn-outline-primary me-1 mb-1" style="font-weight: bold" type="submit">변경</button>
						</div>
					</div>
				</div>
				</form>
				<hr>
				<div class="p-4 pb-0">
					<div style="text-align: left;font-size: 17px;font-weight: bold">
							<span class="fas fa-caret-right"></span>&nbsp;변경이력
					</div>
						<hr>
					<div>
						<table class="table">
							<thead>
								<tr>
									<th>출퇴근일자</th>
									<th>변경자</th>
									<th>변경사유</th>
									<th>근태변경일</th>
								</tr>
							</thead>
							<tbody  id="changeStatus">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</div>


<script>
	// 모달 띄울 때 폼에 hidden으로 ID 값 넣어주기
	let hiddenId = $('#hiddenId');
	let changeStatus = $("#changeStatus");
	
	//========================================================
	// 부서원 클릭했을 때 부서원의 근태상태를 변경할 수 있는 모달 띄우기
	//========================================================
	$(document).on('click', 'tr', function(){
		
		let Id = $(this).attr('id');
		
		hiddenId.val(Id);
		
		// 변경이력 띄우기
		$.ajax({
			url : "${cPath}/groupware/attendance/dept/status/deptChangeStatus.do",
			data : { who : Id },
			dataType : "JSON",
			success : function(changelist) {
				changeStatus.empty();
				
				let changetrTags = [];
				
				$.each(changelist, function(index, status){
					
					if(status.staNm!=null){
						let changeTr = "<tr><td>"+status.staInd+"</td><td>"+status.staNm+"&nbsp;"+status.staJob+"</td><td>"+status.staCon+"</td><td>"+status.staCht+"</td></tr>"
						changetrTags.push(changeTr);
					}
					
				});
				
				if(changetrTags.length==0){
					changetrTags.push("<tr><td colspan='4'>변경 이력이 존재하지 않습니다.</td></tr>");
				}
				
				changeStatus.append(changetrTags);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
	})
	
	
	//========================================================
	// 부서 근태 현황 페이징 처리
	//========================================================
	let searchUI = $("#searchUI").on("click", "#searchBtn", function(event){
			let inputTags = searchUI.find(":input[name]");
			$.each(inputTags, function(index, inputTag){
				let name = $(this).attr("name");
				let value = $(this).val();
				searchForm.get(0)[name].value = value;
			});
			searchForm.submit();
		});
		let pageTag = $("[name=page]");
		let listBody = $("#listBody");
		let pagingArea = $(".pagingArea").on("click", "a", function(event){
			event.preventDefault();
			let page = $(this).data("page");
			if(!page) return false;
			pageTag.val(page);
			searchForm.submit();
			return false;
		});
		
		let searchForm = $("#searchForm").on("submit", function(event){
			event.preventDefault();
			let data = $(this).serialize();
			$.ajax({
				url : "${cPath}/groupware/attendance/dept/status/deptStatusList.do",
				data : data,
				dataType : "json",
				success : function(pagingVO) {
					listBody.empty();
					pagingArea.empty();
					pageTag.val("");
					let list = pagingVO.dataList;
					let trTags = [];
					if(list.length > 0){
					$.each(list, function(index, status){
	//	 				console.log(index + "[인덱스] : " + (index % 7) + "[7나눈 나머지] : " + (index % 7 == 0))
						if(index % 7 == 0){ // 한 부서원의 시작값일때
							tr = "<tr data-bs-toggle='modal' data-bs-target='#status-modal' id='"+status.empId+"'>"+
								 "<td>"+status.empNm+"&nbsp;"+status.jobNm+"</td>"+
								 "<td>"+status.depNm+"</td>";
								 
								 if(status.sumSecond!=null){
									 tr += "<td>"+status.sumSecond+"</td>";
								 }else{
									 tr += "<td>0h 0m</td>";
								 }
								 
							console.log(tr);
						}
						
							tr += "<td>"+status.allTime+"</td>";
						
						console.log("인덱스"+index)
						console.log(tr);
								 
						if(index % 7 == 6 ){ // 한 부서원의 마지막 값일 때
							tr += "</tr>";
							trTags.push(tr);
						}
						
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "10")
								 .html("조건에 맞는 게시글이 없음.")
					);
					trTags.push(tr);
				}
				listBody.append(trTags);
				let pagingHTML = pagingVO.pagingHTML;
				pagingArea.html(pagingHTML);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
		return false;
		}).submit();
	
	//========================================================
	//1분에 한번씩 돌아가도록 설정 - 현재 업무시간 (출근시간/퇴근시간/현재 업무시간)
	//======================================================== 
	let workInfo = $(".workInfo");
	
	$(function() {
			const timer = function () {
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