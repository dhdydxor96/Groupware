<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>    
<c:set var="surveyInvestigationInvestigationList" value="${pagingVO.dataList }"/>
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
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif;">
<br>
<div>
	<h3 style=" font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left; font-size:30px;"><span class="fas fa-chart-pie"></span>&nbsp;설문 조사 목록</h3>
	<a class="btn btn-outline-primary me-1 mb-1" href="<c:url value='/groupware/survey/surveyInvestigationInsert.do'/>"style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:right; width:15%;">설문 조사 등록</a>
</div>
<hr>
<br>
<table class="table table-hover" style="width: 100%; vertical-align: middle;">
	<thead>
		<tr>
			<th style="font-size : 15px; width:6%;">번호</th>
			<th style="font-size : 15px; width:6%;">작성자</th>
			<th style="font-size : 15px; width:20%;">설문 제목</th>
			<th style="font-size : 15px; width:40%;">문항 내용</th>
			<th style="font-size : 15px; width:7%;">문항 유형</th>
			<th style="font-size : 15px; width:11%;">설문조사 작성일</th>
			<th style="font-size : 15px;">설문조사 상태</th>
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
	<!-- (제목-title, 작성자-writer, 내용-content, 전체) -->
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-select">
				<option value style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">전체</option>
				<option value="title" 
				style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">설문 제목</option>
				<option value="writer"
				style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">문항 내용</option>
				<option value="content"
				style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">작성자</option>
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
	
	let makeTrTag = function(surveyInvestigation){
		let aTag = $("<a style='font-size:15px; font-family: 'IBM Plex Sans KR', sans-serif;'>").attr("href", "${pageContext.request.contextPath}/groupware/survey/surveyInvestigationView.do?what="+surveyInvestigation.surinvNo).text(surveyInvestigation.surTitle);
		let trTag = $("<tr>")
			.append($("<td style='font-size:15px;'>").text(surveyInvestigation.rnum))
			.append($("<td style='font-size:15px;'>").text(surveyInvestigation.empNm))
			.append($("<td style='font-size:15px;'>").html(aTag))
			.append($("<td style='font-size:15px;'>").text(surveyInvestigation.surqueContent))
			.append($("<td style='font-size:15px;'>").text(surveyInvestigation.surinvType))
			.append( $("<td style='font-size:15px;'>").text(surveyInvestigation.surinvInsdat));
			switch(surveyInvestigation.surState){
			case 0:
			trTag.append( $("<td>").append($("<span>")
			.attr("class", "badge badge-soft-secondary")
			.text("미진행")));
			break;
			case 1:
			trTag.append( $("<td>").append($("<span>")
			.attr("class", "badge badge-soft-primary")
			.text("진행중")));
			break;
			case 2:
			trTag.append( $("<td>").append($("<span>")
			.attr("class", "badge badge-soft-success")
			.text("마감")));
			break;
			}
		return trTag;
	};
	
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
				let surveyInvestigationList = pagingVO.dataList;
				let trTags = [];
				if(surveyInvestigationList.length > 0){
					$.each(surveyInvestigationList, function(index, surveyInvestigation){
						let tr = makeTrTag(surveyInvestigation);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "7")
								 .html("조건에 맞는 설문조사가 없음.")
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
