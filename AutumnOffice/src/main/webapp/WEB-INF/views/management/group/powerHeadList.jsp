<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>    
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<c:set var="powerList" value="${pagingVO.dataList }"/>
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
<c:url value="/management/group/employee/powerHeadDelete.do" var="deleteURL">
	<c:param name="what" value="${power.powNo }"/>
</c:url>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center;">
<br>
<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; font-size:30px; text-align:left; font-weight:bold;"><span class="fas fa-caret-right"></span>&nbsp;부서장 목록</h1>
<hr>
<span style="text-align: left;">부서장 권한이 부여된 사원을 관리합니다.</span>
<br>
<table class="table table-hover">
	<thead class="">
		<tr>
			<th>번호</th>
			<th>사원명</th>
			<th>부서명</th>
			<th>직위명</th>	
			<th>권한 삭제</th>		
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
	<form>
		<input type="hidden" value = "${resultmsg}" id="resultmsg">
	</form>
	<div class="pagingArea">
	</div>
	<!-- (제목-title, 작성자-writer, 내용-content, 전체) -->
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-control">
				<option value>전체</option>
				<option value="title" 
				>부서명</option>
				<option value="writer"
				>직위명</option>
				<option value="content"
				>사원명</option>
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
			style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;"/>
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
	
	let makeTrTag = function(power){
		let tr = $("<tr>");
		let aRTag = $("<a style='font-weight:bold; font-family: 'IBM Plex Sans KR', sans-serif;'>").attr("href", "${pageContext.request.contextPath}/management/group/employee/powerHeadDelete.do?what="+power.powNo)
		.text("권한 삭제");
		
		tr.append(
			$("<td>").html(power.rnum)
			, $("<td>").html(power.employee.empNm)
			, $("<td>").html(power.department.depNm)
			, $("<td>").html(power.job.jobNm)
			, $("<td>").html(aRTag)
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
				console.log(pagingVO);
				listBody.empty();
				pagingArea.empty();
				pageTag.val("");
				let powerList = pagingVO.dataList;
				let trTags = [];
				if(powerList.length > 0){
					$.each(powerList, function(index, power){
						let tr = makeTrTag(power);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "6")
								 .html("부서장이 없습니다. 부서장 권한을 추가하셔야 합니다.")
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
<c:if test="${not empty resultmsg}">
<script>
	message = $("#resultmsg").val();

	alert(message);
</script>
</c:if>