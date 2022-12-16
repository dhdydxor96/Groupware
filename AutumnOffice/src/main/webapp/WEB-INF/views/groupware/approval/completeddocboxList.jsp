<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.card{
	padding : 1%;
}

a{
	color : black;
	text-decoration : none;
}

.badge{
	width:80px;
}
.docBox-wrapper{
	height:800px;
	min-width:900px;
}
.docBox-table{
	text-align: center;
	font-size: 0.9em;
	table-layout: fixed;
}
#searchUI{
	font-size: 0.8em;
}
.docTr:hover{
	cursor:pointer
}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
div{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
select{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
h3{
	font-size: 30px;
	font-weight: bold
}
.btn{
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-weight: bold;
}
</style>

<div class="card md-3 docBox-wrapper">
	<!-- 메뉴 명 -->
	<br>
	<h3><span class="far fa-clipboard"></span>&nbsp;결재 문서함</h3>
	<hr>
	<br> 
	
	<!-- 기안 문서 리스트 -->
	<div class="table-responsive scrollbar">
	  <table class="table table-hover overflow-hidden docBox-table">
	    <thead>
	      <tr>
	        <th scope="col">문서번호</th>
	        <th scope="col">결재양식</th>
	        <th scope="col" style="width: 30%">제목</th>
	        <th scope="col">기안자</th>
	        <th scope="col" style="width: 20%">기안일</th>
	        <th scope="col">결재상태</th>
	      </tr>
	    </thead>
	    <tbody class="docList">
	    </tbody>
	  </table>
	</div>
	<br>
	<!-- 페이징 처리 -->
	<div class="pagingArea">
	 
	</div>

	<br>
	
	<!-- 검색 -->
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-select ">
				<option value="all">전체</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
		</div>
		<div class="col-auto">
			<input type="text" name="searchWord" placeholder="검색키워드" class="form-control" value=""	/>
		</div>
		<div class="col-auto">
			<input type="button" value="검색" id="searchBtn" class="btn btn-outline-secondary me-1 mb-1"/>
		</div>
	</div>
	<br>
</div>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
	<input type="hidden" name="state" value=""/>
</form>

<form id="detailDocForm" method="get" action="${cPath }/groupware/approval/doc/docDetail.do">
	<input type="hidden" name="eleNo"/>
	<input type="hidden" name="eleMenu" value="결재 문서함"/>
</form>
	
	
<script type="text/javascript" defer="defer">
	
	// =============================================
	// 검색 버튼 클릭시 searchForm ajax 통신 활성화
	// searchForm의 input에 검색 데이터 셋팅해서 submit
	// =============================================
	let searchUI = $("#searchUI").on("click", "#searchBtn", function(event){
		let inputTags = searchUI.find(":input[name]");
		$.each(inputTags, function(index, inputTag){
			let name = $(this).attr("name");
			let value = $(this).val();
			searchForm.get(0)[name].value = value;
		});
		searchForm.submit();
	});
	
	// =============================================
	// page 처리
	// searchForm의 input에 page 데이터 셋팅해서 submit
	// =============================================
	let pageTag = $("[name=page]");
	let listBody = $(".docList");
	let pagingArea = $(".pagingArea").on("click", "a", function(event){
		event.preventDefault();
		let page = $(this).data("page");
		if(!page) return false;
		pageTag.val(page);
		searchForm.submit();
		return false;
	});
	
	// =============================================
	// tr 태그 생성 함수
	// =============================================
	let makeTrTag = function(data){
		let trTag = $("<tr>").attr("class", "docTr")
					.append( $("<td>").attr("class", "eleNo").text(data.eleNo) )
					.append( $("<td>").text(data.appForm.apfCat) )
					.append( $("<td>").text(data.eleTit) )
					.append( $("<td>").text(data.empNm) )
					.append( $("<td>").text(data.eleCrd) );
		switch(data.appStatus.apsStatus){
		case '0':
		trTag.append( $("<td>").append($("<span>")
		.attr("class", "badge badge-soft-primary")
		.text("진행중")));
		break;
		case '1':
		trTag.append( $("<td>").append($("<span>")
		.attr("class", "badge badge-soft-success")
		.text("승인")));
		break;
		case '3':
		trTag.append( $("<td>").append($("<span>")
		.attr("class", "badge badge-soft-danger")
		.text("반려")));
		break;
		}
		
		return trTag;
	}
	
	// ==============================================
	// searchForm ajax 통신
	// 통신에 성공하면 결재 문서 리스트를 불러와서 table에 찍어줌
	// ==============================================
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
				let dataList = pagingVO.dataList;
				let trTags = [];
				if(dataList.length > 0){
					$.each(dataList, function(index, data){
						let tr = makeTrTag(data);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "6")
								 .html("조건에 맞는 문서가 없습니다..")
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


	// =============================================
	// 결재 문서 상세보기
	// =============================================
	let detailDocForm = $("#detailDocForm");
	let docTr = $(document).on("click", ".docTr", function(){
		let eleNo = $(this).find(".eleNo").text();
		detailDocForm.find("input[name=eleNo]").val(eleNo);
		detailDocForm.submit();
	});
	
</script>
	