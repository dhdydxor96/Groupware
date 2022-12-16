<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<link href="${cPath}/resources/groupware/vendors/flatpickr/flatpickr.min.css" rel="stylesheet" />
<style type="text/css">
.drifting-wrapper {
	min-width: 1000px;
	padding: 15px;
}

.writeArea {
	margin-top: 15px;
	min-height: 800px;
}

.app-line-wrapper {
	display: flex;
	justify-content: space-around;
	padding-left: 10px;
	padding-right: 10px;
}

.groupMenu {
	width: 230px;
}
.selected-group {
	text-align: center;
	padding-right:15px;
	height:500px;
	overflow: scroll;
	overflow-x: hidden; 
}
.selected-group-table{
	width:800px;
	table-layout: fixed;
}

.app-state{
	padding:5px;
}
.write-table {
	text-align: center;
	margin-top:3px;
}

.write-title {
	width: 180px;
	vertical-align: middle;
}

.app-form-list {
	width: 200px;
}

.group-tree{
	padding-left:15px;
	padding-top:15px;
	
	height:400px;
	overflow: scroll;
	overflow-x:hidden;
}
.selected-group-table{
	font-size: 0.8em;
}
.app-content{
	min-width:1100px;
}
.btn-group{
	margin-top:20px;
	margin-left:20px;
}
#appLine-table{
	width:600px;
	float:right;
	table-layout: fixed;
}
.appLine-name{
	height:35px;
}
.appLine-sign{
	height:100px;
}
.ref-area{
	float: left;
	height:100px;
	padding:15px;
}
.appDocTit{
	margin-top:15px;
	margin-left:10px;
}
.date-area{
	display: none;
}
.fix-table{
	table-layout: fixed;
}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
div{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
select{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
.btn{
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-weight: bold
}
.toast-body{
	background-color: white;
}
th{
	vertical-align: middle;
}
.titTable td{
	width: 33%;
}
.titTable th{
	width: 17%;
}
#avail{
	margin-left: 45%;
}
.file-area{
	text-align: left;
}
#file-label{
	cursor: pointer;
	-webkit-user-select:none;
	-moz-user-select:none;
	-ms-user-select:none;
	user-select:none;
}
#file-label > span{
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-weight: bold;
}
.files{
	margin-right: 2px;
}
</style>

<div class="drifting-wrapper card md-3">
	<form:form id="mainForm" action="${cPath }/groupware/approval/approvalInsert.do" method="post" enctype="multipart/form-data">
		<br>
		<div>
			<h4 style="font-size: 30px;float: left">업무 기안</h4>
			<div style="float: right;">
				<input class="btn btn-outline-primary me-1 mb-1" type="submit" value="결재 요청" /> 
