<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %> 
<c:set var="appFormList" value="${pagingVO.dataList }"/>
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
	<h3 style=" font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left; font-size:30px;"><span class="fas fa-caret-right"></span>&nbsp;전자결재 양식 목록</h3>
	<a class="btn btn-outline-primary me-1 mb-1" href="<c:url value='/management/menu/appFormInsert.do'/>"style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:right; width:15%;">전자결재 양식 등록</a>
</div>
<hr>
<br>
<table class="table table-hover" style="width: 100%; vertical-align: middle;">
	<thead>
		<tr>
			<th style="font-size : 15px;">번호</th>
			<th style="font-size : 15px;">전자결재 양식명</th>
			<th style="font-size : 15px;">전자결재 종류</th>
			<th style="font-size : 15px;">양식 삭제</th>
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
			<select name="searchType" class="form-control">
				<option value style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">전체</option>
				<option value="title" 
				style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">전자결재 양식명</option>
				<option value="writer"
				style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">전자결재 종류</option>
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
	<br>
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
	
	let makeTrTag = function(appForm){
		let tr = $("<tr>");
		let aTag = $("<a style='font-size:15px; font-family: 'IBM Plex Sans KR', sans-serif;'>").attr("href", "${pageContext.request.contextPath}/management/menu/appFormDelete.do?what="+appForm.apfNo)
							.text('양식 삭제');
		tr.append(
			$("<td style='font-size:15px;'>").html(appForm.rnum)
			, $("<td style='font-size:15px;'>").html(appForm.apfNm)
			, $("<td style='font-size:15px;'>").html(appForm.apfCat)
			, $("<td style='font-size:15px;'>").html(aTag)
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
				pagingArea.empty();
				pageTag.val("");
				let appFormList = pagingVO.dataList;
				let trTags = [];
				if(appFormList.length > 0){
					$.each(appFormList, function(index, appForm){
						let tr = makeTrTag(appForm);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "4")
								 .html("조건에 맞는 전자결재 양식이 없음.")
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
