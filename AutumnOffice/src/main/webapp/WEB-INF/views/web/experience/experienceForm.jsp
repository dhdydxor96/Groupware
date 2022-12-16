<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
h1{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
h2{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
h3{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
h4{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
h5{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
h6{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
p{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
span{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
</style>	
   	<!-- -------------------------- -->
   	 <!-- 체험하기 페이지(웹페이지) -->
   	<!-- -------------------------- -->
<div class="content">
	<div class="content_head">
    	<br><br><br><br>
		<h1 style="font-size: 75px;">무료 데모체험 신청</h1>
		<h4>Autumn오피스를 온라인에서 바로 체험할 수 있습니다.</h4>
		<br>
	</div>
	
    <div class="wrap_terms" style="margin-left: -7%;">
    	<ul class="list_terms">
    		<li>
    			<label style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;"> 개인정보 수집 및 이용 동의(필수)
    				<input type="checkbox" checked="checked" class="required" id="privacyCheck" name="privacyCheck" placeholder="개인정보 수집 및 이용 동의" style="margin-left: 10px; width: 25px; height: 15px;">
    				<span class="checkmark"></span>	
    			</label>
    			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" id="openModalBtn" style="font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">자세히 보기</button>
    		</li>
    	</ul>
    </div>
    
    <form:form method="post" modelAttribute="experience">
    	<table class="table table-bordered" style="width:50%; margin-left:25%; text-align:center;">
    		<tr>
    			<th>회사명</th>
    			<td>
    				<form:input path="expCom" required="true" class="form-control" placeholder="회사명" value="테스트회사" />
    				<form:errors path="expCom" element="span" cssClass="error" />
    			</td>
    		</tr>
    		<tr>
    			<th>이름</th>
    			<td>
    				<form:input path="expNm" required="true" class="form-control" placeholder="이름" value="테스트"/>
    				<form:errors path="expNm" element="span" cssClass="error" />
    			</td>
    		</tr>
    		<tr>
    			<th>연락처</th>
    			<td>
    				<form:input path="expTel" required="true" class="form-control" placeholder="연락처" value="010-000-000"/>
    				<form:errors path="expTel" element="span" cssClass="error" />
    			</td>
    		</tr>
    		<tr>
    			<th>이메일 주소</th>
    			<td>
    			<div class="form-group email-form">
					 <div class="input-group" style="width: 78%; float: left;">
					 	<form:input path="expMail" class="form-control" name="userEmail1" id="userEmail1" placeholder="이메일" value="dhdydxor15"/>
						<select class="form-control" name="userEmail2" id="userEmail2" >
							<option>@naver.com</option>
							<option>@daum.net</option>
							<option>@gmail.com</option>
							<option>@hanmail.com</option>
							<option>@yahoo.co.kr</option>
						</select>
					</div>
					<div class="input-group-addon">
						<button type="button" class="btn btn-primary" id="mail-Check-Btn" style="width: 20%; float: right; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">본인인증</button>
					</div>
				</div>   
<!--     				<input class="email-button" type="button" value="인증번호 발송"> -->
    			</td>
    		</tr>
    		<tr>
    			<th>인증번호 확인</th>
    			<td>
    			<div class="mail-check-box">
					<input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
					</div>
						<span id="mail-check-warn"></span>
    			</td>
    		</tr>
    		<tr>
    			<td colspan="2">
    				<form:button type="submit" class="btn btn-success" style="width: 30%; margin-left: 35%; font-size: 25px; font-weight: bold;">무료 체험하기</form:button>
    			</td>
    		</tr>
    	</table>
    </form:form>
    <!-- -------------------------- -->
   	 <!-- 개인정보 동의 modal페이지(웹페이지) -->
   	<!-- -------------------------- -->
    <!-- Modal -->
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLongTitle">개인정보 약관</h5>
	      </div>
	      <div class="modal-body">
	        <h2>개인정보 수집 및 이용 동의</h2>
	        <hr>
		        <br>
		        <h5>수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적,
		        <br> 
		        	개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.</h5>
		        <br><br>
		        <h6>
		         [수집 및 이용 목적]
		         <br>
		         - 상담 접수 및 처리
		         <br>
		         - 처리 내역 보관 용도
		         <br>
		         - 중복 상담 확인
		         <br>
		         <br>
		         [항목]
		         <br>
		         (필수) 이메일 주소
		         <br>
		         <br>
		         [보관기간]
		         <br>
		         	수집.이용 동의일로부터 24개월(단,요청 시 삭제)
		        </h6>
		        <br>
		        <hr>
		        <br>
		        <h6>
				        귀하는 위 개인정보 수집 및 이용을 거부할 수 있으나,<br> 
				        동의를 거부하실 경우 상담을 받으실 수 없습니다.<br>
					귀하의 상담 내용은 원활한 상담을 위하여 보관되며,<br>
					홈페이지에 게시된 개인정보처리방침에 따라 처리됩니다.<br>
					무료체험은 신청하신 경우에 1회에 한하여 제공됩니다.
		        </h6>
		        <br>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="closeModalBtn">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
       
<script>
//모달 버튼에 이벤트를 건다.
$('#openModalBtn').on('click', function(){
  $('#exampleModalCenter').modal('show');
});
// 모달 안의 취소 버튼에 이벤트를 건다.
$('#closeModalBtn').on('click', function(){
  $('#exampleModalCenter').modal('hide');
});
// 모달 안의 X 버튼에 이벤트를 건다.
$('#XModalBtn').on('click', function(){
  $('#exampleModalCenter').modal('hide');
});
	<!-- -------------------------- -->
	 <!-- 체험하기 이메일 인증 기능 -->
	<!-- -------------------------- -->
$('#mail-Check-Btn').click(function() {
	const email = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
	console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
	const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
	
	$.ajax({
		type : 'get',
		url : "${cPath}/web/experience/mailCheck?email="+email, // GET방식이라 Url 뒤에 email을 뭍힐수있다.
		success : function (data) {
			console.log("data : " +  data);
			checkInput.attr('disabled',false);
			code =data;
			toastr.info('인증번호가 전송되었습니다.');
		}			
	}); // end ajax
}); // end send email

	<!-- -------------------------- -->
	 <!-- 체험하기 이메일 인증번호 비교 기능 -->
	<!-- -------------------------- -->
// 인증번호 비교 
// blur -> focus가 벗어나는 경우 발생
$('.mail-check-input').blur(function () {
	const inputCode = $(this).val();
	const $resultMsg = $('#mail-check-warn');
	
	if(inputCode === code){
		$resultMsg.html('인증번호가 일치합니다.');
		$resultMsg.css('color','green');
		$('#mail-Check-Btn').attr('disabled',true);
		$('#userEmail1').attr('readonly',true);
		$('#userEmail2').attr('readonly',true);
		$('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
         $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
	}else{
		$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
		$resultMsg.css('color','red');
	}
});
</script>
