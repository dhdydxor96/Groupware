<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>
<c:set var="surveyInvestigation" value="${surveyInvestigation }"/>
<c:set var="surveyResponse" value="${surveyResponse }"/>
<c:set var="surveyResponse2" value="${surveyResponse2 }"/>
<c:set var="survey" value="${survey }"/>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
	font-weight:bold;
}
</style>
<div class="card mb-3" style="padding:5%; font-family: 'IBM Plex Sans KR', sans-serif;">
<h3 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left; font-size:30px;"><span class="fas fa-chart-pie"></span>&nbsp;마감된 주관식 설문 조사 결과 통계</h3>
<hr>
<table class="table table-bordered" style="width: 100%; vertical-align: middle;">
		<tr>
			<th>설문 제목</th>
			<td>${surveyResponse2[0].surTitle}</td>
		</tr>
		<tr>
			<th>설문 목적</th>
			<td>${surveyResponse2[0].surPurpose}</td>
		</tr>	
		<tr>
			<th>설문작성 안내내용</th>
			<td>${surveyResponse2[0].surGuide}</td>
		</tr>
		<tr>
			<th>설문 기간</th>
			<td>${surveyResponse2[0].surSdate} ~ ${surveyResponse2[0].surEdate}</td>
		</tr>
</table>
<br>
<table class="table table-hover" style="width: 100%; vertical-align: middle;">
	<thead>
		<tr>
			<th style="font-size : 15px;">번호</th>
			<th style="font-size : 15px;">작성자</th>
			<th style="font-size : 15px;">응답 내용</th>
		</tr>
	</thead>
	<tbody id="listBody">
	</tbody>
</table>
	<form id="searchForm">
		<input type="hidden" name="page" />
		<input type="hidden" name="surinvNo" value="${surveyResponse[0].surinvNo}" />
		<input type="hidden" name="searchType" />
		<input type="hidden" name="searchWord" />
	</form>
	
	
	<br>
	<div class="pagingArea">
	</div>
	<br>
	<!-- (제목-title, 작성자-writer, 내용-content, 전체) -->
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-select">
				<option value style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">전체</option>
				<option value="title" 
				style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">작성자</option>
				<option value="writer"
				style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">응답 내용</option>
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
	<br><br>
	<a href="${cPath }/groupware/survey/surveyDeadlineList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="margin-left:39%; width:25%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">목록</a>
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
	let listBody = $("#listBody");
	let pagingArea = $(".pagingArea").on("click", "a", function(event){
		event.preventDefault();
		let page = $(this).data("page");
		if(!page) return false;
		pageTag.val(page);
		searchForm.submit();
		return false;
	});
	
	let makeTrTag = function(surveyResponse){
		let trTag = $("<tr>")
			.append($("<td style='font-size:15px;'>").text(surveyResponse.rnum))
			.append($("<td style='font-size:15px;'>").text(surveyResponse.empNm))
			.append($("<td style='font-size:15px;'>").text(surveyResponse.surresEssay))
			
		return trTag;
	};
	
	let searchForm = $("#searchForm").on("submit", function(event){
		event.preventDefault();
		let url = this.action;
		let method = this.method;
		let data = $(this).serialize();
		
		console.log(data);
		$.ajax({
			url : url,
			method : method,
			data : data,
			dataType : "json",
			success : function(pagingVO) {
				listBody.empty();
				pagingArea.empty();
				pageTag.val("");
				let surveyResponseList = pagingVO.dataList;
				let trTags = [];
				if(surveyResponseList.length > 0){
					$.each(surveyResponseList, function(index, surveyResponse){
						let tr = makeTrTag(surveyResponse);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "3")
								 .html("조건에 맞는 응답이 없음.")
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
