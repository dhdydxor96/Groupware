<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
<!-- <script src ="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
#cloud{
	text-align:center;
	margin-left:35%;
    border: 1px solid #dee2e6;
    width: 30%;
    font-size: 20px;
    font-weight: bold;
    font-family: 'IBM Plex Sans KR', sans-serif';
}
th{
width:30%;
}

#choiceService{
	FLOAT: left;
    width: 70%;
    font-size: 17px;
    font-weight: bold;
    margin-bottom: 2%;
}
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
<br>
<br>
	<!-- -------------------------- -->
   	 <!-- 서비스 신청하기 멤버십 가입 페이지(웹페이지) -->
   	<!-- -------------------------- -->
<h1 id="app-3" style="color: black; font-size: 60px;">서비스 신청하기
	(멤버십)</h1>
	<br><br>
	<h3 style="color:red;">※주의사항※</h3>
	<p style="color:red;">
	서비스 신청후 결제가 진행되면 환불은 불가능하오니, 
	<br>심사숙고하여 결제를 진행해주시길 바랍니다.
	</p>
	<br>
<br>
<hr>
<br>
<h3>서비스 종류</h3>
<br>
<table id="cloud">
	<tr>
		<td><h3>클라우드 공유형</h3></td>
	</tr>
	<tr>
		<td><p>1인 1GB 기준/월</p></td>
	</tr>
	<tr>
		<td><h2>￦ 3,000</h2></td>
	</tr>
	<tr>
		<td>사용자</td>
	</tr>
	<tr>
		<td>총 10명(10명 이상부터 가능)</td>
	</tr>
	<tr>
		<td>사용 기간</td>
	</tr>
	<tr>
		<td>
		<select class="form-select" name="service" id="service" >
	    	<option class="option_slt" selected="selected" value="1개월">1개월</option>
	    	<option class="option_slt" value="2">12개월(월 100원 할인)</option>
	    	<option class="option_slt" value="3">24개월(월 300원 할인)</option>
	    </select>
	    </td>
	</tr>
</table>
<br>
<hr>
<br>
<h2>멤버십 가입 폼</h2>
<br>
<form:form id="formId" method="post" modelAttribute="consultingService" action="${cPath}/web/consulting/consultingService.do">
		<input type="hidden" class="form-control" name="comCode" value="${consulting.comCode }"/>
	<table class="table table-bordered" style="width:50%; margin-left:25%; text-align:center;">
		<tr>
			<th>서비스 이름</th>
			<td>
				<form:input path="serName" class="form-control" value="클라우드 공유형" readonly="true"/>
    			<form:errors path="serName" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>사용자 수</th>
			<td>
				<input type="number" id="empNum" name="serEmp" min="10" value="10" class="form-control">
			</td>
		</tr>
		<tr>
			<th>서비스 이용기간</th>
			<td>
				<select class="form-select" name="choiceService" id="choiceService" onchange="choiceServiceChange(this.value);">
			    	<option class="option_slt" id="choice1" value="">서비스 이용기간을 선택하시오</option>
			    	<option class="option_slt" id="choice2" value="1개월">1개월</option>
			    	<option class="option_slt" id="choice3" value="12개월(월 100원 할인)">12개월(월 100원 할인)</option>
			    	<option class="option_slt" id="choice4" value="24개월(월 300원 할인)">24개월(월 300원 할인)</option>
	    		</select>
				<input type="text" id="selectInput" name="serPeri" class="form-control" readonly="readonly">
			</td>
		</tr>
		<tr>
			<th>서비스 시작일</th>
			<td>
				<input type="text" name="serStd" id="startService" class="form-control" readonly="readonly">
			</td>
		</tr>
		<tr>
			<th>서비스 종료일</th>
			<td>
				<input type="text" name="serEnd" id="endService" class="form-control" readonly="readonly">
			</td>
		</tr>
		<tr>
			<th>결제 금액</th>
			<td>
				<input type="number" name="servicePay" id="resultPay" class="form-control" readonly="readonly" >
			</td>
		</tr>
		<tr>
			<td colspan="2" >
				<input type="button" id="formBtn" class="btn btn-success" style="width: 26%; margin-left: 26%; float: left; margin-right: 2%; font-size: 20px; font-weight: bold;" value="서비스 신청하기">
				<form:button type="reset" class="btn btn-danger" style="width: 20%; font-size: 20px; font-weight: bold;">취소</form:button>
			</td>
		</tr>
	</table>
</form:form>
<form>
<input type="hidden" value = "${resultmsg}" id="resultmsg">
</form>

<script>
	
payment = 0;

var choiceServiceChange = function(value) {
	$("#selectInput").val(value);
	
}

<!-- -------------------------- -->
<!-- 데이트 포맷 및 계산 기능 -->
<!-- -------------------------- -->

function dateFormat(date) {
	let dateFormat2 = date.getFullYear() +
		'-' + ( (date.getMonth()+1) < 9 ? "0" + (date.getMonth()+1) : (date.getMonth()+1) )+
		'-' + ( (date.getDate()) < 9 ? "0" + (date.getDate()) : (date.getDate()) );
	return dateFormat2;
}

