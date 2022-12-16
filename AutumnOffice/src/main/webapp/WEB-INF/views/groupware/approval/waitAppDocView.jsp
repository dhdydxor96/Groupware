<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="${cPath }/resources/groupware/assets/custom/docView.js"></script>
<style type="text/css">
.drifting-wrapper {
	min-width: 1000px;
	padding: 15px;
}

.writeArea {
	margin-top: 30px;
	min-height: 800px;
}

.app-line-wrapper {
	display: flex;
	justify-content: space-around;
	padding-left: 10px;
	padding-right: 10px;
}
.table-fixed{
	table-layout: fixed;
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
	margin-top:3px;
}
.write-table-thead{
	text-align: center;
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
	height:120px;
	padding:15px;
}
.appDocTit{
	margin-top:15px;
	margin-left:10px;
}
.app-wrapper{
	height:500px;
}
.title-area{
	display: flex;
	justify-content: space-between;
}
.modal-height{
	height:90px;
}
.sign-img{
	width: 75px;
	height : 75px;
}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
div{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
select{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
label{
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-weight: bold;
	font-size: 20px
}
.btn{
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-weight: bold;
}
h3{
	font-size: 30px;
	font-weight: bold;
}
th{
	vertical-align: middle;
	text-align: center;
}
.text-area{
	height:180px;
}
#cancel-content{
	resize: none;
}
.hidden-wrapper{
	float:right;
}
</style>

<div class="drifting-wrapper card md-3">
	<form:form id="mainForm" action="${cPath }/groupware/approval/approvalInsert.do" method="post" enctype="multipart/form-data">
		<br>
		<div>
			<h3 style="float: left"><span class="far fa-clipboard"></span>&nbsp;${eleMenu }</h3>
			<div style="float: right;">
				<a href="javascript:window.history.back();" class="btn btn-outline-secondary me-1 mb-1">뒤로</a>
				<button class="btn btn-outline-secondary me-1 mb-1" type="button" data-bs-toggle="modal" data-bs-target="#info-modal" id="app-info">결재정보</button>
			</div>
		</div>
		<br>
		<br>
		<hr>
		<div class="writeArea">
			<div class="title-area">
				<h4 style="float: left"><span class="fas fa-caret-right"></span> ${elecApp.eleTit }</h4>
				<div style="float: right;margin-top: 1%">
					열람 가능 여부 : 
					<c:if test="${elecApp.eleYn eq true}">
						<span class="badge badge-soft-primary">Y</span>
					</c:if>
					<c:if test="${elecApp.eleYn eq false}">
						<span class="badge badge-soft-danger">N</span>
					</c:if>
				</div>
			</div>
			<table class="write-table table table-bordered">
				<thead class="write-table-thead">
					<tr>
						<th class="write-title">${elecApp.appForm.apfNm }</th>
						<td>
							<table class="table table-bordered" id="appLine-table">
								<tr class="appLine-name">
									<td class="appLine-nameArea"><span class='badge bg-secondary'>${elecApp.jobNm}</span><br>${elecApp.empNm }</td>
									<td class="appLine-nameArea"><span class='badge bg-secondary'>${elecApp.aplDetailList[0].employee.job.jobNm}</span><br>${elecApp.aplDetailList[0].employee.empNm }${elecApp.aplDetailList[0].decSta eq true ? '(대결)' : ''}</td>
									<td class="appLine-nameArea"><span class='badge bg-secondary'>${elecApp.aplDetailList[1].employee.job.jobNm}</span><br>${elecApp.aplDetailList[1].employee.empNm }${elecApp.aplDetailList[1].decSta eq true ? '(대결)' : ''}</td>
									<td class="appLine-nameArea"><span class='badge bg-secondary'>${elecApp.aplDetailList[2].employee.job.jobNm}</span><br>${elecApp.aplDetailList[2].employee.empNm }${elecApp.aplDetailList[2].decSta eq true ? '(대결)' : ''}</td>
									<td class="appLine-nameArea"><span class='badge bg-secondary'>${elecApp.aplDetailList[3].employee.job.jobNm}</span><br>${elecApp.aplDetailList[3].employee.empNm }${elecApp.aplDetailList[3].decSta eq true ? '(대결)' : ''}</td>
								</tr>
								<tr class="appLine-sign">
									<c:if test="${elecApp.empSign eq null }">
										<td class="appLine-signArea align-middle"><img src="${cPath }/resources/groupware/icon/approval.png" class="sign-img"/></td>
									</c:if>
									<c:if test="${elecApp.empSign ne null }">
										<td class="appLine-signArea align-middle"><img src="data:image/*;base64,${elecApp.base64Img }" class="sign-img"/></td>
									</c:if>
									<td class="appLine-signArea align-middle"></td>
									<td class="appLine-signArea align-middle"></td>
									<td class="appLine-signArea align-middle"></td>
									<td class="appLine-signArea align-middle"></td>
								</tr>
							</table>
							<table class="table table-bordered table-fixed">
								<tr>
									<th>기안부서</th>
									<td>${elecApp.eleDepnm }</td>
									<th>문서번호</th>
									<td>${elecApp.eleNo }</td>
								</tr>
								<tr>
									<th>기안일</th>
									<td>${elecApp.eleCrd }</td>
									<th>문서종류</th>
									<td class="formCategory">${elecApp.appForm.apfCat }</td>
								</tr>
								<tr>
									<th>용도</th>
									<td>${elecApp.eleUse }</td>
									<th>제출처</th>
									<td>${elecApp.depNm}</td>
								</tr>
								<c:if test="${not empty elecApp.eleStart }">
								<tr class="date-area">
									<th>시작날짜</th>
									<td>${elecApp.eleStart }</td>
									<th>종료날짜</th>
									<td>${elecApp.eleEnd }</td>
								</tr>
								</c:if>
							</table>
						</td>
					</tr>
				</thead>
			</table>
			<table class="table table-bordered">
				<tr>
					<td colspan="2">${elecApp.eleCon }</td>
				</tr>
			</table>
			<table class="table table-bordered">
			<c:if test="${ not empty elecApp.attatchList }">
				<tr>
					<td colspan="2">
						<c:forEach items="${elecApp.attatchList }" var="attatch" varStatus="vs">
							<span class="fas fa-paperclip"></span>
							<c:url value="/groupware/approval/download.do" var="downloadURL">
								<c:param name="what" value="${attatch.attNo }"/>
							</c:url>
								<a href="${downloadURL }">${attatch.attFnm }</a> (${attatch.attFas })
								${not vs.last?"|":"" }
						</c:forEach>
					</td>
				</tr>
			</c:if>
			<tr>
				<th style="width:19%">참조자</th>
				<td>
					<div class="ref-area">
						<div class="ref-wrapper">
							<c:if test="${not empty elecApp.eleRefList }">
								<c:forEach items="${elecApp.eleRefList }" var="eleRef" varStatus="vs">
									<span class="badge rounded-pill badge-soft-secondary">${eleRef.jobNm }&nbsp;${eleRef.empNm }</span>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</td>
			</tr>
			</table>
			<div class="rer-wrapper">
			
			</div>
		</div>
		<div class="hidden-wrapper">
		<c:if test="${authEmp.empId eq elecApp.empId }">
			<button id="elec-cancel" class="btn btn-outline-secondary me-1 mb-1">상신 취소</button>
		</c:if>
		</div>
	</form:form>
</div>
<form:form id="aplForm" action="${cPath }/groupware/approval/approvalUpdate.do" method="post">
	<input type="hidden" name="eleNo" value="${elecApp.eleNo }"/>
	<input type="hidden" name="aplNo" value="${elecApp.aplNo }"/>
	<input type="hidden" name="cancel" value=""/>
</form:form>

<form:form id="delForm" action="${cPath }/groupware/approval/approvalDelete.do">
	<input type="hidden" name="eleNo" value="${elecApp.eleNo }"/>
</form:form>

<!-- 상신취소 Modal -->
<div class="modal fade" id="cancel-modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
    <div class="modal-content position-relative">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1">
        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-0">
        <div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
          <h4 class="mb-1" id="modalExampleDemoLabel">상신 취소</h4>
        </div>
        <div class="p-4 pb-0">
            <div class="mb-3">상신을 취소하시겠습니까?</div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" type="button" name="yes">예</button>
        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">아니오</button>
      </div>
    </div>
  </div>
</div>

<!-- 결재 정보 Modal -->
<div class="modal fade" id="info-modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document" style="max-width: 500px">
    <div class="modal-content position-relative">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1">
        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-0">
        <div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
          <h4 class="mb-1"><span class="fas fa-caret-right"></span> 결재 정보</h4>
        </div>
        <div class="p-4 pb-0 scrollbar app-wrapper">
            <div class="mb-3">
              <label class="col-form-label" for="recipient-name"><span class="fas fa-caret-right"></span> 결재선</label>
              <table class="table" style="text-align: center">
				  <thead>
				    <tr>
			      		<th scope="col" style="width: 25%">결재자</th>
				      	<th scope="col" style="width: 22%">부서</th>
				      	<th scope="col" style="width: 22%">결재여부</th>
				      	<th scope="col" style="width: 31%">결재날짜</th>
				    </tr>
				  </thead>
				  <tbody>
				    <tr>
				      	<td>${elecApp.aplDetailList[0].employee.job.jobNm}<br>${elecApp.aplDetailList[0].employee.empNm }</td>
				      	<td>${elecApp.aplDetailList[0].employee.department.depNm }</td>
				      	<td>${elecApp.aplDetailList[0].appState }</td>
				      	<td>${elecApp.aplDetailList[0].aplDate }</td>
				    </tr>
				    <tr>
				      	<td>${elecApp.aplDetailList[1].employee.job.jobNm}<br>${elecApp.aplDetailList[1].employee.empNm }</td>
				      	<td>${elecApp.aplDetailList[1].employee.department.depNm }</td>
				      	<td>${elecApp.aplDetailList[1].appState }</td>
				      	<td>${elecApp.aplDetailList[1].aplDate }</td>
				    </tr>
				    <tr>
				    	<td>${elecApp.aplDetailList[2].employee.job.jobNm}<br>${elecApp.aplDetailList[2].employee.empNm }</td>
				      	<td>${elecApp.aplDetailList[2].employee.department.depNm }</td>
				      	<td>${elecApp.aplDetailList[2].appState }</td>
				      	<td>${elecApp.aplDetailList[2].aplDate }</td>
				    </tr>
				    <tr>
				    	<td>${elecApp.aplDetailList[3].employee.job.jobNm}<br>${elecApp.aplDetailList[3].employee.empNm }</td>
				      	<td>${elecApp.aplDetailList[3].employee.department.depNm }</td>
				      	<td>${elecApp.aplDetailList[3].appState }</td>
				      	<td>${elecApp.aplDetailList[3].aplDate }</td>
				    </tr>
				  </tbody>
				</table>
            </div>
            <div class="mb-3">
              <label class="col-form-label" for="message-text"><span class="fas fa-caret-right"></span> 참조자</label>
              <table class="table">
				  <tbody>
				    <c:forEach items="${elecApp.eleRefList }" var="eleRef" varStatus="vs">
				    	<tr>
				    		<td>${eleRef.jobNm } ${eleRef.empNm }</td>
				    		<td>${eleRef.depNm }</td>
				    	</tr>
				    </c:forEach>
				  </tbody>
				</table>
            </div>
        </div>
      </div>
      <div class="modal-footer">
<!--         <button class="btn btn-outline-secondary me-1 mb-1" type="button" data-bs-dismiss="modal">닫기</button> -->
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="appCheckModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
    <div class="modal-content position-relative">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1">
        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-0">
      	<div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
          <h4 class="mb-1" id="modalExampleDemoLabel"><span class="fas fa-caret-right"></span> 승인</h4>
        </div>
        <div class="p-4 pb-0 modal-height">
        	<h5 style="text-align:center;">결재 승인 하시겠습니까?</h5>
        </div>
      </div>
      <div class="modal-footer">
      	<div class="footBtn-wrapper">
	        <div>
		        <button class="btn btn-outline-danger me-1 mb-1" id="app-cancel" data-bs-target="#appCancelModal" data-bs-toggle="modal" type="button">반려</button>
		        <button class="btn btn-outline-primary me-1 mb-1" id="app-apply" type="button">승인</button>
	        </div>
      	</div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="appCancelModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
    <div class="modal-content position-relative">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1">
        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-0">
      	<div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
          <h4 class="mb-1" id="modalExampleDemoLabel"><span class="fas fa-caret-right"></span> 반려사유</h4>
        </div>
        <div class="p-4 pb-0 modal-height text-area">
        	<textarea name="cancelContent" class="form-control" id="cancel-content" rows="5" cols="15"></textarea>
        </div>
      </div>
      <div class="modal-footer">
      	<div class="footBtn-wrapper">
	        <div>
		        <button class="btn btn-outline-danger me-1 mb-1" id="app-cancel-submit" type="button">반려</button>
	        </div>
      	</div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="appRemoveModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
    <div class="modal-content position-relative">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1">
        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-0">
      	<div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
          <h4 class="mb-1" id="modalExampleDemoLabel"><span class="fas fa-caret-right"></span> 기안취소</h4>
        </div>
        <div class="p-4 pb-0 modal-height">
        	<h5 style="text-align:center;">상신한 기안을 삭제하시겠습니까?</h5>
        </div>
      </div>
      <div class="modal-footer">
      	<div class="footBtn-wrapper">
	        <div>
		        <button class="btn btn-outline-danger me-1 mb-1" id="app-remove-submit" type="button">삭제</button>
	        </div>
      	</div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" defer="defer">
	
	let appLineSignArea = $(".appLine-signArea");
	let aplForm = $("#aplForm");
	let aplNo = aplForm.find("input[name=aplNo]").val();
	let empId = '${elecApp.empId}';
	let aplState = "";
	let removeState = "";
	let empIdTag = aplForm.find("input[name=empId]");
	
	$.ajax({
		url : "${cPath}/groupware/approval/doc/aplDetailList.do",
		method : "get",
		data : {aplNo:aplNo},
		dataType : "json",
		success : function(resp) {
			console.log(resp);
			let aplDetailList = resp.aplDetail;
			$.each(aplDetailList, function(index, aplDetail){
				console.log(index, aplDetail.aplTurn);
				if(aplDetail.aplTurn == '1' && aplDetail.empId == '${authEmp.empId}'){
					let buttonTag = fn_makeAppButton(aplDetail);
					console.log(buttonTag);
					empIdTag.val(aplDetail.empId);
					$(appLineSignArea[index+1]).html(buttonTag);
				}else if(aplDetail.aplSta == '3'){
					$(appLineSignArea[index+1]).html("반려");
					removeState = '1';
				}else if(aplDetail.aplSta == '1'){
					$(appLineSignArea[index+1]).html(
							$("<img>").attr("src", "data:image/*;base64,"+aplDetail.base64Img )
										.attr("class", "sign-img")
					)
				}else{
					appLineSignArea[index+1].innerHTML = aplDetail.appState;
				}
			})
			
			let check = aplDetailList[0].aplSta;
			if(check == '1'){
				aplState = '1';
			}
			
			let appStatus = resp.appStatus;
			if( appStatus.apsRer != null){
				console.log("아이디가 같노");
				let rerWrapper = $(".rer-wrapper");
				rerWrapper.append(
								$("<table>").attr("class", "table table-bordered")
											.append(
													$("<tbody>").append(
																$("<tr>").append($("<th>").attr("style", "width:19%")
																		.text("반려 사유"))
																		.append(
																			$("<td>").text(appStatus.apsRer)
																		)
																)
													)
											
							);
			}
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});

	fn_makeAppButton = function(aplDetail){
		let buttonTag = $("<button>").attr("class", "btn btn-falcon-default ")
									.attr("data-bs-toggle", "modal")
									.attr("data-bs-target", "#appCheckModal")
									.text("결재");
		return buttonTag;
	}
	
	let cancelSubmitBtn = $("#app-cancel-submit");
	cancelSubmitBtn.on("click", function(){
		let cancelInput = aplForm.find("[name=cancel]");
		let cancelContent = $("#cancel-content").val();
		
		console.log(cancelContent);
		
		cancelInput.val(cancelContent);
		aplForm.submit();
	});
	
	let appApply = $("#app-apply").on("click", function(event){
		aplForm.submit();
	});
	
	
	let mainForm = $("#mainForm").on("submit", function(event){
		event.preventDefault();
	});
	
	let elecCancelBtn = $("#elec-cancel").on("click", function(event){
		event.preventDefault();
		if(aplState == '1' && removeState != '1'){
			toastr.error("이미 결재한 문서는 취소가 불가합니다.");
			return;
		}
		
		let appRemoveModal = $("#appRemoveModal");
		appRemoveModal.modal("show");
		
	});
	
	let removeSubmit = $("#app-remove-submit").on("click", function(){
		delForm.submit();
	});
</script>