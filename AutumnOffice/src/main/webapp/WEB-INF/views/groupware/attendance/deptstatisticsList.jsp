<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
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
.col-auto{
	font-weight: bold;
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
</style>

<div class="card">
	<!-- -------------------------- -->
	<!--    	 현재 근무상태      	    -->
	<!-- -------------------------- -->
	<div style="text-align: right;color:#C0C0C0;font-size: 14px" class="workInfo">
	</div>

	<!-- 메뉴 명 -->
	<h3 style="font-weight: bold;font-size: 30px"><span class="fas fa-business-time"></span>&nbsp;부서 근태 통계</h3>
	<hr>
	<br> <br>
	
	<!-- -------------------------- -->
	<!--    	오늘 날짜 띄우기      	    -->
	<!-- -------------------------- -->
	<div id="period" style="font-weight: bold">
			&nbsp;&nbsp;&nbsp;
			<c:set var="now" value="<%=new java.util.Date()%>" />
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />
			&nbsp;&nbsp;&nbsp;
	</div>
	<br>
	
	<!-- -------------------------- -->
	<!--     부서 근태 통계   	   		 -->
	<!-- -------------------------- -->
	<div style="text-align: center" class="border p-card rounded">
		<div class="row g-5 justify-content-center">
			<div  class="col-auto">
				<div>지각</div>
				<div id="late"></div>
			</div>
			<div  class="col-auto">
				<div>휴가</div>
				<div id="vac"></div>
			</div>
			<div  class="col-auto">
				<div>연차</div>
				<div id="lve"></div>
			</div>
			<div  class="col-auto">
				<div>출장</div>
				<div id="trip"></div>
			</div>
			<div  class="col-auto">
				<div>결근</div>
				<div id="non"></div>
			</div>
		</div>
	</div>

	<br>
	<br>
	<br>
	<!-- --------------------------------- -->
	<!-- 부서원별 근태 현황(출근/퇴근/연차/휴가/출장) -->
	<!-- --------------------------------- -->
	<table class="table">
		<thead>
			<tr>
				<th scope="col">No</th>
				<th scope="col">부서원</th>
				<th scope="col">부서명</th>
				<th scope="col">날짜</th>
				<th scope="col">출근</th>
				<th scope="col">퇴근</th>
				<th scope="col">휴가</th>
				<th scope="col">연차</th>
				<th scope="col">출장</th>
			</tr>
		</thead>
		<tbody id="listBody">
		</tbody>
	</table>
	
	<br>
	<div class="pagingArea"></div>
	<br>
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-select form-select-sm">
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
			<input type="button" value="검색" id="searchBtn" style="font-weight: bold"
				class="btn btn-outline-secondary me-1 mb-1"
			/>
		</div>
	</div>
	<br>

	<form id="searchForm">
		<input type="hidden" name="page" />
		<input type="hidden" name="searchType" />
		<input type="hidden" name="searchWord" />
	</form>

</div>

<script>
	let late = $("#late");
	let vac = $("#vac");
	let lve = $("#lve");
	let trip = $("#trip");
	let non = $("#non");

	//========================================================
	// 부서 근태 통계 (휴가자 수, 출장자 수 ..)
	//========================================================
	$.ajax({
		url : "${cPath}/groupware/attendance/dept/statistics/deptStatisticsAll.do",
		dataType : "JSON",
		success : function(resultVO) {
			late.html(resultVO.lateRes);
			vac.html(resultVO.vacRes);
			lve.html(resultVO.recRes);
			trip.html(resultVO.trpRes);
			non.html(resultVO.noRes);				
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	})
	
	//========================================================
	// 부서원 근태 현황 (연차/휴가/출근/퇴근/출장)
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
	let makeTrTag = function(deptStatus){

		let tr;
		
		if(deptStatus.staRes == 'G'){
			tr = $("<tr>").css('background-color', '#FFE4E1');
			tr.append(
				$("<td>").html(deptStatus.rnum)
				, $("<td>").html(deptStatus.empNm+"&nbsp;"+deptStatus.jobNm)
				, $("<td>").html(deptStatus.depNm)
				, $("<td>").html(deptStatus.staInd)
				, $("<td>").html("(미등록)&nbsp;[결근]")
				, $("<td>").html(deptStatus.staOft)
				, $("<td>").html(deptStatus.vacCat)
				, $("<td>").html(deptStatus.staRec)
				, $("<td>").html(deptStatus.bstTrp)
			);
			
		}else if(deptStatus.staRes == 'C'){
			tr = $("<tr>").css('background-color', '#FFE4E1');
			tr.append(
				$("<td>").html(deptStatus.rnum)
				, $("<td>").html(deptStatus.empNm+"&nbsp;"+deptStatus.jobNm)
				, $("<td>").html(deptStatus.depNm)
				, $("<td>").html(deptStatus.staInd)
				, $("<td>").html(deptStatus.staOnt+"&nbsp;[지각]")
				, $("<td>").html(deptStatus.staOft)
				, $("<td>").html(deptStatus.vacCat)
				, $("<td>").html(deptStatus.staRec)
				, $("<td>").html(deptStatus.bstTrp)
			);
			
		}else{
			tr = $("<tr>");
			tr.append(
				$("<td>").html(deptStatus.rnum)
				, $("<td>").html(deptStatus.empNm+"&nbsp;"+deptStatus.jobNm)
				, $("<td>").html(deptStatus.depNm)
				, $("<td>").html(deptStatus.staInd)
				, $("<td>").html(deptStatus.staOnt)
				, $("<td>").html(deptStatus.staOft)
				, $("<td>").html(deptStatus.vacCat)
				, $("<td>").html(deptStatus.staRec)
				, $("<td>").html(deptStatus.bstTrp)
			);
			
			
		}
		
		return tr;
	}
	
	let searchForm = $("#searchForm").on("submit", function(event){
		event.preventDefault();
		let data = $(this).serialize();
		$.ajax({
			url : "${cPath}/groupware/attendance/dept/statistics/deptStatisticsList.do",
			data : data,
			dataType : "json",
			success : function(pagingVO) {
				listBody.empty();
				pagingArea.empty();
				pageTag.val("");
				let depStatisticList = pagingVO.dataList;
				let trTags = [];
				if(depStatisticList.length > 0){
					$.each(depStatisticList, function(index, deptStatus){
						let tr = makeTrTag(deptStatus);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "9")
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