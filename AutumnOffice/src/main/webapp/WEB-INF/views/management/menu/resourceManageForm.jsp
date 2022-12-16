<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
	input {
		margin : 1%;
	}
	.card {
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
<!--   관리자페이지 - 회의실 등록        -->
<!-- -------------------------- -->
<div class="card md-3">
	<h4 style="font-family: 'IBM Plex Sans KR', sans-serif;font-weight:bold; font-size:30px;margin-top:1%"><span class="fas fa-chalkboard-teacher"></span>&nbsp;회의실 등록하기</h4>
	<hr>

	<form method="post" action="${cPath }/management/menu/resoureManageInsert.do" enctype="multipart/form-data">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		<table class="table">
			<tr>
				<td colspan="2"  style="width: 50%;height: 20%">
					<img  id="previewImg" style="width: 40%;height: 40%;margin-left:29%;margin-bottom:1%" />
				</td>
			</tr>
			<tr>
				<th>회의실 이미지</th>
				<td style="height: 70%">
					<input class="form-control" id="customFile" type="file" name="meetFiles"  onchange="PreviewImage();" required />
				</td>
			</tr>
			<tr>
				<th>회의실 이름</th>
				<td style="height: 70%"><input class="form-control" type="text" name="meetNm" required value="그린스터디" >${meetInfo['meetNm']}</td>
			</tr>
			<tr>
				<th>위치</th>
				<td style="height: 70%"><input class="form-control" type="text" name="meiPla" required value="네이버 제1사옥 5층" >${meetInfo['meiPla']}</td>
			</tr>
			<tr>
				<th>회의실 수용인원</th>
				<td style="height: 70%"><input class="form-control" type="number" name="meiPer" required value="200">${meetInfo['meiPer']}</td>
			</tr>
			<tr>
				<th>빔프로젝트</th>
				<td style="height: 70%">
					<label for="meiBeam1">보유</label>
					<input type="radio" id="meiBeam1" name="meiBeam" value="Y" required checked >&nbsp;
					<label for="meiBeam2">미보유</label>
					<input type="radio" id="meiBeam2" name="meiBeam" value="N" required >
				</td>
			</tr>
			<tr>
				<th>스크린</th>
				<td style="height: 70%">
					<label for="meiScr1">보유</label>
					<input type="radio" id="meiScr1" name="meiScr" value="Y" required >&nbsp;
					<label for="meiScr2">미보유</label>
					<input type="radio" id="meiScr2" name="meiScr" value="N" required checked >
				</td>
			</tr>
			<tr>	
				<th>화이트보드</th>
				<td style="height: 70%">
					<label for="meiBod1">보유</label>
					<input type="radio" id="meiBod1" name="meiBod" value="Y" required checked >&nbsp;
					<label for="meiBod2">미보유</label>
					<input type="radio" id="meiBod2" name="meiBod" value="N" required >
				</td>
			</tr>
			<tr>
				<th>사무용품</th>				
				<td style="height: 70%">
					<label for="meiItem1">보유</label>
					<input type="radio" id="meiItem1" name="meiItem" value="Y" required checked >&nbsp;
					<label for="meiItem2">미보유</label>
					<input type="radio" id="meiItem2" name="meiItem" value="N" required >
				</td>
			</tr>
		</table>
		<br>
		<div>
			<button type="submit" class="btn btn-outline-primary me-1 mb-1" style="float:left; width:25%; margin-left:25%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">회의실 등록</button>
			<a href="${cPath}/management/menu/resourceManage.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="float: left; width: 25%; margin-left: 4%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">취소</a>
	</div>
	</form>
	<br>
</div>


<script>
	//========================================================
	// input file 태그에서 파일을 선택했을 때 미리보기 형식으로 띄우기
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