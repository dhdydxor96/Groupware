<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.card {
	padding : 1%;
}

table {
	border-collapse: collapse;
}
th,td{
	width:19%
}
.rightSpan{
	text-align: right;	
}
.leftA{
	text-align: left;
}
.badge{
	width:150px;
}
.pagination>li>a, .pagination>li>span { 
	border-radius: 45% !important;margin: 0 5px;
	
}
.pagingRoomArea{
	margin-left:88%
}
h3{
	font-weight: bold
}
</style>

<div class="card mb-3">
	<!-- -------------------------- -->
	<!--    	 	메뉴명	     	-->
	<!-- -------------------------- -->
	<br>
	<h3><span class="fas fa-caret-right"></span>&nbsp;회의실 예약</h3>
	<hr>
	
	<!-- -------------------------- -->
	<!--  		  회의실 리스트     		-->
	<!-- -------------------------- -->
	<div class="pagingRoomArea"></div>
	<table class="table">
		<tbody id="listBody"></tbody>
	</table>
	<br>
	<br>
	<br>
	
	<!-- -------------------------- -->
	<!--  		  나의 예약 현황		   	-->
	<!-- -------------------------- -->
	<div style="text-align: left">
		<h3 style="font-weight: bold"><span class="fas fa-caret-right"></span>&nbsp;나의 예약 현황</h3>
		<hr>
		<div class="pagingReserArea"  style="margin-left:82%"></div>
		<div class="table-responsive scrollbar">
		  <table class="table table-hover table-striped overflow-hidden" id="myListTable">
		    <thead>
		      <tr>
		        <th scope="col">예약일</th>
		        <th scope="col">예약시간</th>
		        <th scope="col">장소</th>
		        <th scope="col">사용여부</th>
		      </tr>
		    </thead>
		    <tbody></tbody>
		  </table>
		</div>
	</div>

	
	<form id="searchRoomForm">
		<input type="hidden" name="page" />
		<input type="hidden" name="searchType" />
		<input type="hidden" name="searchWord" />
	</form>
	<form id="searchReserForm">
		<input type="hidden" name="page" />
		<input type="hidden" name="searchType" />
		<input type="hidden" name="searchWord" />
	</form>
	
	
</div>


