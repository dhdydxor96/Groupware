<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>
	.deptAnnualDate{
		width:150px
	}
	.card{
		padding:1%;
	}
	@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
	input{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	select{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
</style>

<div class="card md-3">
	<!-- 내 접속 상태 -->
	<div style="text-align: right;color:#C0C0C0;font-size: 14px" class="workInfo">
	</div>

	<!-- 메뉴 명 -->
	<h3 style="font-weight: bold;font-size: 30px"><span class="fas fa-business-time"></span>&nbsp;부서 연차 사용 내역</h3>
	<hr>
	<!-- (직위-job, 이름-writer, 전체) -->

	<h5 style="color:#232E3C"><span class="fas fa-caret-right"></span>&nbsp;오늘 연차 사용 대상자</h5>
	<div>
	 <table class="table table-hover table-striped overflow-hidden">
	 	<thead>
	 		<tr>
		 		<th scope="col">No</th>
		 		<th scope="col">이름</th>
		        <th scope="col">부서명</th>
		        <th scope="col">직위</th>
		        <th scope="col">사용일</th>
		        <th scope="col">종료일</th>
		        <th scope="col">사용일수</th>
	 		</tr>
	 	</thead>
	 	<tbody class="today">
	 	</tbody>
	 </table>
	 <br>
	</div>
	<br>
	<br>
	<!-- 연차 사용 내역 조회 -->
	<h5 style="color:#232E3C"><span class="fas fa-caret-right"></span>&nbsp;연차 사용 내역</h5>
	<div >
	  <table class="table table-hover table-striped overflow-hidden">
	    <thead>
	      <tr>
	 		<th scope="col">No</th>
	        <th scope="col">이름</th>
	        <th scope="col">부서명</th>
	        <th scope="col">직위</th>
	        <th scope="col">사용일</th>
	        <th scope="col">종료일</th>
	        <th scope="col">사용일수</th>
	      </tr>
	    </thead>
	    <tbody class="history">
	    </tbody>
	  </table>
	 <br>
	  <div class="pagingArea"></div>
	<br>
 	  <form id="searchForm">
		<input type="hidden" name="page" >
		<input type="hidden" name="searchType" >
		<input type="hidden" name="searchWord" >		
	  </form>
	  <div id="searchUI" class="row g-3 justify-content-center">
			<div class="col-auto">
				<select name="searchType" class="form-select">
					<option value>전체</option>
					<option value="writer">사원이름</option>
					<option value="dept">부서</option>
					<option value="job">직위</option>
					<option value="year">연도</option>
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
	  <br>
	</div>
</div>
<script>
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
	let listBody = $(".history");
	
		let pagingArea = $(".pagingArea").on("click", "a", function(event){
			event.preventDefault();
			let page = $(this).data("page");
			if(!page) return false;
			pageTag.val(page);
			searchForm.submit();
			return false;
		});
		
	
	
	
	let makeTrTag = function(data){
		let tr = $("<tr>");
		tr.append( $("<td>").text(data.rnum) )
		.append( $("<td>").text(data.employee.empNm) )
		.append( $("<td>").text(data.department.depNm) )
		.append( $("<td>").text(data.job.jobNm) )
		.append( $("<td>").text(data.lerStart) )
		.append( $("<td>").text(data.lerEnd) )
		.append( $("<td>").text(data.lerUse) )
	
		
		return tr;
	}
	

	
	let searchForm = $("#searchForm").on("submit", function(event){
		event.preventDefault();
		let url = this.action;
		let method = this.method;
		let data = $(this).serialize();
		$.ajax({
			url : url,
			method : method,
			data : data,
			dataType : "json",
			success : function(pagingVO) {
				listBody.empty();
				pagingArea.empty();
				pageTag.val("");
				let dataList = pagingVO.dataList;
				let trTags = [];
				if(dataList.length > 0){
					$.each(dataList, function(index, depAnHis){
						let tr = makeTrTag(depAnHis);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "7")
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

	
	let today = $(".today");
	$.ajax({
		url : "${cPath}/groupware/attendance/deptAnnualHistoryListToday.do",
		dataType : "JSON",
		success : function(lveRecodeList) {
			let todayTrTags = [];
			 
			console.log(lveRecodeList.length > 0)
			if(lveRecodeList.length > 0){
				$.each(lveRecodeList, function(index, data){
					let trTag = $("<tr>").append( $("<td>").text(index+1) )
						.append( $("<td>").text(data.employee.empNm) )
						.append( $("<td>").text(data.department.depNm) )
						.append( $("<td>").text(data.job.jobNm) )
						.append( $("<td>").text(data.lerStart) )
						.append( $("<td>").text(data.lerEnd) )
						.append( $("<td>").text(data.lerUse) );
						todayTrTags.push(trTag);
				});
			}else{
				let trTag = $("<tr>").append( 
						$("<td>").attr("colspan", "7")
						.html("오늘 연차를 사용하는 임직원이 없습니다.")
				);
				console.log(trTag);
				todayTrTags.push(trTag);
			}
			today.append(todayTrTags);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	})

	//근태 관리 메뉴 상단바 
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