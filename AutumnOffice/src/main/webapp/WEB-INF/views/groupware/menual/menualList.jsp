<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<c:set var="menualList" value="${pagingVO.dataList }" />
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
select{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>
<div class="card md-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif;">
<br>
<h3 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left; font-size: 30px;"><span class="fas fa-list-alt"></span>&nbsp;매뉴얼/규정 조회</h3>
<hr>
<br>
<table class="table table-hover" style="width: 100%;">
	<thead class="">
		<tr>
			<th style="font-size : 15px;">번호</th>
			<th style="font-size : 15px;">제목</th>
			<th style="font-size : 15px;">작성자</th>
			<th style="font-size : 15px;">작성일</th>
		</tr>
	</thead>
	<tbody id="listBody">
	</tbody>
</table>
<br>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>
<div class="pagingArea">
</div>
<br>
<!-- (제목-title, 작성자-writer, 내용-content, 전체) -->
<div id="searchUI" class="row g-3 justify-content-center">
	<div class="col-auto">
		<select name="searchType" class="form-select">
			<option value>전체</option>
			<option value="title" 
			>제목</option>
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
			style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; "
		/>
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
	
	let makeTrTag = function(rule){
		let tr = $("<tr>");
		let aTag = $("<a style='font-size:15px; font-family: 'IBM Plex Sans KR', sans-serif;'>").attr("href", "${pageContext.request.contextPath}/groupware/menual/menualView.do?what="+rule.rulNo)
							.text(rule.rulTit);
		tr.append(
			$("<td style='font-size:15px;'>").html(rule.rnum)
			, $("<td style='font-size:15px;'>").html(aTag)
			, $("<td style='font-size:15px;'>").html("관리자")
			, $("<td style='font-size:15px;'>").html(rule.rulDate)
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
				let menualList = pagingVO.dataList;
				let trTags = [];
				if(menualList.length > 0){
					$.each(menualList, function(index, rule){
						let tr = makeTrTag(rule);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "6")
								 .html("조건에 맞는 게시글이 없음.")
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