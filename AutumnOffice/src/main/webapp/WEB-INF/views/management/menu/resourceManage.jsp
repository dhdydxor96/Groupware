<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
	.btn{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	a{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
</style>

<!-- -------------------------- -->
<!--   관리자페이지 - 회의실 리스트        -->
<!-- -------------------------- -->
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; ">
	<br>
	<div>
		<h4 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:30px;float: left;margin-right:1%;"><span class="fas fa-caret-right"></span> 회의실 관리</h4>
		<div >
			<button name="delBtn" class="btn btn-outline-primary me-1 mb-1" style="font-weight:bold;width:10%;float: right;" >삭제</button>
			<a href="${cPath}/management/menu/resoureManageInsert.do" class="btn btn-outline-primary me-1 mb-1" style="font-weight:bold;width:15%;float:right;margin-right: 1%" >회의실 등록</a>&nbsp;&nbsp;
		</div>
	</div>
	<hr>
	<div >기업의 회의실을 등록합니다.</div>
	<br>

	<table class="table table-hover">
		<thead>
			<tr>
				<th><input type="checkbox" onclick="selectAll(this)" name="checking" value="" /></th>
				<th >NO</th>
				<th>회의실명</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody id="listBody">
		</tbody>
	</table>
	<form id="searchForm">
		<input type="hidden" name="page" /> <input type="hidden"
			name="searchType" /> <input type="hidden" name="searchWord" />
	</form>
	<div class="pagingArea"></div>
	<br>
</div>

<script>
	//========================================================
	// 회의실 리스트 띄우기 + 페이징 처리
	//========================================================
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
	
	let makeTrTag = function(index,meetRoom){
		console.log(meetRoom);
		let tr = $("<tr>");
		let aTag = $("<a>").attr("href", "${cPath}/management/menu/resourceManageView.do?what="+meetRoom.meetNo)
							.text(meetRoom.meetNm);
		tr.append(
			  $("<td>").html("<input type='checkbox' name='checking' class='checkBox' value='"+meetRoom.meetNo+"' />")
			, $("<td>").html(index+1)
			, $("<td>").html(aTag)
			, $("<td>").html(meetRoom.meetInd)
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
				let meetRoomList = pagingVO.dataList;
				let trTags = [];
				if(meetRoomList.length > 0){
					$.each(meetRoomList, function(index, meetRoom){
						let tr = makeTrTag(index,meetRoom);
						trTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "4")
								 .html("등록된 회의실이 없습니다.")
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
	
	//========================================================
	// 체크박스 일괄 선택
	//========================================================
	function selectAll(selectAll)  {
	  const checkboxes 
	       = document.getElementsByName('checking');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  })
	}
	
	
	
	//========================================================
	// 체크박스로 선택한 회의실 삭제하기
	//========================================================
	let delBtn = $("[name=delBtn]");
	
	// 삭제 버튼 클릭 시
	delBtn.on('click', function(){
		
		var delMeetNos = new Array();
		$('input[type="checkbox"]:checked').each(function(index){
			console.log($(this).val());
			delMeetNos.push($(this).val());
		});
		
		console.log(delMeetNos);
		
		if(delMeetNos.length != 0){
			$.ajax({
				url : "${cPath}/management/menu/resoureManageDelete.do",
				dataType : "JSON",
				data : { delMeetNos : delMeetNos } ,
				success : function(pagingVO) {
					toastr.info("회의실이 삭제되었습니다.");
					listBody.empty();
					pagingArea.empty();
					pageTag.val("");
					let meetRoomList = pagingVO.dataList;
					let trTags = [];
					if(meetRoomList.length > 0){
						$.each(meetRoomList, function(index, meetRoom){
							let tr = makeTrTag(index,meetRoom);
							trTags.push(tr);
						});
					}else{
						let tr = $("<tr>").html(
							$("<td>").attr("colspan", "4")
									 .html("등록된 회의실이 없습니다.")
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
			})
			
		}else{
			toastr.info("삭제할 회의실이 없습니다.");
		}
	})

</script>