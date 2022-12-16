<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<c:set var="loginTrackingList" value="${pagingVO.dataList }"/>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center; ">
	<br>
	<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; font-size:30px; text-align:left; font-weight:bold;"><span class="fas fa-caret-right"></span>&nbsp;로그인 기록확인</h1>
	<hr>
	<span style="text-align: left;">임직원의 로그인 내역을 관리합니다.</span>
	<br>
	<table class="table table-hover">
		<thead class="">
			<tr>
				<th>순번</th>
				<th>사원ID</th>
				<th>이름</th>
				<th>부서</th>
				<th>직위</th>
				<th>로그인 IP</th>
				<th>로그인 시간</th>
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
	<div class="pagingArea"></div>
	<br>
	<!-- (제목-title, 작성자-writer, 내용-content, 전체) -->
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-control">
				<option value="">전체</option>
				<option value="title" 
				>사원이름</option>
				<option value="writer" 
				>부서명</option>
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
			style="font-family: 'IBM Plex Sans KR', sans-serif;"/>
		</div>
	</div> 
</div>
<br>
<script type="text/javascript">
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
	
	let makeTrTag = function(loginTrackingList){
		let tr = $("<tr>");
		tr.append(
			$("<td>").html(loginTrackingList.rnum)
			, $("<td>").html(loginTrackingList.empId)
			, $("<td>").html(loginTrackingList.empNm)
			, $("<td>").html(loginTrackingList.depNm)
			, $("<td>").html(loginTrackingList.jobNm)
			, $("<td>").html(loginTrackingList.logIp)
			, $("<td>").html(loginTrackingList.logDt)
		);
		
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
				console.log("pagingVO {}",pagingVO)
				pagingArea.empty();
				pageTag.val("");
				let loginTrackingList = pagingVO.dataList;
				let trTags = [];
				if(loginTrackingList.length > 0){
					$.each(loginTrackingList, function(index, loginTrackingList){
						let tr = makeTrTag(loginTrackingList);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td style='font-size:15px; font-weight:bold;'>").attr("colspan", "7")
								 .html("로그인 기록이 없습니다.")
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
</script>