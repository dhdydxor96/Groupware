<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
.setting-content-wrapper {
	margin-top: 15px;
	margin-bottom: 15px;
	height: 500px;
}

.setting-wrapper {
	padding: 15px;
}

.setting-header-wrapper {
	margin-top: 15px;
}

.setting-footer-wrapper>a {
	float: right;
	margin-left: 5px;
	width:15%;
}

textarea {
	resize: none;
}

.absence-modal {
	padding: 15px;
}

.searchbox {
	width: 250px;
	display: inline-block;
}
.group-tree{
	padding-left:15px;
	padding-top:15px;
	
	height:400px;
	width:40%;
	overflow: scroll;
	overflow-x:hidden;
}
.choice-area{
	display:inline-block;
	font-size: 1.2em;
}
</style>

<div class="card mb-3 setting-wrapper">
	<br>
	<h3 style=" font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left; font-size:30px;"><span class="fas fa-user-clock"></span>&nbsp;부재 등록</h3>
	<hr>
	<div class="setting-header-wrapper">
		<div class="setting-content-wrapper">
			<form:form action="${cPath }/groupware/approval/setting/appProxyInsert.do" method="post" id="proxyForm">
				<h6 style=" font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:17px;"><span class="fas fa-caret-right"></span>&nbsp;부재기간</h6>
				<br>
				<div>
					<input class="form-control" type="date" name="eldStart" style="width: 15%; float:left;" /> 
					<span style="float:left;">&nbsp;~&nbsp;</span>
					<input class="form-control" type="date" name="eldEnd" style="width: 15%; float:left;" /><br>
				</div>
				<br><br>
				<h6 style=" font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:17px;"><span class="fas fa-caret-right"></span>&nbsp;부재사유</h6>
				<textarea name="eldRes" rows="8" cols="25" class="form-control"></textarea>
				<br>
				<h6 style=" font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:17px;"><span class="fas fa-caret-right"></span>&nbsp;대결자</h6>
				<br>
				<button class="btn btn-outline-primary me-1 mb-1" id="app-info" style="width:15%;" type="button" data-bs-toggle="modal"
					data-bs-target="#error-modal">대결자 선택</button>
				<div class="choice-area">
					
				</div>
				<input type="hidden" name="empProxy" id="app-proxy"/>
			</form:form>
		</div>
	</div>
	<div class="setting-footer-wrapper">
		<a class="btn btn-outline-secondary me-1 mb-1" href="${cPath }/groupware/approval/setting/absenceHome.do">취소</a>
		<a class="btn btn-outline-primary me-1 mb-1" id="proxySubmit">확인</a> 
	</div>
</div>

<div class="modal fade" id="error-modal" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document"
		style="max-width: 500px">
		<div class="modal-content position-relative absence-modal">
			<div class="modal-body p-0">
				<div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
					<h4 class="mb-1" id="modalExampleDemoLabel">대결자 선택</h4>
				</div>
				<div class="group-tree scrollbar">
					<ul class="mb-0 treeview" id="grouptree-view">
					
					</ul>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-outline-secondary me-1 mb-1" type="button">선택</button>
				<button class="btn btn-outline-primary me-1 mb-1" type="button"
					data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" defer="defer">
let errorModal = $("#error-modal");
let grouptreeView = $("#grouptree-view");
let appProxy = $("#app-proxy");

let appInfo = $("#app-info").on("click", function(){
	appProxy.val("");
	grouptreeView.empty();
	choiceArea.empty();
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

let choiceArea = $(".choice-area");
$(document).on("click", ".app-empId", function(event){
	
	let empId = $(this).data("empId");
	let empNm = $(this).data("empNm");
	let depNm = $(this).data("depNm");
	let jobNm = $(this).data("jobNm");
	let jobId = $(this).data("jobId");
	let escNm = $(this).data("escNm");
	
	console.log(empId, empNm, depNm, jobNm, jobId, escNm);
	
	choiceArea.append($("<span>").attr("class", "badge rounded-pill badge-soft-secondary")
			.text(jobNm+" "+empNm));
	
	appProxy.val(empId);
	
	errorModal.modal("hide");
	
	
});

let proxySubmit = $("#proxySubmit");
let proxyForm = $("#proxyForm");
proxySubmit.on("click", function(event){
	event.preventDefault();
	
	let start = proxyForm.find("[name=eldStart]").val();
	let end = proxyForm.find("[name=eldEnd]").val();
	let eldRes = proxyForm.find("[name=eldRes]").val();
	let checkProxy = appProxy.val();
	console.log(eldRes);
	let flag = fn_dayCheck(start, end);
	console.log(flag);
	if(flag){
		toastr.error("날짜를 다시 선택해주세요.");
		return;
	}
	if(eldRes == null || eldRes == "" || eldRes == typeof undeclaredVariable){
		toastr.error("부재 사유를 입력해주세요.");
		return;
	}
	if(eldRes == null || eldRes == "" || eldRes == typeof undeclaredVariable){
		toastr.error("부재 사유를 입력해주세요.");
		return;
	}
	if(checkProxy == null || checkProxy == "" || checkProxy == typeof undeclaredVariable){
		toastr.error("대결자를 선택해주세요.");
		return;
	}
	if(checkProxy == '${authEmp.empId}'){
		toastr.error("자기자신은 대결자가 될 수 없습니다.");
		return;
	}
	proxyForm.submit();
});

fn_dayCheck = function(dayStart, dayEnd){
	if(dayStart == null || dayStart == "" || dayStart == typeof undeclaredVariable){
		return true;
	}
	if(dayEnd == null || dayEnd == "" || dayEnd == typeof undeclaredVariable){
		return true;
	}
	let start = new Date(dayStart);
	let end = new Date(dayEnd);
	let flag = false;
	if(start > end){
		flag = true;
	}
	let curr = new Date();
	console.log(start.getDate(),curr.getDate());
	if(curr.getDate() > start.getDate()){
		flag = true;
	}
	return flag;
}
</script>