<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<script src="${cPath}/resources/js/ckeditor/ckeditor.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>

.table {
	text-align: center;
}

.aTagSetting {
	font-size: 0.8em;
}

.insertcommuReply{
	display: inline-block;
	width: 55px;
	float: right;
}

.gotoList{
	
	float : left;
	width : 80px;
}

.floatingTextarea2{
	width : 400px;
}

.noticeBack{
	background : white;
}

.table-bordered thead tr:first-child th:nth-child(2){
		padding-bottom: 34px;
		text-align: center;
 	}
 img{
 	width : 100%
 }

</style>
<div class="card mb-3" style="padding:1%; text-align: center; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<div>
		<h3 style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif; font-size:30px; text-align:left;float: left"><span class="fas fa-volume-up"></span>&nbsp;공지사항 상세보기</h3>
		<div style="float: right;">
			<button class="btn btn-outline-primary mr-1 mb-1 updateComPost" type="button" style="font-weight: bold;" >수정</button>
			<button class="btn btn-outline-primary mr-1 mb-1 deleteComPost" type="button" style="font-weight: bold;" >삭제</button>
		</div>
	</div>
	<hr>
	<br>
	
	<form action="">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th style="padding: 1%;">제목</th>
					<td style="padding: 1%;" colspan="5">${notice['nocTit'] }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>관리자</td>
					<th>등록일</th>
					<td>${notice['nocDate'] }</td>
					<th>조회수</th>
					<td>${notice['nocVie'] }</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>첨부파일</th>
					<td colspan="5">
						<c:forEach items="${notice.attatchList }" var="attatch" varStatus="vs">
							<c:url value="/groupware/board/noticeDownload.do" var="downloadURL">
								<c:param name="what" value="${attatch.attNo }"/>
							</c:url>
								<a href="${downloadURL }">${attatch.attFnm }</a>&nbsp;${attatch.attFas }
								${not vs.last?"|":"" }
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td style='text-align: left;height: 250px' colspan="6">${notice['nocCon'] }</td>
				</tr>
			</tbody>
		</table>
	</form>
	<br>
	<button type="button" class="btn btn-outline-secondary gotoList" style="float: left; margin-left: 38.5%; width:25%; font-weight: bold;">목록</button>
	<br>
</div>

<form name="deleteComForm" method="post" action="${cPath}/management/menu/noticeDelete.do?${_csrf.parameterName}=${_csrf.token}">
	<input type="hidden" name="nocNo" value="${notice.nocNo }"/>
</form>
<script>
	
	//취소버튼 선언(리스트페이지로 이동)
	let cancelButton = $(".gotoList");
	cancelButton.click(function onclick(){
	   location.href="${cPath}/management/menu/noticeManage.do";       
	});
	// 수정버튼
	let updateComPost = $(".updateComPost");
	updateComPost.click(function onclick(){
		location.href="${cPath}/management/menu/noticeUpdate.do?what="+${notice.nocNo };
	});
	$(".deleteComPost").on("click", function(event){
		chkSwal(); 
	});
	
	let chkSwal = function(title, text){
		swal({
			   title : "게시판을 삭제 하시겠습니까?",
			   buttons: ["취소" , "삭제"]
			}).then((value) => {
				if(value){
					$(document.deleteComForm).submit();
				}
			})
	};
	
	
</script>