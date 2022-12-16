<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="postList" value="${pagingVO.dataList }"/>
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
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif;">
<br>
<div>
	<h3 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left; font-size: 30px;"><span class="fas fa-book-open"></span>&nbsp;커뮤니티</h3>
	<a class="btn btn-outline-primary me-1 mb-1" href="<c:url value='/groupware/board/communicationInsert.do'/>"style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:right; width:15%;">게시글 등록</a>
</div>
<hr>
<br>
	<c:set var="board" value="${post.boardList }"/>
	<form action="choiceTab">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item">
				<a class="nav-link active px-md-3" id="all" data-appstat="all" data-bs-toggle="tab" href="#tab-all" role="tab" aria-controls="tab-all" aria-selected="true">
					전체
				</a>
			</li>
		<c:forEach items="${post.boardList }" var="board" varStatus="vs" >
			<li class="nav-item">
				<a class="nav-link px-2 px-md-3" id="${board.boCode }" data-appstat="0" data-bs-toggle="tab" href="#tab-progress" role="tab" aria-controls="tab-progress" aria-selected="false" tabindex="-1">
					${board.boType}
				</a>
			</li>
		</c:forEach>
    	</ul>
	</form>
	
	<table class="table table-hover" style="width: 100%;">
		<thead>
			<tr>
				<th style="width:10%;">번호</th>
				<th style="width:20%;">게시판</th>
				<th style="width:30%;">제목</th>
				<th style="width:15%;">작성자</th>
				<th style="width:15%;">날짜</th>
				<th style="width:10%;">조회수</th>
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
			<select name="searchType" class="form-select">
				<option value="all">전체</option>
				<option value="writer">작성자</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
		</div>
		<div class="col-auto">
			<input type="text" name="searchWord" placeholder="검색키워드"
				class="form-control" value=""/>
		</div>
		<div class="col-auto">
		 	<input type="button" value="검색" id="searchBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold"/>
		</div>
	</div>
</div>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
	<input type="hidden" name="searchCommunity" />
</form>
<script	src='<%=request.getContextPath()%>/resources/js/jquery-3.6.0.min.js?<%=System.currentTimeMillis()%>'></script>
<script>
	
	//aTag 선언하여 선택한 a태그의 데이터 가져오기
	let aTag = $('.px-md-3')
	$(aTag).on("click", function(){
		
		// 선택한 게시판 코드 선언
		// 게시판이 이동 -> 검색조건 및 검색어 페이징 초기화
		let catchBoCode = $(this).attr('id');
		let url = "${cPath}/groupware/board/selectCommunicationList.do?${_csrf.parameterName}=${_csrf.token}";
		$('[name=searchType]').val('all').trigger('change');
		$('[name=searchWord]').val('');
		$('[name=page]').val('1');
		
		console.log("catchBoCode", catchBoCode)

		//  전체 게시판을 클릭했을 경우 게시판코드, 검색조건, 검색어 페이징 초기화 후 submit
		if(catchBoCode == 'all'){
			$('[name=searchType]').val('all').trigger('change');
			$('[name=searchWord]').val('');
			$('[name=searchCommunity]').val('');
			$('[name=page]').val('1');
			
			searchForm.submit();
		}else{
			// searchUI 하위의 input태그의 이름을 찾기
			let inputTags = searchUI.find(":input[name]");	
			$.each(inputTags, function(index, inputTag) {
				let name = $(this).attr("name")		// 첫번째 반복문 searchType
				let value = $(this).val()			// searchType에서 선택된 옵션 value 값
				
				searchForm.get(0)[name].value = value;	// searchForm에서 첫번째 인덱스 page의 값 설정
				searchForm.find("input")[3].value = catchBoCode	// searchForm에서 네번째 인덱스 searchCommunity의 값 설정
				
				
				console.log("each문 name:", name);
				console.log("each문 value:", value);
				
				searchForm.submit();
			})
		}
	})	//	게시판 클릭했을 때 각 게시물 목록	끝
	
	// 검색버튼 클릭 이벤트	
	let searchUI = $("#searchUI").on("click", "#searchBtn", function(event) {
		let inputTags = searchUI.find(":input[name]");
		$.each(inputTags, function(index, inputTag) {
			let name = $(this).attr("name")
			let value = $(this).val()
			searchForm.get(0)[name].value = value;
		
			console.log("name:"+ name);
			console.log("value:"+ value);
		})
		
		console.log("searchUI:" + searchUI);
		console.log("inputTags:" + inputTags);
		
		searchForm.submit();
	});
	
	let pageTag = $("[name=page]");
	
	// 목록을  비동기로 만들어줄 tbody 선언(append해서 만들어줌)
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
	
	let makeBoard = function(post) {
		let tr = $("<tr>");
		let aTag = $("<a>").attr("href", "${cPath}/groupware/board/communicationView.do?what="+post.poNo).text(post.poTit).attr("class", "setPadding");
		if(post.emp != null){
		/*	let hRnum = $("<h6>").attr("class", "setInline").text(post['rnum'])
			let hiddenPoNo = $("<h6>").attr("class", "setInline").text(post['poNo']).attr("hidden", "hidden");
			let hNm= $("<h6>").attr("class", "setInline").text(post['emp']['empNm']);
			let hboType = $("<h6>").attr("class", "setInline").text(post['boType']);
			let hcrd = $("<h6>").attr("class", "setInline").text(post['poCrd']);
			let hHit = $("<h6>").attr("class", "setInline").text('조회수');
			let hVie = $("<h6>").attr("class", "setInline").text(post['poVie']);	*/
		
			tr.append(
					  $("<td>").html(post['rnum'])
					, $("<td>").html(post['boType'])
					, $("<td>").html(aTag)
					, $("<td>").html(post['emp']['empNm'])
					, $("<td>").html(post['poCrd'])
					, $("<td>").html(post['poVie'])
					, $("<td>").html(post['poNo']).attr("hidden", "hidden")
			)	
		}/* else{
			let hcrd = $("<h6>").attr("class", "setInline").text(post['poCrd']);
			div.append('&nbsp;','&nbsp;', hRnum, hboType, aTag, '&nbsp;', '&nbsp;', '&nbsp;', hNm,'&nbsp;', hcrd, hHit, hVie, hiddenPoNo, $("<hr>"));
		} */
		return tr;
	}
	let searchForm = $("#searchForm").on("submit",	function(event) {
				event.preventDefault();
				
				url = this.action;
				let method = this.method;
				let data = $(this).serialize();
				
				console.log("url : " + url);
				console.log("data : " + data);
				
				$.ajax({
					url : url,
					method : method,
					data : data,
					dataType : "json",
					success : function(pagingVO) {
						
						console.log("pagingVO : " + pagingVO);
						console.log("pagingVO.dataList : " +  pagingVO.dataList);
						
						listBody.empty();
						pagingArea.empty();
						pageTag.val("");
						let postList = pagingVO.dataList;
						let boards= [];
						if (postList.length > 0) {
							$.each(postList, function(index, post) {
								let tr = makeBoard(post);
								boards.push(tr);
								console.log("boards : ", boards)
							});
						} else {
							let tr = $("<tr>").html(
									$("<td>").attr("colspan", "6").html("등록된 커뮤니티 게시글이 없습니다."));
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
</script>