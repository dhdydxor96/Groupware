<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<script src="${cPath}/resources/js/ckeditor/ckeditor.js"></script>
<style>
#backgroundDiv {
	width: 85%;
	height: 70%;
	background: white;
	float: left;
	padding: 5px;
	position: relative;
}

.table {
	text-align: center;
}

.aTagSetting {
	font-size: 0.8em;
}

.insertcommuReply{
	width: 55px;
    margin-left: 1143px;
}

.gotoList{
	width : 55px;

}

.floatingTextarea2{
	width : 400px;
}
img{
	width: 100%
}

 .table-bordered thead tr:first-child th:nth-child(2){
		padding-bottom: 34px;
		text-align: center;
 	}

</style>
<div class="card mb-3" style="padding:1%; text-align: center; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left;">
	<br>
	<h3 style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;font-size: 30px"><span class="fas fa-volume-up"></span>&nbsp;공지사항 상세보기</h3>
	<hr>
	<br>
	
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
				<td style='text-align: left; padding:2%;' colspan="6">${notice['nocCon'] }<br></td>
			</tr>
		</tbody>
	</table>
	<br>
	<button type="button" class="btn btn-outline-secondary gotoList" style="float: left; margin-left: 37.5%; width:25%; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">목록</button>
	<br>
</div>
<script>
	
	//취소버튼 선언(리스트페이지로 이동)
	let cancelButton = $(".gotoList");
	cancelButton.click(function onclick(){
	   location.href="${cPath}/groupware/board/noticeList.do";       
	});
	
</script>