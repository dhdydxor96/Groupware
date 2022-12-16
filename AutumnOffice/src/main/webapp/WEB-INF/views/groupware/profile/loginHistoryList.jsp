<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
table {
	margin-left: auto;
	margin-right: auto;
	border: 1px solid gray;
	border-collapse: collapse;
}

td {
	padding: 15px;
	padding-left: 30px;
	padding-right: 30px;
}

a {
	color: black;
	text-decoration: none;
}
.card{
	padding:1%; 
	text-align:center; 
	font-family: 'IBM Plex Sans KR', sans-serif;
}
h3{
	font-family: 'IBM Plex Sans KR', sans-serif; 
	text-align:left; 
	font-weight:bold; 
	float:left; 
	font-size:30px;
}
</style>

<div class="card mb-3">
	<br>
	<h3><span class="far fa-edit"></span>&nbsp;로그인 기록</h3>
	<hr>

	<div class="table-responsive scrollbar">
		<table class="table table-hover overflow-hidden">
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">로그인 일시</th>
					<th scope="col">로그인 IP</th>
					<th scope="col">로그인 위치</th>
				</tr>
			</thead>
			<tbody id="loginInfoBody">
				
			</tbody>
		</table>
	</div>
	<br>
	
	<!-- 페이징 처리 -->
	<div class="pagingArea"></div>
	<br>
	
	<!-- 검색 용 -->
	<form id="searchForm">
		<input type="hidden" name="page" />
		<input type="hidden" name="startDay" />
		<input type="hidden" name="endDay" />
	</form>
	
	<div id="searchUI"  class="row g-2 justify-content-center" >
			<div class="col-auto">
				<input type="date" class="form-control" name="startDay" id="startDay" />  
			</div>
			<div class="col-auto">
				~
			</div>
			<div class="col-auto">
				<input type="date" class="form-control" name="endDay" id="endDay"/>
			</div>
			<div class="col-auto">
				<input type="button" id="searchBtn" class="btn btn-outline-secondary me-1 mb-1"
			style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold" value="검색">
			</div>
		</div> 

	<br>
</div>




<script>
	//=================================
	// 검색 처리
	//=================================
	let searchUI = $("#searchUI").on("click", "#searchBtn", function(event){
		
		searchForm.find('[name=startDay]').val($("#startDay").val());
		searchForm.find('[name=endDay]').val($("#endDay").val());
		
		searchForm.submit();
	});
	
	let statistics = $("#statistics");
	let loginInfoBody = $("#loginInfoBody");
	let pageTag = $("[name=page]");
	
	//=================================
	// 페이징 처리
	//=================================
	let pagingArea = $(".pagingArea").on("click", "a", function(event){
		event.preventDefault();
		let page = $(this).data("page");
		if(!page) return false;
		pageTag.val(page);
		searchForm.submit();
		return false;
	});
	
	//=================================
	// 비동기 처리 (tr태그 생성)
	//=================================
	let makeTrTag = function(index, logVO){
		
		console.log(logVO);
		
		let tr = $("<tr class='align-middle'>");
		tr.append(
			$("<td>").html(logVO.rnum)
			, $("<td>").html(logVO.logDt)
			, $("<td>").html(logVO.logIp)
			, $("<td>").html("대한민국")
		);
		
		return tr;
	}
	
	//=================================
	// AJAX 비동기 처리
	//=================================
	let searchForm = $("#searchForm").on("submit", function(event){
		event.preventDefault();
		let data = $(this).serialize();
		
		console.log(data);
		
			$.ajax({
				url : "${cPath}/groupware/profile/loginHistoryList.do",
				data : data,
				method : "post",
				dataType : "JSON",
				success : function(pagingVO) {
					loginInfoBody.empty();
					pagingArea.empty();
					pageTag.val("");
					let logList = pagingVO.dataList;
					
					let trTags = [];
					if(logList.length > 0){
						$.each(logList, function(index, logVO){
							let tr = makeTrTag(index, logVO);
							trTags.push(tr);
						});
					}else{
						let tr = $("<tr>").html(
							$("<td>").attr("colspan", "6")
									 .html("조건에 맞는 게시글이 없음.")
						);
						trTags.push(tr);
					}
					loginInfoBody.append(trTags);
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