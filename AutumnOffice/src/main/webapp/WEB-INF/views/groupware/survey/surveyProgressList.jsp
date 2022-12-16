<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %> 
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
.swal-footer{
	text-align:center;
}
</style>
<c:set var="surveyProgressList" value="${pagingVO.dataList }"/>
<!-- 시큐리티 설정 -->
	<security:authorize access="isAuthenticated()">
				<security:authentication property="principal" var="principal"/>
	</security:authorize>
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
<h3 style="font-family: 'IBM Plex Sans KR', sans-serif; font-size:30px; font-weight:bold; float:left;"><span class="fas fa-chart-pie"></span>&nbsp;진행중인 설문 조사 목록</h3>
<hr>
<br>
<table class="table table-hover" style="width: 100%; vertical-align: middle;">
	<thead>
		<tr>
			<th style="font-size : 15px;">번호</th>
			<th style="font-size : 15px;">설문 제목</th>
			<th style="font-size : 15px;">설문조사 타입</th>
			<th style="font-size : 15px;">설문 시작일</th>
			<th style="font-size : 15px;">설문 마감일</th>
			<th style="font-size : 15px;">작성자</th>
			<th style="font-size : 15px;">설문 응답하기</th>
			<th style="font-size : 15px;">설문 결과보기</th>
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
	let empId =  "${principal.realUser.empId}";
	
	let makeTrTag = function(surveyInvestigation){
		let aRTag = $("<a>").attr("href", "${pageContext.request.contextPath}/groupware/survey/surveyResponseInsert.do?what="+surveyInvestigation.surinvNo+"&empId="+ surveyInvestigation.empId)
		.text("응답하기");
		let aRrTag = $("<a>").attr("href", "${pageContext.request.contextPath}/groupware/survey/surveyProgressResponseChart.do?what="+surveyInvestigation.surinvNo)
		.text("객관식 결과보기");
		let aRRTag = $("<a>").attr("href", "${pageContext.request.contextPath}/groupware/survey/surveyProgressEssayResponseChart.do?what="+surveyInvestigation.surinvNo)
		.text("주관식 결과보기");
		
		let trTag = $("<tr>")
			.append($("<td style='font-size:15px;'>").text(surveyInvestigation.rnum))
			.append($("<td style='font-size:15px;'>").text(surveyInvestigation.surTitle))
			.append($("<td style='font-size:15px;'>").text(surveyInvestigation.surinvType))
			.append($("<td style='font-size:15px;'>").text(surveyInvestigation.surSdate))
			.append($("<td style='font-size:15px;'>").text(surveyInvestigation.surEdate))
			.append($("<td style='font-size:15px;'>").text(surveyInvestigation.empNm))
			.append($("<td style='font-size:15px;'>").html(aRTag))
			if(surveyInvestigation.surinvType == '객관식'){
				trTag.append($("<td style='font-size:15px;'>").html(aRrTag))
			}else if(surveyInvestigation.surinvType == '주관식'){
				trTag.append($("<td style='font-size:15px;'>").html(aRRTag))
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
						$("<td>").attr("colspan", "8")
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

<c:if test="${not empty resultmsg}">
<script>
	message = $("#resultmsg").val();
	swal("잘못된 접근입니다.", message, "error");
		  
</script>
</c:if>