<!-- 				<button class="btn btn-outline-secondary me-1 mb-1">취소</button> -->
				<button class="btn btn-outline-secondary me-1 mb-1" type="button" data-bs-toggle="modal" data-bs-target="#error-modal" id="app-info">결재정보</button>
			</div>
		</div>
		<br>
		<br>
		<hr>

		<div class="writeArea">
			<table class="write-table table table-bordered titTable">
				<tr>
					<th class="appDocTit">결재 문서 제목</th>
					<td colspan="3">
						<input type="text" class="form-control" name="eleTit" required="required" placeholder="문서 제목을 입력하세요.">
					</td>
				</tr>
				<tr>
					<th>문서 양식</th>
					<td>
						<select name="apfNo" class="form-select app-form-list" required="required">
							<option value="">양식 선택</option>
						</select>
					</td>
					<th>열람 가능 여부</th>
					<td style="vertical-align: middle;text-align: center">
						<div class="form-check">
							<input class="form-check-input" id="avail" name="eleYn" type="checkbox" />
							<input type="hidden" name="_eleYn">
						</div>
					</td>
				</tr>
			</table>
			<table class="write-table table table-bordered">
				<thead>
					<tr>
						<th class="write-title">양식 종류</th>
						<td>
							<table class="table table-bordered" id="appLine-table">
								<tr class="appLine-name">
									<td class="appLine-nameArea"><span class='badge bg-secondary'>${authEmp.job.jobNm}</span><br>${authEmp.empNm }</td>
									<td class="appLine-nameArea"></td>
									<td class="appLine-nameArea"></td>
									<td class="appLine-nameArea"></td>
									<td class="appLine-nameArea"></td>
								</tr>
								<tr class="appLine-sign">
									<td class="appLine-signArea"></td>
									<td class="appLine-signArea"></td>
									<td class="appLine-signArea"></td>
									<td class="appLine-signArea"></td>
									<td class="appLine-signArea"></td>
								</tr>
							</table>
							<table class="table table-bordered fix-table">
								<tr>
									<th>기안부서</th>
									<td>${authEmp['department']['depNm'] }</td>
									<th>문서번호</th>
									<td>기안 상신시 부여</td>
								</tr>
								<tr>
									<th>기안일</th>
									<jsp:useBean id="date" class="java.util.Date" />
									<td><fmt:formatDate value="${date}"
											pattern="yyyy-MM-dd / HH:mm:ss" /></td>
									<th>문서종류</th>
									<td class="formCategory"></td>
								</tr>
								<tr>
									<th>용도</th>
									<td><input class="form-control" type="text" name="eleUse" required="required"/></td>
									<th>제출처</th>
									<td>
										<select class="form-select submit-dept" name="depId" required="required">
												<option value="">제출처 선택</option>
										</select>
									</td>
								</tr>
								<tr class="date-area">
									<th>시작날짜</th>
									<td><input class="form-control datetimepicker" name="eleStart" type="text" placeholder="d/m/y" required="required"/></td>
									<th>종료날짜</th>
									<td><input class="form-control datetimepicker" name="eleEnd" type="text" placeholder="d/m/y" required="required"/></td>
								</tr>
							</table>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="2"><textarea name="appContent" id="appEditor"
								rows="10" cols="80" placeholder="내용을 입력해주세요." required="required"></textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="file-area">
							<label for="formFileMultiple" id="file-label">
								<img src="${cPath }/resources/groupware/icon/clip.png">
								<span>첨부파일</span>
							</label>
							<input class="form-control" id="formFileMultiple" name="attFile" type="file" multiple="multiple" style="display:none"/>
							<div class="file-name"></div>
						</td>
					</tr>
					<tr>
						<th>
							참조자
						</th>
						<td>
							<div class="ref-area">
								<div class="ref-wrapper">
									
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			
		</div>
		<div class="hidden-wrapper">
		</div>
	</form:form>
</div>



<!-- ================================================= -->
<!-- Modal Area -->
<!-- ================================================= -->
<div class="modal fade" id="error-modal" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-xl mt-6"
		role="document">
		<div class="modal-content position-relative app-content">
			<div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1">
				<button
					class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
					data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
					<h4 class="mb-1" id="modalExampleDemoLabel">결재정보</h4>
				</div>
				<div class="btn-group" role="group">
				  	<button class="btn btn-outline-secondary me-1 mb-1" style="width:150px;" type="button">조직도</button>
				</div>
				<div class="app-line-wrapper">
					<div class="groupMenu">
						<div class="group-tree scrollbar">
							<ul class="mb-0 treeview" id="grouptree-view">
							
							</ul>
						</div>
					</div>
					<div class="selected-group scrollbar">
						<table class="table selected-group-table">
							<thead>
								<tr>
									<th class="gt-type">결재/참조</th>
									<th>이름</th>
									<th>직위</th>
									<th>부서</th>
									<th>상태</th>
									<th>삭제</th>
								</tr>
							</thead>
							<tbody class="selected-group-tbody">
							
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-outline-secondary me-1 mb-1" type="button"
					data-bs-dismiss="modal">취소</button>
				<button class="btn btn-outline-primary me-1 mb-1" id="btn-appLine-submit" type="button">확인</button>
			</div>
		</div>
	</div>
