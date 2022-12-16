<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" defer="defer" ></script>    
    
<style>
	#backgroundDiv {
		width: 85%;
		height: 800px;
		background: white;
		float: left;
		padding : 5px;
		position: relative;
		text-align: center;

	}
	
	.tableAddress{
		border-collapse: separate;
		border-spacing: 0 20px;
		margin-left: auto; 
		margin-right: auto;
		margin-top: -30px;
		
	}
	
	.addrSet{
		position: relative;
		top: 40px;
		right:450px;
	}
	
	.setAddress{
		width: 200px;
	}
	
	.avatar-4xl{
		position: relative;
		right:70px;
	}
	
	#formFileSm{
		position: relative;
		width: 200px;
		height: 28px;
		font-size: 0.4em;
		top: 61px;
		left: 215px;
	}
	#formButtonSm{
		position: relative;
		width: 70px;
		height: 25px;
		font-size: 0.4em;
		top: 89px;
		right: -15px;
	}
	
</style>

<div id="backgroundDiv">
	<h5 class="addrSet">연락처 추가</h5><br><br>
	<hr>
	<form>
		<table class="tableAddress">
			<tr>
				<th class="setAddress">사진</th>
				<td class="avatar avatar-4xl">
  					<img class="rounded-circle" src="../assets/img/team/1.jpg" />
				</td>
			</tr>
			<tr><input class="form-control-sm" id="formFileSm" type="file"></tr>
			<tr><input class="form-sm" id="formButtonSm" type="button" value="삭제"></tr>
			<tr>
				<th class="setAddress">이름</th>
				<td><input type="text" class="form-control"></td>
			</tr>
			<tr>
				<th class="setAddress">생년월일</th>
				<td><input type="text" class="form-control"></td>
			</tr>
			<tr>
				<th class="setAddress">이메일</th>
				<td><input type="text" class="form-control"></td>
			</tr>
			<tr>
				<th class="setAddress">전화번호</th>
				<td><input type="text" class="form-control"></td>
			</tr>
			<tr>
				<th class="setAddress">주소</th>
				<td><input type="text" class="form-control"></td>
			</tr>
			<tr>
				<th class="setAddress">입사일</th>
				<td><input type="text" class="form-control"></td>
			</tr>
			<tr>
				<th class="setAddress">퇴사일</th>
				<td><input type="text" class="form-control"></td>
			</tr>
		</table>
		<br>
		<button type="button" class="btn btn-outline-danger cancelInsertAddress">취소</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="button" class="btn btn-outline-info">추가</button>
	</form>
</div>
<script>
	// 주소록 등록하기 addAddress 선언	현재는 그냥 주소로 이동이지만 개발시 form submit 해줘야 함.
	let cancelInsertAddress = $(".cancelInsertAddress");
	cancelInsertAddress.click(function javascript_onclikc(){
	   location.href="${cPath }/groupware/address/addressList.do";       
	});
</script>