function dateCalculator(date, n) {
	return new Date(date.setDate(date.getDate() + n));
}

<!-- -------------------------- -->
<!-- script date TO_CHAR 형태로 바꾸는 기능 -->
<!-- -------------------------- -->

function StringToDate(date, n) {
	let yyyy = date.substring(0, 4);
	let mm = date.substring(5, 7);
	let dd = date.substring(8, 10);
	mm = Number(mm) - 1;
    
	let stringNewDate = new Date(yyyy, mm, dd);
	stringNewDate.setDate(stringNewDate.getDate() + n);
    
	return stringNewDate.getFullYear() +
		"-" + ((stringNewDate.getMonth() + 1) > 9 ? (stringNewDate.getMonth() + 1).toString() : "0" + (stringNewDate.getMonth() + 1)) +
		"-" + (stringNewDate.getDate() > 9 ? stringNewDate.getDate().toString() : "0" + stringNewDate.getDate().toString());
}

	<!-- -------------------------- -->
	<!-- 서비스 이용기간 체크시 사용기간 반영 및 결제 금액 반영 기능 -->
	<!-- -------------------------- -->
	
$("#choiceService").change(function(){
	
	console.log($("#choiceService option:selected").attr('id'));
	
	let ServiceOption = $("#choiceService option:selected").attr('id');
	
	let num = document.getElementById("empNum").value;
	
	let today = new Date();
	
	let dateFormat2 = today.getFullYear() +
	'-' + ( (today.getMonth()+1) < 9 ? "0" + (today.getMonth()+1) : (today.getMonth()+1) )+
	'-' + ( (today.getDate()) < 9 ? "0" + (today.getDate()) : (today.getDate()) );
	
	let startDate = dateFormat(new Date());
	let endDate = dateFormat(new Date());
	
	
	$('#startService').val(startDate);
	if(ServiceOption == "choice2"){
		payment = 10;
		document.getElementById("resultPay").value = num * payment;
		endDate = StringToDate(startDate, 30);

	    $('#endService').val(endDate);
	}else if(ServiceOption == "choice3"){
		payment = 10;		
		document.getElementById("resultPay").value = num * payment * 12;
		endDate = StringToDate(startDate, 365);
		
	    $('#endService').val(endDate);
	}else if(ServiceOption == "choice4"){
		payment = 10;
		document.getElementById("resultPay").value = num * payment * 24;
		endDate = StringToDate(startDate, 730);
		
	    $('#endService').val(endDate);
	}
	
});


//결제 후 커밋되는 로직
$(document).on("click","#formBtn", function(){

	
		let IMP = window.IMP;
		let code = "imp25348730"; //가맹점 식별코드
		console.log("IMP:",IMP);
		
		IMP.init(code);
			//결제요청
			IMP.request_pay({
				//name과 amout만있어도 결제 진행가능
				pg : 'html5_inicis', //pg사 선택 (kakao, kakaopay 둘다 가능)
// 				pg : 'kakaopay',
				pay_method: 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : $("#serName").val()+" "+$("#selectInput").val(), // 상품명
				amount : $("#resultPay").val(),
				buyer_email : "${consulting.comMail}",
				buyer_name : "${consulting.comNm}",
				buyer_tel : "${consulting.comTel}",  //필수항목
			
			}, function(rsp){
				if(rsp.success){//결제 성공시
					let msg = '결제가 완료되었습니다!';
					console.log("rsp",rsp);
					let result =""; 
					result += '결제자 : '+rsp.buyer_name+"\n";
					result += '구매상품 : '+rsp.name+"\n";
					result += '결제 금액 : ' + rsp.paid_amount+"\n";
					result += '고유ID : ' + rsp.imp_uid+"\n";
					result += '상점 거래ID : ' + rsp.merchant_uid+"\n";
					result += '결제카드 : ' + rsp.card_name+"\n";
					result += '카드번호 : ' + rsp.card_number+"\n";
					result += '카드 승인번호 : ' + rsp.apply_num+"\n";
					
					confirm(msg, result, "success");

				}
				else{//결제 실패시
					let msg = '결제에 실패했습니다';
					swal(msg, "다시 시도해주세요!", "warning");
				}
					
				console.log(msg);
			});//pay

			return false;
	});

let confirm = function(title, msg, resvNum) {
	swal({
		title : title,
		text : msg,
		type : "success",
		showCancelButton : false,
		confirmButtonClass : "btn-danger",
		confirmButtonText : "확인",
		closeOnConfirm : false,
		closeOnCancel : false
	}, function(isConfirm) {
		if (isConfirm) {
			$("#formId").submit();
		}else{
			$("#formId").submit();
		}

	});
}
</script>
<c:if test="${not empty resultmsg}">
<script>
	message = $("#resultmsg").val();

	toastr.info(message);
</script>
</c:if>

























