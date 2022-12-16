<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
.form-check-input{
	font-size: 15px;
}
.card{
	padding :1%;
}
input{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
select{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>
<div class="card md-3">
 <br>
 <div>
	<h3 class="addrSet" style="font-size: 30px; font-weight:bold;float: left;" ><span class="far fa-address-book"></span>&nbsp;전체 주소록</h3>
 	<div style="float: right;">	
  		<a id = "sendMail" href="" class="btn btn-outline-primary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold;">메일쓰기</a>
 	</div>
 </div>
	<hr>
	<pre>
</pre>
<form:form action="">
	<table class="table table-hover ">
		<thead class="thead-light" style="text-align: center;">
			<tr>
				<th><input class="form-check-input" onclick="selectAll(this)" type="checkbox" value=""
					name="checkings"></th>
				<th>이름</th>
				<th>부서</th>
				<th>직위</th>
				<th>전화번호</th>
				<th>이메일</th>
			</tr>
		</thead>
		<tbody id="listBody" style="text-align: center;">
		</tbody>
	</table>
</form:form>	
	<br>
	<div class="pagingArea"></div>	
	<br>
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-control">
				<option value="">전체검색</option>
				<option value="title">이름</option>
				<option value="writer">부서</option>
			</select>
		</div>
		<div class="col-auto">
			<input type="text" name="searchWord" placeholder="검색키워드"
				class="form-control" value="" />
		</div>
		<div class="col-auto">
			<input type="button" value="검색" id="searchBtn"
				class="btn btn-outline-secondary me-1 mb-1"
				style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold;" />
		</div>
		<form id="searchForm">
			<input type="hidden" name="page" /> <input type="hidden"
				name="searchType" /> <input type="hidden" name="searchWord" />
		</form>		
	</div>
</div>



<script>
	let searchUI = $("#searchUI").on("click", "#searchBtn", function(event) {
		let inputTags = searchUI.find(":input[name]");
		$.each(inputTags, function(index, inputTag) {
			let name = $(this).attr("name");
			let value = $(this).val();
			searchForm.get(0)[name].value = value;
		});
		searchForm.submit();
	});
	let pageTag = $("[name=page]");
	let listBody = $("#listBody");
	let pagingArea = $(".pagingArea").on("click", "a", function(event) {
		event.preventDefault();
		let page = $(this).data("page");
		if (!page)
			return false;
		pageTag.val(page);
		searchForm.submit();
		return false;
	});

	let makeTrTag = function(addressList) {
		let tr = $("<tr>");
		tr.append($("<td style='font-size:15px;'>").append($("<input>").attr("type", "checkbox").attr("class","form-check-input").attr("name","checking").attr("value",addressList.empMail)), 
				$("<td style='font-size:15px;'>").html(addressList.empNm), 
				$("<td style='font-size:15px;'>").html(addressList.depNm), 
				$("<td style='font-size:15px;'>").html(addressList.jobNm), 
				$("<td style='font-size:15px;'>").html(addressList.empPh), 
				$("<td style='font-size:15px;'>").html(addressList.empMail).attr("class","mailaddr"));

		return tr;
	}

	let searchForm = $("#searchForm").on(
			"submit",
			function(event) {
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
						console.log("pagingVO {}", pagingVO)
						pagingArea.empty();
						pageTag.val("");
						let addressList = pagingVO.dataList;
						let trTags = [];
						if (addressList.length > 0) {
							$.each(addressList, function(index, addressList) {
								let tr = makeTrTag(addressList);
								trTags.push(tr);
							});
						} else {
							let tr = $("<tr>").html(
									$("<td>").attr("colspan", "6").html(
											"조건에 맞는 검색이 아님."));
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
	
	function selectAll(selectAll){
		const checkboxes
		= document.getElementsByName('checking');
		
		checkboxes.forEach((checkbox) => {
			checkbox.checked = selectAll.checked;
		})
	}
		
	
	//메일 작성페이지 이동
	let mailAddress = $("#sendMail").on('click',function(event){
		event.preventDefault();
		let toAddresses=[];
		$('input:checkbox[name=checking]').each(function (index) {
	        if($(this).is(":checked")==true){
	           toAddresses.push($(this).val());
	        }
	     })
	     	
		if(toAddresses.length==0){
			 toastr.error("체크된 값이 없습니다! 선택해주세요");
		 
		 return;
		}
		 $.ajax({
				url : "${cPath }/groupware/mail/mailCheckBoxInsert.do",
				method : "get",
				data : {toAddresses : toAddresses},
				dataType : "html",
				success : function(res) {
					
				    location.href="${cPath }/groupware/mail/mailInsert.do?check=OK";
				},
				error : function(xhr) {
					console.log(xhr.status);
				}
		});
	});
	


	
	
	
	
	
</script>