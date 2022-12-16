<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<c:set var="userInfoHistory" value="${pagingVO.dataList }"/>
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
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center;">
<br>
	<h4 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:30px;text-align: left"><span class="fas fa-caret-right"></span>&nbsp;서비스 이용 내역</h4>
<hr>
<div style="text-align: left">기존에 신청했던 그룹웨어 서비스 내역을 확인합니다.</div>
<br>
<br>
<table class="table table-bordered table-strip">
	<thead class="">
		<tr>
			<th>순번</th>
			<th>회사코드</th>
			<th>서비스 명</th>
			<th>사원수</th>
			<th>서비스 시작일</th>
			<th>서비스 종료일</th>
			<th>서비스 구성</th>
			<th>서비스 가격</th>
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
	<div class="pagingArea">
	</div>
	<!-- (제목-title, 작성자-writer, 내용-content, 전체) -->
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-control">
				<option value="">전체</option>
				<option value="title" 
				>연도</option>
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
			style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold"/>
		</div>
	</div>
</div>
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
	
	let makeTrTag = function(userInfoHistory){
		let tr = $("<tr>");
		tr.append(
			$("<td>").html(userInfoHistory.rnum)
			, $("<td>").html(userInfoHistory.comCode)
			, $("<td>").html(userInfoHistory.serName)
			, $("<td>").html(userInfoHistory.serEmp)
			, $("<td>").html(userInfoHistory.serStd)
			, $("<td>").html(userInfoHistory.serEnd)
			, $("<td>").html(userInfoHistory.serPeri)
			, $("<td>").html(userInfoHistory.servicePay.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'))
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
				let userInfoHistory = pagingVO.dataList;
				let trTags = [];
				if(userInfoHistory.length > 0){
					$.each(userInfoHistory, function(index, userInfoHistory){
						let tr = makeTrTag(userInfoHistory);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "6")
								 .html("조건에 맞는 검색이 아님.")
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