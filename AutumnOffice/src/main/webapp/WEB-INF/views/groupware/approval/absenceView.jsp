<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.setting-content-wrapper{
/* 	border-top:1px solid #BDBDBD; */
/* 	border-bottom:1px solid #BDBDBD; */
	margin-top:15px;
	margin-bottom:15px;
	height:500px;
}
.setting-wrapper{
	padding:15px;
}
.setting-header-wrapper{
	margin-top:15px;
}
.btn-apply{
	float:right;
}
.absenceBtn-box{
	float: right;
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
h3{
	font-size: 30px;
	font-weight: bold
}
.btn{
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-weight: bold;
}
#proxy-list{
	table-layout: fixed;
	text-align: center;
}
.check-area{
	width:80px;
}
.modal-height{
	height:90px;
}
</style>
    
<div class="card mb-3 setting-wrapper">
	<br>
	<h3 style=" font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left; font-size:30px;"><span class="fas fa-tools"></span>&nbsp;전자 결재 환경 설정</h3>
	<hr>
	<div class="setting-header-wrapper">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<a class="nav-link  px-2 px-md-3nav-link px-2 px-md-3" id="all"  href="${cPath }/groupware/approval/setting/signUpdate.do" >
					서명설정
				</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link active px-2 px-md-3" id="progress"  href="${cPath }/groupware/approval/setting/absenceHome.do" tabindex="-1">
					부재/위임 설정
				</a>
			</li>
	    </ul>
		<div class="setting-content-wrapper">
			<div class="absenceBtn-box" >
				<a class="btn btn-outline-primary me-1 mb-1" href="${cPath }/groupware/approval/setting/absenceInsert.do">부재 등록</a>
				<button class="btn btn-outline-primary me-1 mb-1" id="remove" data-bs-target="#cancelModal" data-bs-toggle="modal">삭제</button>
			</div>
			<br>
			<br>
			<form>
				<table class="table table-hover" id="proxy-list">
					<thead>
						<tr>
							<th class="check-area"><input type="checkbox" class="form-check-input" id="all-check"></th>
							<th>부재 시작</th>
							<th>부재 종료</th>
							<th>대결자</th>
							<th>부재 사유</th>
							<th>사용 여부</th>
						</tr>
					</thead>
					<tbody class="proxy-area">
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<div class="setting-footer-wrapper">
	</div>
</div>

<div class="modal fade" id="cancelModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
    <div class="modal-content position-relative">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1">
        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-0">
      	<div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
          <h4 class="mb-1" id="modalExampleDemoLabel"><span class="fas fa-caret-right"></span> 대결자 삭제</h4>
        </div>
        <div class="p-4 pb-0 modal-height">
        	<h5 style="text-align:center;">선택한 부재 설정을 삭제하시겠습니까?</h5>
        </div>
      </div>
      <div class="modal-footer">
      	<div class="footBtn-wrapper">
	        <div>
		        <button class="btn btn-outline-danger me-1 mb-1" id="proxy-remove-submit" type="button">삭제</button>
	        </div>
      	</div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript" defer="defer">

let proxyArea = $(".proxy-area");
!function(){
	ajaxList();
}();

function ajaxList(){
	$.ajax({
		url : "${cPath}/groupware/approval/setting/absenceHome.do",
		method : "get",
		dataType : "json",
		success : function(resp) {
			console.log("list 출력 : ",resp);
			let trTags = [];
			if(resp.length > 0){
				$.each(resp, function(index, data){
					let trTag = makeTrTag(data);
					trTags.push(trTag);
				});
				proxyArea.append(trTags);
			}else{
				let trTag = $("<tr>").append($("<td>").attr("colspan", "6").text("부재 목록에 등록된 부재가 없습니다."));
				proxyArea.append(trTag);
			}
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
}

let makeTrTag = function(data){
	let use = data.eldUse ? "사용" : "";
	console.log(use);
	let trTag = $("<tr>").attr("class", "absenceTr")
				.append( $("<td>").append($("<input>").attr("name", "empProxy").attr("type", "checkbox").attr("value", data.eldNo).attr("class", "form-check-input") ) )
				.append( $("<td>").text(data.eldStart) )
				.append( $("<td>").text(data.eldEnd) )
				.append( $("<td>").text(data.jobNm +" "+ data.empNm) )
				.append( $("<td>").text(data.eldRes) )
				.append( $("<td>").text(use) );
	
	return trTag;
}

let allCheck = $("#all-check");
allCheck.change(function(){
	let boxs = proxyArea.find("[name=empProxy]");
    if(allCheck.is(":checked")){
        for(let i=0;i<boxs.length;i++){
        	$(boxs[i]).prop("checked", true);
        }
    }else{
    	for(let i=0;i<boxs.length;i++){
        	$(boxs[i]).prop("checked", false);
        }
    }
});

let cancelModal = $("#cancelModal");
let removeSubmit = $("#proxy-remove-submit");
removeSubmit.on("click", function(){
	let boxs = proxyArea.find("[name=empProxy]");
	let empProxys = [];
	boxs.each(function(index){
		if($(this).is(":checked")==true){
	    	empProxys.push($(this).val());
		}
	});
	
	$.ajax({
		url : "${cPath}/groupware/approval/setting/appProxyDelete.do",
		method : "post",
		data : {"empProxys": empProxys},
		dataType : "json",
		success : function(resp) {
			proxyArea.empty();
			ajaxList();
			cancelModal.modal("hide");
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
});
</script>