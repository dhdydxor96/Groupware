<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.card{
	padding : 1%;
}

table {
	margin-left: auto;
	margin-right: auto;
	border: 1px solid gray;
	border-collapse: collapse;
}

td {
	padding: 15px;
	padding-left: 30px;
	padding-right: 30px;
}
th{
	text-align: center;
}
.attendImage{
	width:100px;
}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
div{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
span{
	font-family: 'IBM Plex Sans KR', sans-serif;
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
</style>

<div class="card">
	<!-- -------------------------- -->
	<!--    	 현재 근무상태      	    -->
	<!-- -------------------------- -->
	<div style="text-align: right;color:#C0C0C0;font-size: 14px" class="workInfo">
	</div>

	<!-- 메뉴 명 -->
	<h3 style="font-weight: bold;font-size: 30px"><span class="fas fa-business-time"></span>&nbsp;부서 인사 정보</h3>
	<hr>
	<br>

	<div style="text-align: left" id="deptCount">
		
	</div>

	<!-- -------------------------- -->
	<!--    	부서 인사정보 확인    	    -->
	<!-- -------------------------- -->
	<table class="table table-hover deptTable" style="text-align: center">
		<thead>
			<tr onclick="event.cancelBubble=true" >
				<th scope="col">No</th>
				<th scope="col">사번</th>
				<th scope="col">부서명</th>
				<th scope="col">이름</th>
				<th scope="col">직위</th>
				<th scope="col">이메일</th>
			</tr>
		</thead>
		<tbody id="listBody">
		</tbody>
	</table>

<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>
<br>
<div class="pagingArea">
</div>
<br>
<!-- 서치UI 사용하는 곳 -->

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
		<input type="button" value="검색" id="searchBtn" class="btn btn-outline-secondary me-1 mb-1"
			style="font-weight: bold"
		/>
	</div>
</div>
</div>
<br>




 
<!-- -------------------------- -->
<!--   부서원의 인사정보 상세 확인 모달     -->
<!-- -------------------------- -->
<div class="modal fade" id="privacy-modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 750px">
    <div class="modal-content position-relative">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1">
        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-0">
        <div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
          <h4 class="mb-1" id="modalExampleDemoLabel"><span class='fas fa-caret-right'></span>&nbsp;인사정보</h4>
        </div>
        <div class="p-4 pb-0">
          	<table class="table table-bordered">
          		<tbody id="modalTbody">
					
          		</tbody>
		</table>
        </div>
      </div>
    </div>
  </div>
</div>


<script>
	
	//========================================================
	// 부서 인사정보 리스트
	//======================================================== 
	let searchUI = $("#searchUI").on("click", "#searchBtn", function(event){
		let inputTags = searchUI.find(":input[name]");
		$.each(inputTags, function(index, inputTag){
			let name = $(this).attr("name");
			let value = $(this).val();
			console.log("검색조건"+name+"검색내용"+value);
			searchForm.get(0)[name].value = value;
		});
		searchForm.submit();
	});
	
	let pageTag = $("[name=page]");
	let deptCount =$("#deptCount");
	let listBody = $("#listBody");
	let modalTbody = $("#modalTbody");
	let deptTableTr = $('deptTable');
	let pagingArea = $(".pagingArea").on("click", "a", function(event){
		event.preventDefault();
		let page = $(this).data("page");
		if(!page) return false;
		pageTag.val(page);
		searchForm.submit();
		return false;
	});
	
	let makeTrTag = function(deptInfo){
		let tr = $("<tr data-bs-toggle='modal' data-bs-target='#privacy-modal' id='"+deptInfo.empId+"' class='checkTr'>");
		tr.append(
			$("<td>").html(deptInfo.rnum)
			, $("<td>").html(deptInfo.empId)
			, $("<td>").html(deptInfo.empNm)
			, $("<td>").html(deptInfo.depNm)
			, $("<td>").html(deptInfo.jobNm)
			, $("<td>").html(deptInfo.empMail)
		);
		
		return tr;
		
	}
	
	let searchForm = $("#searchForm").on("submit", function(event){
		event.preventDefault();
		let method = this.method;
		let data = $(this).serialize();
		$.ajax({
			url : "${cPath}/groupware/attendance/dept/privacy/deptPrivacyList.do",
			method : method,
			data : data,
			dataType : "json",
			success : function(pagingVO) {
				listBody.empty();
				pagingArea.empty();
				pageTag.val("");
				let deptList = pagingVO.dataList;
				let trTags = [];
				if(deptList.length > 0){
					$.each(deptList, function(index, deptInfo){
						let tr = makeTrTag(deptInfo);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "5")
								 .html("조건에 맞는 임직원이 없습니다.")
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
		});
		return false;
	}).submit();
	
	
	//========================================================
	// 부서원이 총 몇 명인지 카운트
	//======================================================== 
	$.ajax({
		url : "${cPath}/groupware/attendance/dept/privacy/deptPrivacyTotalCount.do",
		dataType : "JSON",
		success : function(resp) {
			console.log(resp);
			deptCount.html("<div style='font-weight:bold;margin-bottom:1%'><span class='fas fa-caret-right'></span>&nbsp;전체 "+resp+"명</div>");
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	})
	
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
	
	//========================================================
	// 부서원 클릭 시 모달창이 열리면서 부서원의 인사 정보 상세가 나온다.
	//======================================================== 
	$(document).on('click', '.checkTr', function(event){
	
		let empId = $(this).attr('id');
		
		let makeModalTrTag = function(myInfo){
			let tr = "<tr><td rowspan='3' style='text-align:center'><img src='${cPath}/groupware/attendance/dept/privacy/privacyImageView.do?who="+myInfo.empId+"' class='attendImage' alt='프로필 사진'></td><th>이름</th><th>부서명</th><td>개발팀</td></tr>"+
					 "<tr><td rowspan='2' style='vertical-align:middle;text-align:center'>"+myInfo.empNm+"</td><th>직위</th><td>사원</td></tr>"+
					 "<tr><th>사번</th><td>"+myInfo.empId+"</td></tr>"+
					 "<tr><th>휴대전화</th><td>"+myInfo.empPh+"</td><th>이메일</th><td>"+myInfo.empMail+"</td></tr>"+
					 "<tr><th>생년월일</th><td>"+myInfo.empBid+"</td><th>입사일</th><td>"+myInfo.empHid+"</td></tr>"+
					 "<tr><th>주소</th><td colspan='3'>"+myInfo.empAddr+"</td></tr>"
			
			return tr;
			
		}
		
		$.ajax({
			url : "${cPath}/groupware/attendance/my/privacy/myPrivacyList.do",
			data : { who : empId},
			dataType : "JSON",
			success : function(myInfo) {
				modalTbody.empty();
				let tr = makeModalTrTag(myInfo);
				modalTbody.append(tr);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
		
	})
</script>