<script>
	let pageRoomTag = $("#searchRoomForm > [name=page]");
	let pageReserTag = $("#searchReserForm > [name=page]");
	
	let listBody = $("#listBody");
	let myListTable = $("#myListTable");
	let tableBody = $( '#myListTable > tbody');
	
	//========================================================
	// 회의실 리스트 조회 - 페이징 처리
	//========================================================
	let pagingRoomArea = $(".pagingRoomArea").on("click", "a", function(event){
		event.preventDefault();
		let page = $(this).data("page");
		if(!page) return false;
		pageRoomTag.val(page);
		searchRoomForm.submit();
		return false;
	});
	
	let makeRoomTrTag = function(room){
		let tr = $("<tr>");
		let aTag = $("<a>").attr("href", "${cPath}/groupware/resource/resourceDetail.do?what="+room.meetNo)
							.text(room.meetNm);
		tr.append(
			$("<th>").html(aTag)
			, $("<th style='text-align:right'>").html(room.meetCount+"건 예약")
		);
		
		return tr;
	}
	
	let searchRoomForm = $("#searchRoomForm").on("submit", function(event){
		event.preventDefault();
		let data = $(this).serialize();
		$.ajax({
			url : "${cPath}/groupware/resource/companyResourceStatus.do",
			data : data,
			dataType : "json",
			success : function(pagingVO) {
				listBody.empty();
				pagingRoomArea.empty();
				pageRoomTag.val("");
				let roomList = pagingVO.dataList;
				let trTags = [];
				if(roomList.length > 0){
					$.each(roomList, function(index, room){
						let tr = makeRoomTrTag(room);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "2")
								 .html("등록된 회의실이 없습니다.")
					);
					trTags.push(tr);
				}
				listBody.append(trTags);
				let pagingHTML = pagingVO.pagingHTML;
				pagingRoomArea.html(pagingHTML);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		return false;
	}).submit();
	
	//========================================================
	// 내 예약 현황 조회 - 페이징 처리
	//========================================================
	let pagingReserArea = $(".pagingReserArea").on("click", "a", function(event){
		event.preventDefault();
		let page = $(this).data("page");
		if(!page) return false;
		pageReserTag.val(page);
		searchReserForm.submit();
		return false;
	});

	let makeReserTrTag = function(reser){
		let tag = "<tr>";
		tag += "<td class='text-nowrap'>"+reser.revStart+"</td>";
		tag += "<td class='text-nowrap'>"+reser.metCon+"</td>";
		tag += "<td class='text-nowrap'>"+reser.meetRoom.meetNm+"</td>";
		tag += "<td class='text-nowrap' style='text-align: center;' >";
		if(reser.revSta == 0){
			tag += "<div class='row'><div class='col-auto'>";
			tag += "<span class='badge badge rounded-pill d-block p-2 badge-soft-secondary'>사용전</span>";
			tag += "</div>";
			tag += "<div class='col-auto'>";
			tag += "<a href='#' class='delReserv' id='"+reser.revNo+"'><span class='fas fa-times'></span></a>";
			tag += "</div></div>";
		}else{
			tag += "<span class='badge badge rounded-pill d-block p-2 badge-soft-success'>사용완료</span>";
		}
		tag += "</td>";
		tag += "</tr>";

		return tag;
	}

	let searchReserForm = $("#searchReserForm").on("submit", function(event){
			event.preventDefault();
			let data = $(this).serialize();
			$.ajax({
				url : "${cPath}/groupware/resource/myResourceStatus.do",
				data : data,
				dataType : "json",
				success : function(pagingVO) {
					tableBody.empty();
					pagingReserArea.empty();
					pageReserTag.val("");
					let reserList = pagingVO.dataList;
					let trTags = [];
					if(reserList.length > 0){
						$.each(reserList, function(index, reser){
							let tr = makeReserTrTag(reser);
							trTags.push(tr);
						});
					}else{
						let tr = $("<tr>").html(
							$("<td>").attr("colspan", "4")
									 .html("예약한 내역이 없습니다.")
						);
						trTags.push(tr);
					}
					tableBody.append(trTags);
					let pagingHTML = pagingVO.pagingHTML;
					pagingReserArea.html(pagingHTML);
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
			return false;
		}).submit();
	

	//========================================================
	// 예약 취소 버튼을 눌렀을 때
	//========================================================
	$(document).on('click', ".delReserv", function(event){
		
		swal({
				title: "예약을 취소하시겠습니까?",
				icon: "info",
			    buttons: ["아니오", "네"]
			}).then((네) => {
			  if (네) {
				  
				  $.ajax({
						url : "${cPath}/groupware/resource/resourceDel.do",
						method : "post",
						data: { what : $(this).attr("id") },
						dataType : "JSON",
						success : function(pagingVO) {
							tableBody.empty();
							pagingReserArea.empty();
							pageReserTag.val("");
							let reserList = pagingVO.dataList;
							let trTags = [];
							if(reserList.length > 0){
								$.each(reserList, function(index, reser){
									let tr = makeReserTrTag(reser);
									trTags.push(tr);
								});
							}else{
								let tr = $("<tr>").html(
									$("<td>").attr("colspan", "4")
											 .html("예약한 내역이 없습니다.")
								);
								trTags.push(tr);
							}
							tableBody.append(trTags);
							let pagingHTML = pagingVO.pagingHTML;
							pagingReserArea.html(pagingHTML);
							
							
						},
						error : function(errorResp) {
							console.log(errorResp.status);
						}
					})
					searchRoomForm.submit();
				  swal('회의실 예약이 취소되었습니다.', '', 'success')
			  } 
			});
	});

</script>