<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<script src="${cPath}/resources/js/ckeditor/ckeditor.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
textarea{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
.btn{
	font-family: 'IBM Plex Sans KR', sans-serif;
}

.insertcommuReply{
	display: inline-block;
	width: 55px;
	float: right;
}

.floatingTextarea2{
	width : 400px;
}

.widthSetting td{
	width : 84%;
	text-align: left;
}

.setOverflow{
	overflow : hidden;
	    width: 47%
}

.setTdwidth{
	width :100px;
}

.setTdAlign{
	text-align:left;
}

</style>
<div class="card mb-3" style="padding:1%; text-align: center; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left;">
	<br>
	<form action="">
	<c:if test="${authEmp.empId eq post.empId}">
		<button class="btn btn-outline-primary mr-1 mb-1 deleteComPost" type="button" style="width:10%; margin-left: 1%; float: right; font-weight:bold; font-family: 'IBM Plex Sans KR', sans-serif;">삭제</button>
		<button class="btn btn-outline-primary mr-1 mb-1 updateComPost" type="button" style="width:10%;	float: right; font-weight:bold; font-family: 'IBM Plex Sans KR', sans-serif;">수정</button>
	</c:if>	
	<c:forEach items="${post.boardList}" var="board" varStatus="vs">
		<h3 style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;"><span class="fas fa-book-open"></span>&nbsp;${board.boType}</h3>
	</c:forEach>
	<hr>
	<br>
		<div style="overflow : auto;">
		<div style="zoom: 1;">
		<table class="table table-bordered" style="width:90%; margin-left:5%;">
			<thead>
				<tr>
					<th>제목</th>
					<td colspan="3">${post['poTit'] }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td colspan="3">${post['emp']['empNm']}</td>
				</tr>
				<tr>
					<th>날짜</th>					
					<td>${post['poCrd'] }</td>
					<th>조회수</th>
					<td>${post['poVie'] }</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<c:forEach items="${post.attatchList }" var="attatch" varStatus="vs">
							<c:url value="/groupware/board/communicationDownload.do" var="downloadURL">
								<c:param name="what" value="${attatch.attNo }"/>
							</c:url>
								<a href="${downloadURL }">${attatch.attFnm }</a>&nbsp;${attatch.attFas }
								${not vs.last?"|":"" }
						</c:forEach>
					</td>
				</tr>
			</tbody>
		</table>
		<table class="table table-bordered" style="width:90%; margin-left:5%;">
			<tr>
				<td colspan="4" style="text-align: left;">${post['poCon'] }</td>
			</tr>
		</table>
		</div>
		</div>
	</form>
	<c:forEach items="${post.boardList}" var="board">
		<c:if test="${board.boYn != 'N'}">
			<div style="padding:5%; text-align: center; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left;">
			<span>댓글</span>
			<hr/>
			<div id="listBody">
			
			</div>
			<form id="replyForm" action="${cPath}/groupware/board/comment/${post.poNo}" method="post">
				<security:csrfInput/>
				<input type="hidden" name="empId" value="${authEmp.empId}" class="form-control"/>
				<textarea name="cotCon" class="form-control" placeholder="댓글을 남겨주세요."
						id="floatingTextarea2"></textarea>
				<div class="insertcommuReply"><button class="btn btn-outline-primary btn-sm mb-1 " type="submit" style="margin-top: 10%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">등록</button></div>
			</form>
			<br><br>
			<hr />
			</div>
		</c:if>
	</c:forEach>
	<div>
		<input type="button" class="btn btn-outline-secondary gotoList" value="목록" style=" width:25%; margin-left:37%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">
		<br>
	</div>
	<br>
</div>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">댓글 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<form name="modifyComForm" action="${cPath}/groupware/board/comment/${post.poNo}?${_csrf.parameterName}=${_csrf.token}" method="post">
      		<textarea name="cotCon" class="form-control" id="modalTextarea"></textarea>
      		<input type="hidden" name="cotNo" value="" id="modalcotNo"/>
      		<input type="hidden" name="poNo"  value="${post.poNo }" />
      	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-primary" id="updateBtn" style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">저장</button>
        <button type="button" class="btn btn-outline-primary"  id="deleteBtn" data-bs-dismiss="modal" style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">취소</button>
      </div>
    </div>
  </div>
</div>
<form name="deleteComForm" method="post" action="${cPath }/groupware/board/communicationDelete.do?${_csrf.parameterName}=${_csrf.token}">
	<input type="hidden" name="poNo" value="${post.poNo }"/>
	<input type="hidden" name="EmpPass">
</form>
<script>
	
	//취소버튼 선언(리스트페이지로 이동)
	let cancelButton = $(".gotoList");
	cancelButton.click(function onclick(){
	   location.href="${cPath}/groupware/board/communicationList.do";       
	});
	// 수정버튼
	let updateComPost = $(".updateComPost");
	updateComPost.click(function onclick(){
		location.href="${cPath}/groupware/board/communicationUpdate.do?what="+${post['poNo'] };
	});
	$(".deleteComPost").on("click", function(title, text){
		swal({
			   title : "게시글을 삭제 하시겠습니까?",
			   buttons: ["취소" , "삭제"]
			}).then((value) => {
				if(value){
					$(document.deleteComForm).submit();
				}
			}) 
	});
	
	let authEmpId = '${authEmp.empId}'
	console.log('${authEmp.empId}'+ " 로그인 아이디 확인")
	
	let listBody = $("#listBody");
	let makeTrTag = function(comments){
		
		let commentEmpId = comments.empId
		console.log(commentEmpId + "댓글 아이디 확인")
		
		
		
		
		let trTag;
		let trCrd = $("<td class='setTdwidth'>")
		if(authEmpId == commentEmpId){
			trTag = $("<table style='width:100%;'>").append(
							  $("<tr>").append(
										$("<td style='font-weight:bold'>").html(comments.empNm).attr("class", "setTdAlign")
									  , $(trCrd).html(comments.cotCrd).css('font-size', '87%')
							  )
							, $("<tr>").append(
										$("<td>").append(
													$("<div>").attr("class", "setOverflow")
																.html(comments.cotCon).attr("class", "setTdAlign")
												).attr("colspan", "2")
							)
							, $("<tr>").append(
										$("<td>")
									,	$("<td>").append(
													$("<button style='margin-right:10%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;'>").text("수정")
										 						.attr("class", "btn btn-outline-primary btn-sm mb-1 modifyComment")
										 						.attr("type", "button")
										 						.attr("data-cotno", comments.cotNo)
										 						.attr("data-cotcon", comments.cotCon)
												,	$("<button style='font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;'>").text("삭제")
																 .attr("class", "btn btn-outline-primary btn-sm mb-1 deleteComment")
												 				.attr("type", "button")
										 						.attr("data-cotno", comments.cotNo)
									)	
							 )
							 , $("<tr>").append(
										$("<td>")
												.append(
														$("<hr>")		
												).attr("colspan", "2")
							 )
			).attr("class", "widthSetting")
		}else{
			trTag = $("<table style='width:100%;'>").append(
							  $("<tr>").append(
										$("<td style='font-weight:bold'>").html(comments.empNm)
									  , $(trCrd).html(comments.cotCrd).css('font-size', '87%')
							  )
							, $("<tr>").append(
										$("<td>").html(comments.cotCon)
												 .attr("colspan", "2")
												 .attr("overflow", true)
							)
							 , $("<tr>").append(
													$("<td>")
															.append(
																	$("<hr>")		
															).attr("colspan", "2")
								)
						).attr("class", "widthSetting")
		}
		return trTag;
	}

	let renderingReplyList = function(){
		$.ajax({
			url:"${cPath}/groupware/board/comment/${post.poNo}"
			, method:"get"
			, dataType:"json"
			, success:function(resp){
				let commentList = resp.dataList;
				let trTags = [];
				if(commentList && commentList.length > 0){
					$.each(commentList, function(idx, comment){
						let trTag = makeTrTag(comment);
						trTags.push(trTag);
					});
				}else{
					trTags.push(
						$("<tr>").html(
							$("<td>").attr("colspan", "3")
						)
					);
				}
				listBody.html(trTags);
			}
		});
	}
	
	renderingReplyList();
	
	$("#replyForm").on("submit", function(event){
		event.preventDefault();
		let url = this.action;
		let method = this.method;
		let data = $(this).serialize();
		let replyForm = this;
		$.ajax({
			url:url
			, method:method
			, data:data
			, dataType:"json"
			, success:function(resp){
				if(!resp.errors && resp.result=="OK"){
					renderingReplyList();
					replyForm.reset();
				}else{
					console.log("덧글 작성 실패");
				}
			}
		});
		return false;
	});
	
	$(document).on("click", ".deleteComment", function() {
		let cotNo = $(this).data("cotno");
		let cotCon = $(this).data("cotcon");
		
		swal({
			   title : "댓글을 삭제 하시겠습니까?",
			   buttons: ["취소" , "삭제"]
			}).then((value) => {
				if(value){
		            $.ajax({
						url : "${cPath}/groupware/board/comment/deleteComment/${post.poNo}",
						data : { "cotNo" : cotNo
								,"cotCon" : cotCon
						},
						type : "get",
						success : function(res){
							renderingReplyList();
							
						},
						errors : function(errorResp){
							console.log(errorResp.status);
						},
						dataType : 'json'
					});                
				}
			}) 
	});
	
 	$(document).on("click", ".modifyComment", function() {

		let cotNo = $(this).data("cotno")
		let cotCon = $(this).data("cotcon")
		
		let modifyCommentModal = $("#exampleModal").modal('show')
		$("#modalTextarea").val(cotCon)
		$("#modalcotNo").val(cotNo)
	})
	
	$("#updateBtn").on("click", function(event){
		let modiForm = $(document.modifyComForm).serialize()
		
		$.ajax({
			url : "${cPath}/groupware/board/comment/${post.poNo}?${_csrf.parameterName}=${_csrf.token}"
			,data : modiForm
			,method : "post"
			,success : function(res){
				renderingReplyList();
				
			},
			errors : function(errorResp){
				console.log(errorResp.status);
			},
			dataType : 'json'
		})
		$(this).find(".modal-body").empty();
		$("#exampleModal").modal('hide')
	}) 
	
</script>