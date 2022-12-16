<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %> 

<style>
.card{
	padding : 1%;
}

#period{
	text-align: center;
	font-size: 1.5em;
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

<div class="card md-3">
	<!-- 내 접속 상태 -->
	<div style="text-align: right;color:#C0C0C0;font-size: 14px" class="workInfo">
	</div>

	<!-- 메뉴 명 -->
	<h3 style="font-weight: bold;font-size: 30px"><span class="fas fa-business-time"></span>&nbsp;부서 연차 현황</h3>
	<hr>
	<br>
	
	<div id="period" style="font-weight: bold">
		${nowYear}
	</div>
	<br>
	
	<div class="table-responsive scrollbar">
	  <table class="table table-hover table-striped overflow-hidden">
	    <thead>
	      <tr>
	        <th scope="col">No</th>
	        <th scope="col">이름</th>
	        <th scope="col">부서명</th>
	        <th scope="col">입사일</th>
	        <th scope="col">근속연수</th>
	        <th scope="col">총 연차</th>
	        <th scope="col">사용 연차</th>
	        <th scope="col">잔여 연차</th>
	      </tr>
	    </thead>
	    <tbody id="listBody">
	    </tbody>
	  </table>
	  <br>
	</div>
  	<form id="searchForm">
		<input type="hidden" name="page" />
		<input type="hidden" name="searchType" />
		<input type="hidden" name="searchWord" />
	</form>
	<div class="pagingArea">
	</div>
	<br>
	<div id="searchUI" class="row g-3 justify-content-center">
	<div class="col-auto">
			<select name="searchType" class="form-select">
				<option value>전체</option>
				<option value="dept" >부서</option>
				<option value="name">이름</option>
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


<script>

	let period = $("#period");
	
	// 페이징 리스트
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
	
	let makeTrTag = function(depAnnual){
		let tr = $("<tr>");
		tr.append(
			$("<td>").html(depAnnual.rnum)
			, $("<td>").html(depAnnual.empNm)
			, $("<td>").html(depAnnual.depNm)
			, $("<td>").html(depAnnual.empHid)
			, $("<td>").html(depAnnual.empYears)
			, $("<td>").html(depAnnual.aulCot )
			, $("<td>").html(depAnnual.aulCot-depAnnual.aulLot )
			, $("<td>").html(depAnnual.aulLot )
		);
		
		return tr;
	}
	
	let searchForm = $("#searchForm").on("submit", function(event){
		event.preventDefault();
		let data = $(this).serialize();
		$.ajax({
			url : "${cPath}/groupware/attendance/dept/annual/deptAnnualList.do",
			data : data,
			dataType : "json",
			success : function(pagingVO) {
				listBody.empty();
				pagingArea.empty();
				pageTag.val("");
				let depAnnualList = pagingVO.dataList;
				let trTags = [];
				if(depAnnualList.length > 0){
					$.each(depAnnualList, function(index, depAnnual){
						let tr = makeTrTag(depAnnual);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "8")
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