<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<c:set var="adviceList" value="${pagingVO.dataList }" />
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
<br><br><br>
<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold">상담문의 게시판</h1>
<br><br>
<table class="table table-bordered table-strip" style="width: 70%;
    margin-left: 15%;">
	<thead class="table-dark">
		<tr>
			<th style="font-size : 18px;">번호</th>
			<th style="font-size : 18px;">제목</th>
			<th style="font-size : 18px;">작성자</th>
			<th style="font-size : 18px;">작성일</th>
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
		<select name="searchType" class="form-select">
			<option value>전체</option>
			<option value="title" 
			>제목</option>
			<option value="writer"
			>작성자</option>
			<option value="content"
			>내용</option>
		</select>
	</div>
	<div class="col-auto">
		<input type="text" name="searchWord" placeholder="검색키워드"
			class="form-control" value=""
		/>
	</div>
	<div class="col-auto">
		<input type="button" value="검색" id="searchBtn"
			class="btn btn-primary" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold"
		/>
		<a class="btn btn-success" href="<c:url value='/web/advice/adviceInsert.do'/>" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold">상담문의 등록</a>
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
	
	let makeTrTag = function(advice){
		let tr = $("<tr>");
		let aTag = $("<a>").attr("href", "${pageContext.request.contextPath}/web/advice/adviceView.do?what="+advice.advNo)
							.text(advice.advTit);
		tr.append(
			$("<td style='font-size:18px;'>").html(advice.rnum)
			, $("<td style='font-size:18px;'>").html(aTag)
			, $("<td style='font-size:18px;'>").html(advice.advNm)
			, $("<td style='font-size:18px;'>").html(advice.advDate)
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
				let adviceList = pagingVO.dataList;
				let trTags = [];
				if(adviceList.length > 0){
					$.each(adviceList, function(index, advice){
						let tr = makeTrTag(advice);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "6")
								 .html("조건에 맞는 게시글이 없습니다.")
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
