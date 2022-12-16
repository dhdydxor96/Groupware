<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>

<style>
	input {
		margin : 1%;
		height: 40%;
	}
	.card{
		padding : 1%;
	}
	@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
	td{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	th{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	button{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight: bold;
	}
</style>

<!-- -------------------------- -->
<!--    관리자페이지 - 회의실 수정        -->
<!-- -------------------------- -->
<div class="card md-3">

	<h4 style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight:bold; font-size:30px;margin-top:1%"><span class="fas fa-chalkboard-teacher"></span>&nbsp;회의실 수정하기</h4>
	<hr>
	
	<form action="${cPath}/management/menu/resourceManageUpdate.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	<input type="hidden" name="meetNo" value="${meetInfo.meetNo }" />
	<table class="table">
		<tr>
			<td colspan="4" style="width: 50%;height: 40%">
				<c:url var="imageViewURL" value="/groupware/resource/resourceImageView.do">
					<c:param name="what" value="${meetInfo.meetNo }"></c:param>
				</c:url>
				<img src="${imageViewURL}" id="previewImg" alt="회의실사진" style="width: 40%;height: 40%;margin-left:29%;margin-bottom:1%">
			</td>
		</tr>
		<tr style="border-top: none;">
			<th colspan="1">사진 변경하기</th>
			<td style="height: 70%" colspan="3">
				<input class="form-control" id="customFile" type="file" name="meetFiles" onchange="PreviewImage();" />
			</td>
		</tr>
		<tr>
			<th colspan="1">회의실 이름</th>
			<td colspan="3" style="height: 70%">
				<input  class="form-control" type="text" name="meetNm" value="${meetInfo['meetNm']}" >
			</td>
		</tr>
		<tr>
			<th colspan="1">위치</th>
			<td colspan="3" style="height: 70%">
				<input  class="form-control" type="text" name="meiPla" value="${meetInfo['meiPla']}" >
			</td>
		</tr>
		<tr>
			<th colspan="1">회의실 수용인원</th>
			<td colspan="3" style="height: 70%">
				<input  class="form-control" type="number" name="meiPer" value="${meetInfo['meiPer']}" >
			</td>
		</tr>
		<tr>
			<th style="text-align: center;"><span data-bs-toggle="tooltip" data-bs-placement="top" title="빔프로젝터"><span class="fas fa-video"></span></span></th>
			<th style="text-align: center;"><span data-bs-toggle="tooltip" data-bs-placement="top" title="스크린"><span class="fas fa-chalkboard-teacher" ></span></span></th>
			<th style="text-align: center;"><span data-bs-toggle="tooltip" data-bs-placement="top" title="화이트보드"><span class="fas fa-chalkboard" ></span></span></th>
			<th style="text-align: center;"><span data-bs-toggle="tooltip" data-bs-placement="top" title="사무용품"><span class="fas fa-pen-alt" ></span></span></th>
		</tr>
		<tr>
			<td style="text-align: center;">
				<c:if test="${meetInfo['meiBeam'] == 'Y'}">
					<label for="meiBeam1">보유</label>
					<input type="radio" id="meiBeam1" name="meiBeam" value="Y" checked  >&nbsp;
					<label for="meiBeam2">미보유</label>
					<input type="radio" id="meiBeam2" name="meiBeam" value="N"  >
				</c:if>
				<c:if test="${meetInfo['meiBeam'] == 'N'}">
					<label for="meiBeam1">보유</label>
					<input type="radio" id="meiBeam1" name="meiBeam" value="Y"   >&nbsp;
					<label for="meiBeam2">미보유</label>
					<input type="radio" id="meiBeam2" name="meiBeam" value="N" checked >
				</c:if>
			</td>
			<td style="text-align: center;">
				<c:if test="${meetInfo['meiScr'] == 'Y'}">
					<label for="meiScr1">보유</label>
					<input type="radio" id="meiScr1" name="meiScr" value="Y" checked >&nbsp;
					<label for="meiScr2">미보유</label>
					<input type="radio" id="meiScr2" name="meiScr" value="N"  >
				</c:if>
				<c:if test="${meetInfo['meiScr'] == 'N'}">
					<label for="meiScr1">보유</label>
					<input type="radio" id="meiScr1" name="meiScr" value="Y"  >&nbsp;
					<label for="meiScr2">미보유</label>
					<input type="radio" id="meiScr2" name="meiScr" value="N" checked >
				</c:if>
			</td>
			<td style="text-align: center;">
				<c:if test="${meetInfo['meiBod'] == 'Y'}">
					<label for="meiBod1">보유</label>
					<input type="radio" id="meiBod1" name="meiBod" value="Y" checked >&nbsp;
					<label for="meiBod2">미보유</label>
					<input type="radio" id="meiBod2" name="meiBod" value="N"  >
				</c:if>
				<c:if test="${meetInfo['meiBod'] == 'N'}">
					<label for="meiBod1">보유</label>
					<input type="radio" id="meiBod1" name="meiBod" value="Y"  >&nbsp;
					<label for="meiBod2">미보유</label>
					<input type="radio" id="meiBod2" name="meiBod" value="N" checked >
				</c:if>
			</td>
			<td style="text-align: center;">
				<c:if test="${meetInfo['meiItem'] == 'Y'}">
					<label for="meiItem1">보유</label>
					<input type="radio" id="meiItem1" name="meiItem" value="Y" checked >&nbsp;
					<label for="meiItem2">미보유</label>
					<input type="radio" id="meiItem2" name="meiItem" value="N"  >
				</c:if>
				<c:if test="${meetInfo['meiItem'] == 'N'}">
					<label for="meiItem1">보유</label>
					<input type="radio" id="meiItem1" name="meiItem" value="Y"  >&nbsp;
					<label for="meiItem2">미보유</label>
					<input type="radio" id="meiItem2" name="meiItem" value="N" checked  >
				</c:if>
			</td>
		</tr>
		
	</table>
	<br>
	<div>
		<c:url var="backURL" value="/management/menu/resourceManageView.do">
			<c:param name="what" value="${meetInfo.meetNo }" ></c:param>
		</c:url>
		<button type="submit" class="btn btn-outline-primary me-1 mb-1" style="float:left; width:23%; margin-left:25%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">수정</button>
		<a href="${backURL}" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="float: left; width: 23%; margin-left: 4%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">취소</a>
	</div>
	</form>
</div>


<script>
	//========================================================
	// INPUT 태그에서 파일을 선택했을 때 미리보기 형식으로 띄우기
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