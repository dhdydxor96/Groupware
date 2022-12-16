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
	text-align: center;
}
#period{
	text-align: center;
	font-size: 1.5em;
}
td {
	padding: 15px;
	padding-left: 30px;
	padding-right: 30px;
}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
div{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>

<div class="card md-3">
	<!-- 내 접속 상태 -->
	<div style="text-align: right;color:#C0C0C0;font-size: 14px" class="workInfo">
	</div>

	<!-- 메뉴 명 -->
	<h3 style="font-weight: bold;font-size: 30px"><span class="fas fa-business-time"></span>&nbsp;내 연차 내역</h3>
	<hr>
	<br> 
	
	<div id="period" style="font-weight: bold">
			${nowYear}
	</div>
	<br>

	<!-- 이번주/이번달 연차 내역 통계 -->
		<div style="text-align: center" class="border p-card rounded">
		<div class="row g-5 justify-content-center" id="statistics">
		</div>
	</div>
	

	<br> <br> 

	<br>

	<!-- 연차 사용 내역 -->
	<h4><span class="fas fa-caret-right"></span>&nbsp;사용 내역</h4>
	<hr>
	<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col">No</th>
				<th scope="col">이름</th>
				<th scope="col">부서명</th>
				<th scope="col">연차시작일</th>
				<th scope="col">연차종료일</th>
				<th scope="col">사용연차</th>
			</tr>
		</thead>
		<tbody id="useTbody">
					
		</tbody>
	</table>
	<br>
	<form id="searchForm">
		<input type="hidden" name="page" />
		<input type="hidden" name="startDay" />
		<input type="hidden" name="endDay" />
	</form>
	<div class="pagingArea">
	</div>
	
	<br>

	
	<div id="searchUI"  class="row g-2 justify-content-center" >
			<div class="col-auto">
				<input type="date" class="form-control" name="startDay" id="startDay" />  
			</div>
			<div class="col-auto">
				~
			</div>
			<div class="col-auto">
				<input type="date" class="form-control" name="endDay" id="endDay"/>
			</div>
			<div class="col-auto">
				<input type="button" id="searchBtn" class="btn btn-outline-secondary me-1 mb-1" value="검색"
					style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight: bold"
				>
			</div>
		</div> 

	<br>

</div>

<script>
	//페이징 처리
	let searchUI = $("#searchUI").on("click", "#searchBtn", function(event){
		
		searchForm.find('[name=startDay]').val($("#startDay").val());
		searchForm.find('[name=endDay]').val($("#endDay").val());
		
		searchForm.submit();
	});
	
	let statistics = $("#statistics");
	let useTbody = $("#useTbody");
	let pageTag = $("[name=page]");
	
	let pagingArea = $(".pagingArea").on("click", "a", function(event){
		event.preventDefault();
		let page = $(this).data("page");
		if(!page) return false;
		pageTag.val(page);
		searchForm.submit();
		return false;
	});
	
	let makeTrTag = function(annualUse){
		let tr = $("<tr>");
		
		tr.append(
			$("<td>").html(annualUse.rnum)
			, $("<td>").html(annualUse.empNm)
			, $("<td>").html(annualUse.depNm)
			, $("<td>").html(annualUse.lerStart)
			, $("<td>").html(annualUse.lerEnd)
			, $("<td>").html(annualUse.lerDay)
		);
		
		return tr;
	}

	$.ajax({
		url : "${cPath}/groupware/attendance/my/annual/myAnnualList.do",
		dataType : "json",
		success : function(annual) {
			statistics.empty();
			
			let tr = "<div class='col-auto row-auto'>" +
					 "<div style='padding-top:10%;font-weight:bold'>"+annual.empNm+"&nbsp;&nbsp;&nbsp;"+annual.jobNm+"</div></div>"+
					 "<div  class='col-auto'>"+
					 "<div>총연차수</div><div>"+annual.aulCot+"</div></div>"+
					 "<div  class='col-auto'>"+
					 "<div>사용연차수</div><div>"+annual.aulUse+"</div></div>"+
					 "<div  class='col-auto month'>"+
					 "<div>잔여연차수</div><div>"+annual.aulLot+"</div></div>";
					 
			statistics.html(tr);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	})
		
	let searchForm = $("#searchForm").on("submit", function(event){
		event.preventDefault();
		let data = $(this).serialize();
		
		console.log(data);
		
			$.ajax({
			url : "${cPath}/groupware/attendance/my/annual/myAnnualUseList.do",
			data : data,
			dataType : "json",
			success : function(pagingVO) {
				useTbody.empty();
				pagingArea.empty();
				pageTag.val("");
				let annualUseList = pagingVO.dataList;
				
				let trTags = [];
				if(annualUseList.length > 0){
					$.each(annualUseList, function(index, annualUse){
						let tr = makeTrTag(annualUse);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "6")
								 .html("조건에 맞는 게시글이 없음.")
					);
					trTags.push(tr);
				}
				useTbody.append(trTags);
				let pagingHTML = pagingVO.pagingHTML;
				pagingArea.html(pagingHTML);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
			});
			return false;
		}).submit();

	
	
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