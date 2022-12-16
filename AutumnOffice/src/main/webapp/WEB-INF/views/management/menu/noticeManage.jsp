<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
	.card{
		padding:1%;
	}
	@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
	h1{
		font-family: 'IBM Plex Sans KR', sans-serif;
		text-align : center;
	}
	h2{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	h3{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	h4{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	h5{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	p{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	span{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	th{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	td{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	.addrSelector{
	    width: 150px;
	    height: 34px;
	    float : left;
	}
	a{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<div>
		<h4 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:30px;float: left;"><span class="fas fa-caret-right"></span> 공지사항 관리</h4>
		<div style="float: right;">
			<button type="button" style="font-weight: bold;" class="btn btn-outline-primary me-1 mb-1" id="btnNew">공지사항 등록</button>&nbsp;
			<button type="button" style="font-weight: bold;" class="btn btn-outline-primary me-1 mb-1" id="btnDelete">삭제</button>
		</div>
	</div>
	<hr>
	<div>기업의 공지사항을 관리합니다.</div>
	<br>
	<table class="table table-hover">
    	<thead class="bg-200 text-black">
        	<tr>
				<th class="align-middle white-space-nowrap">
				  <div class="custom-control custom-checkbox">
				    <input class="checkbox-bulk-select" id="checkbox-bulk-select" type="checkbox">
				  </div>
				</th>
				<th class="align-middle">No</th>
				<th class="align-middle">제목 </th>
				<th class="align-middle">날짜</th>
				<th class="align-middle white-space-nowrap pr-3">조회수</th>
          </tr>
        </thead>
        <tbody id="bulk-select-body">
        </tbody>
      </table>
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-control addrSelector">
				<option value>전체</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="date">날짜</option>
			</select>
		</div>
		<div class="col-auto">
			<input type="text" name="searchWord" placeholder="검색키워드"
				class="form-control addrSearch" value=""/>
		</div>
		<div class="col-auto">
		 	<input type="button" style="font-weight: bold;" class="btn btn-outline-secondary me-1 mb-1 searchButton" value="검색" id="searchBtn">
		</div>
	</div>
	<div class="pagingArea">
	</div>
	
</div>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>
<script	src='<%=request.getContextPath()%>/resources/js/jquery-3.6.0.min.js?<%=System.currentTimeMillis()%>'></script>
<script>
	let btnNew = $('#btnNew').on("click", function() {
		location.href="${cPath }/management/menu/noticeInsert.do"
	});
	
	$(function(){
		// 체크박스 헤더를 클릭하면 체크박스 바디 전체 선택하는 로직
		$("#checkbox-bulk-select").on("click", function(event){
			let chk_listArr = $("input:checkbox[class='checkboxBody']");
				console.log("chk_listArr", chk_listArr);
			for (var i=0; i<chk_listArr.length; i++){
				chk_listArr[i].checked = this.checked;
			}
			console.log("체크박스 선택 개수 : " , chk_listArr.length);
		});
	})
	
	$(document).on("click", ".checkboxBody", function(event){
		let chkBody = $("input:checkbox[class='checkboxBody']:checked");
		console.log("선택한 개수", chkBody.length)
		let chk_listArr = $("input:checkbox[class='checkboxBody']");
		console.log("체크박스의 총 개수", chk_listArr.length);
			if(chkBody.length == chk_listArr.length){
				console.log("선택한 개수", chkBody, "체크박스 개수", chk_listArr)
				$("#checkbox-bulk-select").prop("checked", true);
			}else{
				$("#checkbox-bulk-select").prop("checked", false);
			}
	})
	
	function delValue(){
		var url = "${cPath}/management/menu/noticeDeletes.do?${_csrf.parameterName}=${_csrf.token}"
		var valueArr = new Array();
		var list = $(".checkboxBody");
		for(var i=0; i<list.length; i++){
			if(list[i].checked){
				valueArr.push(list[i].value);
			}
		}
		console.log("valueArr", valueArr);
		if(valueArr.length == 0){
			toastr.info("선택된 공지가 없습니다.");
		}else{
			chkSwal(); 
		}
	}
	
	$("#btnDelete").on("click", function(){
		delValue();
	})
	
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
	let listBody = $("#bulk-select-body");
	let pagingArea = $(".pagingArea").on("click", "a", function(event) {
		event.preventDefault();
		let page = $(this).data("page");
		if (!page)	return false;
		pageTag.val(page);
		
		searchForm.submit();
		return false;
	});

	let makeBoard = function(index, notice) {
		let div = $("<div>")
		let viewURL = "${cPath}/management/menu/noticeView.do?what="+notice.nocNo;
		let trTag = $("<tr>").append(
							$("<td>").append(
									$(div).append(
											$("<input>").attr("class", "checkboxBody")
														.attr("type", "checkbox")
														.attr("id", "checkbox-" + index)
														.attr("value", notice.nocNo)
										,	$("<label>").attr("class", "checkboxBody")
														.attr("for", "checkbox-" + index)
									).attr("class", "custom-control ").css("margin-left", "3%")
							).attr("class", "align-middle white-space-nowrap")
						,	$("<th>").html(notice.rnum).attr("class", "align-middle")
						,	$("<td>").html($("<a>").attr("href", viewURL)
									.text(notice.nocTit).attr("class", "align-middle"))
						,	$("<td>").html(notice.nocDate).attr("class", "align-middle")
						,	$("<td>").html(notice.nocVie).attr("class", "align-middle")
					).attr("id", "bulk-select-body");
		return trTag;
	}
	
	let searchForm = $("#searchForm").on("submit",	function(event) {
		
				event.preventDefault();
				let url = this.action;
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
						
						console.log("pagingVO : " , pagingVO);
						console.log("pagingVO.dataList : " ,  pagingVO.dataList);
						
						let listBody = $("#bulk-select-body");
						
						listBody.empty();
						pagingArea.empty();
						pageTag.val("");
						
						let noticeList = pagingVO.dataList;
						let boards= [];
						
						if (noticeList.length > 0) {
							$.each(noticeList, function(index, notice) {
								let tr = makeBoard(index, notice);
								boards.push(tr);
							});
						}else {
							let tr = $("<tr>").html(
									$("<td>").attr("colspan", "4").html("공지사항이 없습니다."));
							boards.push(tr);
						}	
							
						if($("input:checkbox[class='checkboxBody']:checked").length == 0){
							$("#checkbox-bulk-select").prop("checked", false);							
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
	
	let chkSwal = function(title, text){
		var url = "${cPath}/management/menu/noticeDeletes.do?${_csrf.parameterName}=${_csrf.token}"
		var valueArr = new Array();
		var list = $(".checkboxBody");
		for(var i=0; i<list.length; i++){
			if(list[i].checked){
				valueArr.push(list[i].value);
			}
		}
	   swal({
		   title : "공지사항을 삭제 하시겠습니까?",
		   buttons: ["취소" , "삭제"]
		}).then((value) => {
			if(value){
					$.ajax({
						url : url
					,	method : 'POST'
					,	data : JSON.stringify(valueArr)
					,	contentType : "application/json;charset=UTF-8"	
					,	
					success: function(resp){
						if(resp = 1){
							toastr.info("삭제 성공");
							searchForm.submit();
						}else{
							toastr.error("삭제 실패");
						}
					}
					,
					error : function(errorResp) {
						console.log(errorResp.status);
					}
				})                
			}
		}) 
   };
	
</script>
<style>
	.setInline{
		display: inline-block;
	}
</style>