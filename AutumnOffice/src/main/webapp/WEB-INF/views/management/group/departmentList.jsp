<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<c:set var="departmentList" value="${pagingVO.dataList }"/>
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
a{
	font-family: 'IBM Plex Sans KR', sans-serif;
}

</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center;">
<br>
<div>
	<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; float:left; font-weight:bold; text-align: left; font-size: 30px;"><span class="fas fa-caret-right"></span>&nbsp;부서 관리</h1>
	<a class="btn btn-outline-primary me-1 mb-1" href="<c:url value='/management/group/department/departmentInsert.do'/>" style="font-family: 'IBM Plex Sans KR', sans-serif; float:right; font-weight:bold; width:15%; ">부서 등록</a>
</div>
<hr>
<span style="text-align: left;">부서를 등록 및 관리합니다.</span>
<br>
<table class="table table-hover" >
	<thead class="">
		<tr>
			<th>번호</th>
			<th>부서명</th>
			<th>부서 책임자</th>
			<th>부서 생성일</th>
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
				<option value>전체</option>
				<option value="title" 
				>부서 코드</option>
				<option value="writer"
				>부서명</option>
				<option value="content"
				>부서 책임자</option>
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
			style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; " />
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
	
	let makeTrTag = function(department){
		let tr = $("<tr>");
		let aTag = $("<a style='font-family: 'IBM Plex Sans KR', sans-serif;' >").attr("href", "${pageContext.request.contextPath}/management/group/department/departmentView.do?what="+department.depId)
							.text(department.depNm);
		tr.append(
			$("<td>").html(department.rnum)
			, $("<td>").html(aTag)
			, $("<td>").html(department.depMag)
			, $("<td>").html(department.depCrd)
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
				let departmentList = pagingVO.dataList;
				let trTags = [];
				if(departmentList.length > 0){
					$.each(departmentList, function(index, department){
						let tr = makeTrTag(department);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td style='font-weight:bold;'>").attr("colspan", "6")
								 .html("부서가 없습니다. 부서를 등록해주시길 바랍니다.")
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