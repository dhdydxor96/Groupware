<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
	.card{
		padding: 1%;
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
<!--    관리자페이지 - 회의실 상세       -->
<!-- -------------------------- -->
<div class="card md-3" >
	<div>
		<h4 style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight:bold; font-size:30px;margin-top:1%;float: left;"><span class="fas fa-chalkboard-teacher"></span>&nbsp;회의실 상세정보</h4>
		<c:url var="updateURL" value="/management/menu/resourceManageUpdate.do">
			<c:param name="what" value="${meetInfo.meetNo }" ></c:param>
		</c:url>
		<a href="${updateURL}" class="btn btn-outline-primary me-1 mb-1" style="width:10%; font-weight: bold;margin-top:1%; font-family: 'IBM Plex Sans KR', sans-serif;float: right;">수정</a>
	</div>
	<hr>
	
	<table class="table">
		<tr>
			<td colspan="4" style="width: 50%;height: 40%">
				<c:url var="imageViewURL" value="/groupware/resource/resourceImageView.do">
					<c:param name="what" value="${meetInfo.meetNo }"></c:param>
				</c:url>
				<img src="${imageViewURL}" alt="회의실사진"style="width: 40%;height: 40%;margin-left:29%;margin-bottom:1%">
			</td>
		</tr>
		<tr>
			<th colspan="1">회의실 이름</th>
			<td colspan="3">${ meetInfo.meetRoom.meetNm }</td>
		</tr>
		<tr>
			<th colspan="1">위치</th>
			<td colspan="3">${ meetInfo.meiPla }</td>
		</tr>
		<tr>
			<th>등록일</th><td>${ meetInfo.meetRoom.meetInd }</td>
			<th>수정일</th><td>${ meetInfo.meetRoom.meetUpd }</td>
		</tr>
		<tr>
			<th colspan="1">회의실 수용인원</th>
			<td colspan="3">${ meetInfo.meiPer }</td>
		</tr>
		<tr >
			<th style="width:25%"><span data-bs-toggle="tooltip" data-bs-placement="top" title="빔프로젝터"><span class="fas fa-video"></span></span></th>
			<th style="width:25%"><span data-bs-toggle="tooltip" data-bs-placement="top" title="스크린"><span class="fas fa-chalkboard-teacher" ></span></span></th>
			<th style="width:25%"><span data-bs-toggle="tooltip" data-bs-placement="top" title="화이트보드"><span class="fas fa-chalkboard" ></span></span></th>
			<th style="width:25%"><span data-bs-toggle="tooltip" data-bs-placement="top" title="사무용품"><span class="fas fa-pen-alt" ></span></span></th>
		</tr>
		<tr >
			<td>
				<c:if test="${meetInfo.meiBeam eq 'Y' }">
					<span class="far fa-check-circle" style="color:green"></span>
				</c:if>
				<c:if test="${meetInfo.meiBeam eq 'N' }">
					<span class="far fa-times-circle" style="color:red"></span>
				</c:if>
			</td>
			<td>
				<c:if test="${meetInfo.meiScr eq 'Y' }">
					<span class="far fa-check-circle" style="color:green"></span>
				</c:if>
				<c:if test="${meetInfo.meiScr eq 'N' }">
					<span class="far fa-times-circle" style="color:red"></span>
				</c:if>
			</td>
			<td>
				<c:if test="${meetInfo.meiBod eq 'Y' }">
					<span class="far fa-check-circle" style="color:green"></span>
				</c:if>
				<c:if test="${meetInfo.meiBod eq 'N' }">
					<span class="far fa-times-circle" style="color:red"></span>
				</c:if>
			</td>
			<td>
				<c:if test="${meetInfo.meiItem eq 'Y' }">
					<span class="far fa-check-circle" style="color:green"></span>
				</c:if>
				<c:if test="${meetInfo.meiItem eq 'N' }">
					<span class="far fa-times-circle" style="color:red"></span>
				</c:if>
			</td>
		</tr>
		
	</table>
	<br>
	<div>
		<a href="${cPath}/management/menu/resourceManage.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="float: left; width: 25%; margin-left: 4%; font-weight: bold; margin-left:35%; font-family: 'IBM Plex Sans KR', sans-serif;">목록</a>
	</div>
	<br>

</div>