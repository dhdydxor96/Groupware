<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<c:set var="noticeList" value="${pagingVO.dataList }"/>
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
	text-align : center;
}	
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}	
</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif;">
<br>
<div>
<h3 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left;font-size: 30px"><span class="fas fa-volume-up"></span>&nbsp;공지사항</h3>
</div>
<hr>
<br>
	<table class="table table-hover">
		<thead>
			<tr>
				<th >번호</th>
				<th >제목</th>
				<th >날짜</th>
				<th >조회수</th>
			</tr>
		</thead>
		<tbody id="listBody">
		</tbody>	
	</table>
	<br>
		<div class="pagingArea">
		</div>
	<br>
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-select addrSelector">
				<option value="">전체</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="date">날짜</option>
			</select>
		</div>
		<div class="col-auto">
			<input type="text" name="searchWord" placeholder="검색키워드"
				class="form-control" value=""/>
		</div>
		<div class="col-auto">
		 	<input type="button" class="btn btn-outline-secondary me-1 mb-1" value="검색" id="searchBtn" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">
		</div>
	</div>
</div>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>
<script	src='<%=request.getContextPath()%>/resources/js/jquery-3.6.0.min.js?<%=System.currentTimeMillis()%>'></script>
<script>
	let searchUI = $("#searchUI").on("click", "#searchBtn", function(event) {
		let inputTags = searchUI.find(":input[name]");
		$.each(inputTags, function(index, inputTag) {
			let name = $(this).attr("name")
			let value = $(this).val()
			searchForm.get(0)[name].value = value;
		
			console.log("name:", name);
			console.log("value:", value);
		})
		
		console.log("searchUI:" , searchUI);
		console.log("inputTags:" , inputTags);
		
		searchForm.submit();
	});
	let pageTag = $("[name=page]");
	let listBody = $("#listBody");
	let pagingArea = $(".pagingArea").on("click", "a", function(event) {
		event.preventDefault();
		let page = $(this).data("page");
		if (!page)	return false;
		pageTag.val(page);

		console.log("pageTag:" + pageTag);
		console.log("listBody:" + listBody);
		console.log("page:" + page);
		
		searchForm.submit();
		return false;
	});
	let makeBoard = function(notice) {
		let viewURL = "${cPath}/groupware/board/noticeView.do?what="+notice.nocNo;
		let trTag = $("<tr>").append(
					$("<td>").html(notice.rnum)
				,	$("<td>").html(
													$("<a>").attr("href", viewURL)
															.text(notice.nocTit)
													)
				,	$("<td>").html(notice.nocDate)
				,	$("<td>").html(notice.nocVie)
				,	$("<td>").html(notice['nocNo']).attr("hidden", "hidden")
			)
		return trTag;
	}
	let searchForm = $("#searchForm").on("submit",	function(event) {
				event.preventDefault();
				let url = this.action;
				let method = this.method;
				let data = $(this).serialize();
				
				console.log("url : " , url);
				console.log("data : " , data);
				
				$.ajax({
					url : url,
					method : method,
					data : data,
					dataType : "json",
					success : function(pagingVO) {
						
						console.log("pagingVO : " , pagingVO);
						console.log("pagingVO.dataList : " ,  pagingVO.dataList);
						
						listBody.empty();
						pagingArea.empty();
						pageTag.val("");
						let noticeList = pagingVO.dataList;
						let boards= [];
						if (noticeList.length > 0) {
							$.each(noticeList, function(index, notice) {
								let tr = makeBoard(notice);
								boards.push(tr);
							});
						}else {
							let tr = $("<tr>").html(
									$("<td>").attr("colspan", "4").html("등록된 공지사항이 없습니다."));
							boards.push(tr);
						}
						listBody.append(boards);
						let pagingHTML = pagingVO.pagingHTML;
						pagingArea.html(pagingHTML);
					},
					error : function(errorResp) {
						console.log(errorResp.status);
					}
				});
				return false;
			}).submit();
	
	$('.addrSelector').on("change", function() {
		 $(".addrSearch").val("");
		let state = $('.addrSelector option:selected').val();
		if (state == 'date') {
			$('.addrSearch').prop("type", "date");
		} else {
			$('.addrSearch').prop("type", "text");
		}
	});
	
</script>
<style>
	.setInline{
		display: inline-block;
	}
</style>