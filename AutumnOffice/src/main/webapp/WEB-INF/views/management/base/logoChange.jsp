<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
	img {
		width:100px;
		height:100px;
	}
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');

}
</style>

<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif;  height: 500px; ">
	<!-- -------------------------- -->
	<!--     메인 로고 변경하기     	    -->
	<!-- -------------------------- -->
	<br>
	<h4 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:30px;"><span class="fas fa-caret-right"></span> 로고 이미지 변경</h4>
	<hr>
	<div style="font-family: 'IBM Plex Sans KR', sans-serif;">메인화면의 로고를 설정합니다.</div>
	<br>
	<form action="${cPath}/management/base/logoChange.do" method="post" enctype="multipart/form-data">
		<div class="p-4 pb-0">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		<table class="table table-bordered" >
			<tr>
				<td style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">현재 로고 이미지</td>
				<td>
					<c:if test="${not empty attatchFnm}">
						${attatchFnm} 
					</c:if>
					<c:if test="${empty attatchFnm}">
						등록된 로고 이미지 없음
					</c:if>
				</td>
				<td rowspan="2" style="width:40%">
						<img class="rounded-soft" style="margin-left:29%" id="previewImg" src="${cPath}/companyLogo/selectCompanyLogoImage.do"
							onerror="this.src='${cPath}/resources/management/assets/img/noImage.png'" />
				</td>
			</tr>
			<tr>
				<td style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;width:25%">변경할 로고 이미지 첨부</td>
				<td><input class="form-control" id="customFile" type="file" name="comFiles" style="margin-top:1%;margin-bottom: 1%" onchange="PreviewImage();" /></td>
			</tr>
		</table>
			<br>
			<br>
			<br>
		</div>
		<div class="modal-footer">
			<button class="btn btn-outline-primary me-1 mb-1" type="submit" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; margin-left:80%;">변경</button>
		</div>
	</form>
	<form>
		<input id="alertMsg" type="hidden" value="${message}" />
	</form>

</div>


<c:if test="${not empty message}">
<script>
	let alertMsg = $("#alertMsg").val();

	console.log(alertMsg);
	
	toastr.info(alertMsg);
</script>
</c:if>

<script>
//========================================================
// 파일 선택했을 때 미리보기 형식으로 띄우기
//======================================================== 
function PreviewImage() {
    // 파일리더 생성 
    var preview = new FileReader();
    preview.onload = function (e) {
    // img id 값 
    document.getElementById("previewImg").src = e.target.result;
};
// input id 값 
preview.readAsDataURL(document.getElementById("customFile").files[0]);
};
</script>