</div>
<!-- ================================================= -->
<!-- Modal Area End-->
<!-- ================================================= -->



<!-- ================================================= -->
<!-- Toast Area -->
<!-- ================================================= -->
<div class="position-fixed top-50 start-50 translate-middle" style="z-index: 9999" aria-live="polite" aria-atomic="true" style="min-height: 300px;">
  	<div class="toast fade" id="liveToast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header bg-secondary text-white"><strong class="me-auto"><span class="fas fa-exclamation-circle"></span></strong><small></small>
      	<button class="btn-close btn-close-white" type="button" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    	<div class="toast-body"></div>
  	</div>
</div>
<!-- ================================================= -->
<!-- Toast Area End -->
<!-- ================================================= -->

<script src="${cPath}/resources/groupware/assets/js/flatpickr.js"></script>
<script type="text/javascript" src="${cPath }/resources/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" defer="defer">
	CKEDITOR
			.replace(
					'appEditor',
					{
						customConfig : '${cPath}/resources/js/ckeditor/custom/writeForm-config.js'
					});
	
	
	// 파일 선택 ui 추가
	let formFileMultiple = $("#formFileMultiple");
	let fileName = $(".file-name");
	formFileMultiple.on("change", function(){
		fileName.empty();
		let fileList = this.files;
		console.log(fileList);
		
		for(let i=0;i<fileList.length;i++){
			let spanTag = $("<span>").attr("class", "badge rounded-pill badge-soft-secondary files").text(fileList[i].name);
			fileName.append(spanTag);
		}
	});
	
	// =============================================
	// 문서 양식 불러오기
	// =============================================
	let selectAppForm = $(".app-form-list");
	let submitDept = $(".submit-dept");
	$.ajax({
		url : "${cPath}/groupware/approval/appFormList.do",
		method : "get",
		dataType : "json",
		success : function(resp) {
			let appFormElements = [];
			let departmentElements = [];
			let appFormList = resp.appFormList;
			$.each(appFormList, function(index, appForm) {
				let tag = $("<option>").attr("value", appForm.apfNo)
									.text(appForm.apfCat)
									.data("apfNm", appForm.apfNm);
				appFormElements.push(tag);
			});
			selectAppForm.append(appFormElements);

			let departmentList = resp.departmentList;
			$.each(departmentList, function(index, department) {
				let tag = $("<option>").attr("value", department.depId)
									.data("depMag", department.depMag)
									.text(department.depNm);
				departmentElements.push(tag);
			});
			submitDept.append(departmentElements);
		},
		error : function(errorResp) {
		}
	});

	// =============================================
	// 문서 양식 선택마다 양식 바꾸기
	// =============================================
	let writeTitle = $(".write-title");
	let formCategory = $(".formCategory");
	let dateArea = $(".date-area");
	selectAppForm.on("change", function(event) {
		let title = $(".app-form-list option:checked").data("apfNm");
		let category = $(".app-form-list option:checked").text();
		
		if(category == "연차" || category == "출장" || category == "휴가"){
			console.log("dd");
			dateArea.show();
		}else{
			dateArea.hide();
		}
		
		writeTitle.html(title);
		formCategory.html(category);
	});
	
	fn_makeDateInput = function(){
		let trTag = $("<tr>")
	}
	
	// =============================================
	// 조직도 불러오기
	// =============================================
	let grouptreeView = $("#grouptree-view");
	let appInfo = $("#app-info").on("click", function(){
		grouptreeView.empty();
		$.ajax({
			url : "${cPath}/groupware/approval/departmentList.do",
			method : "get",
			dataType : "json",
			success : function(resp) {
				let departmentList = resp;
				$.each(departmentList, function(index, department) {
					let employeeList = department.employeeList;
					let deptTag = $("<li>").attr("class", "treeview-list-item")
										.append(
											$("<a>").attr("data-bs-toggle", "collapse")
													.attr("href", "#treeviewNo-" + index)
													.attr("role", "button")
													.attr("aria-expanded", "false")
													.append(
														$("<p>").attr("class", "treeview-text")
																.text(department.depNm)
													)
										);
					grouptreeView.append(deptTag);
					let empTag = $("<ul>").attr("class", "collapse treeview-list")
									.attr("id", "treeviewNo-" + index)
									.attr("data-show", "false");
					$.each(employeeList, function(num, employee){
						empTag.append(
							$("<li>").attr("class", "treeview-list-item")
									.append(
										$("<div>").attr("class", "treeview-item")
												.append(
													$("<a>").attr("class", "flex-1")
															.attr("href", "#!")
															.append(
																$("<p>").attr("class", "treeview-text app-empId")
																		.data("empId", employee.empId)
																		.data("empNm", employee.empNm)
																		.data("depNm", department.depNm)
																		.data("jobNm", employee.job.jobNm)
																		.data("jobId", employee.job.jobId)
																		.data("escNm", employee.empStcode)
																		.append(
																			$("<span>").attr("class", "me-2 far fa-user text-secondary")
																		)
																		.append(employee.empNm + " " + employee.job.jobNm)
															)
												)
									)
						)
					})
					
					deptTag.after(empTag);
						
				});
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	});
	
	// =============================================
	// 결재선 선택해서 추가하기
	// =============================================
	let appLineData = [];
	let selectedGroupTable = $(".selected-group-tbody");
	let liveToast = $("#liveToast");
	let toastBody = $(".toast-body");
	let maxToast = $("#maxToast");
	let userToast = $("#userToast");
	$(document).on("click", ".app-empId", function(event){
		let empId = $(this).data("empId");
		let empNm = $(this).data("empNm");
		let depNm = $(this).data("depNm");
		let jobNm = $(this).data("jobNm");
		let jobId = $(this).data("jobId");
		let escNm = $(this).data("escNm");
		
		console.log(empId, empNm, depNm, jobNm, jobId, escNm);
		
		if(appLineData.some( v => v.empId == empId)){
			toastBody.text("이미 결재선에 등록된 사용자입니다.");
			liveToast.attr("class", "toast show");
			return;
		};
		
		if(empId == '${authEmp.empId}'){
			toastBody.text("자기자신은 결재선에 이미 등록되어있습니다.");
			liveToast.attr("class", "toast show");
			return;
		}
		let escState = null;
		if(escNm != null){
			escState = escNm.escNm;
		}
		let trTag = $("<tr>").attr("class", "selected-line align-middle")
							.attr("data-empid", empId)
							.append(
								$("<td>").attr("class", "select-td")
									.append(
											
									$("<select>").attr("class", "form-select form-select-sm app-state")
												.attr("name", "appState")
												.append(
													$("<option>").attr("value", "결재").text("결재")
												).append(
													$("<option>").attr("value", "참조").text("참조")	
												)
								)
							).append($("<td>").text(empNm).attr("class", "empNm"))
							.append($("<td>").text(jobNm).attr("class", "jobNm"))
							.append($("<td>").text(depNm))
							.append($("<td>").text(escState))
							.append($("<td>").append(
									$("<button>").attr("class", "btn btn-light btn-del")
											.append(
										$("<span>").attr("class", "fas fa-trash-alt")		
									)
								)
							);
		selectedGroupTable.empty();
		let saveData = {
			empId : empId,
			jobId : jobId,
			trTag : trTag
		}
		let appLineTags = [];
		appLineData.push(saveData);
		
		appLineData.sort( (front, back) => {
			if(front.jobId > back.jobId) return -1;
			if(front.jobId < back.jobId) return 1;
			return 0;
		});
		
		for(let i=0;i<appLineData.length;i++){
			appLineTags.push(appLineData[i].trTag);	
		}
		
		selectedGroupTable.append(appLineTags);
	});
	
	
	// =============================================
	// 결재선 인원 삭제
	// =============================================
	let btnDel = $(document).on("click", ".btn-del", function(){
		let delElement = $(this).parent().parent();
		let empId = delElement.data("empid");
		console.log("empId ", empId);
		let index = appLineData.findIndex((e) => e.empId == empId);
		console.log("index", index);
		appLineData.splice(index,1);
		console.log(appLineData);
		delElement.remove();
	});
	
	// =============================================
	// 결재선 설정한 양식에 추가 버튼 이벤트
	// =============================================
	let errModal = $("#error-modal");
	let appLineNameArea = $(".appLine-nameArea");
	let appInput = $("input[name=appId]");
	let refWrapper = $(".ref-wrapper");
	let hiddenWrapper = $(".hidden-wrapper");
	let appCount = 0;
	let btnAppLineSubmit = $("#btn-appLine-submit").on("click", function(){
		let selectedLine = $(".selected-line");
		appCount = 0;
		let myhtml = "<span class='badge bg-secondary'>${authEmp.job.jobNm}</span><br>${authEmp.empNm}";
		appLineNameArea[0].innerHTML = myhtml;
		for(let i=1;i<5;i++){
			appLineNameArea[i].innerHTML = "";
		}
		refWrapper.empty();
		hiddenWrapper.empty();
		$.each(selectedLine, function(index, line){
			let appStateVal = $(line).find("select[name=appState]").val();
			let empNm = $(line).find(".empNm").text();
			let jobNm = $(line).find(".jobNm").text();
			let empId = $(line).data("empid");
			if(appStateVal == "결재") {
				appCount++;
				let innerTextCode = "<span class='badge bg-secondary'>" + jobNm + "</span>" + "<br>" + empNm;
				if(appCount<5){
					appLineNameArea[appCount].innerHTML = innerTextCode;
					hiddenWrapper.append(
							$("<input>").attr("name", "appId")
										.attr("value", empId)
										.attr("type", "hidden")
						);
				}
			}else{
				refWrapper.append(
					$("<span>").attr("class", "badge rounded-pill badge-soft-secondary")
								.text(jobNm+" "+empNm)
				);
				refWrapper.append(" ")
				hiddenWrapper.append(
					$("<input>").attr("name", "refId")
								.attr("value", empId)
								.attr("type", "hidden")
				);
			}
		});
		if(appCount>4){
			toastBody.text("결재선은 최대 4명까지 지원합니다.");
			liveToast.attr("class", "toast show");
			return;
		}else{
			errModal.modal("hide");
		}
	});
	
	// =============================================
	// 결재선 인원 검사, 결재선에 1명도 등록 안될 시 toast 표시
	// =============================================
	let appLineToast = $("#appLineToast");
	let mainForm = $("#mainForm").on("submit", function(event){
		if(appCount<1){
			toastBody.text("최소 1명 결재자를 선택해야합니다.");
			liveToast.attr("class", "toast show");
			event.preventDefault();
		}
		
		let eleStart = mainForm.find("input[name=eleStart]").val();
		let eleEnd = mainForm.find("input[name=eleEnd]").val();
		
		let flag = fn_dayCheck(eleStart, eleEnd);
		if(flag){
			toastBody.text("날짜를 다시 선택해주세요.");
			liveToast.attr("class", "toast show");
			event.preventDefault();
		}
	});
	
	fn_dayCheck = function(dayStart, dayEnd){
		let start = new Date(dayStart);
		let end = new Date(dayEnd);
		let flag = false;
		if(start > end){
			flag = true;
		}
// 		let curr = new Date();
// 		if(curr > start){
// 			flag = true;
// 		}
		return flag;
	}
	
</script>