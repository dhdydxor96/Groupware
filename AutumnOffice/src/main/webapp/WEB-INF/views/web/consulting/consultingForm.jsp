<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>

<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
.id_ok{
color:#008000;
display: none;
}

.id_already{
color:#6A82FB; 
display: none;
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
	<!-- -------------------------- -->
   	 <!-- 서비스 신청하기 회사 정보 입력 페이지(웹페이지) -->
   	<!-- -------------------------- -->
<br><br>
<h1 id = "app-3" style="color:black; font-size:60px;">서비스 신청하기 (정보 입력)</h1>
<br><br>
<form:form id="formId" method="post" modelAttribute="consulting">
	<table class="table table-bordered" style="width:50%; margin-left:25%; text-align:center;">
    		<tr>
    			<th>담당자명</th>
    			<td>
    				<form:input path="comNm" required="true" class="form-control" placeholder="담당자명" value="담당자"/>
    				<form:errors path="comNm" element="span" cssClass="error" />
    			</td>
    		</tr>
    		<tr>
    			<th>담당자 전화번호</th>
    			<td>
    				<form:input path="comPh" required="true" class="form-control" placeholder="담당자 전화번호" value="010-0000-0000"/>
    				<form:errors path="comPh" element="span" cssClass="error" />
    			</td>
    		</tr>
    		<tr>
    			<th>담당자 이메일</th>
    			<td>
    				<form:input path="comMail" required="true" class="form-control" placeholder="담당자 이메일" value="test@naver.com"/>
    				<form:errors path="comMail" element="span" cssClass="error" />
    			</td>
    		</tr>
	</table>
	<table class="table table-bordered" style="width:50%; margin-left:25%; text-align:center;">
			<tr>
    			<th>회사영문명</th>
    			<td>
    				<input class="form-control" type="text" id="comCode" name="comCode" style="float: left; width: 75%;" placeholder="회사영문명" value="test0111"/>
    				<button class="btn btn-success" type="button" id="codeChk" onclick="fn_codeChk();" value="N" style="float: left; width: 20%;font-weight:bold; margin-left: 5%; font-family: 'IBM Plex Sans KR', sans-serif;">중복확인</button>
    			</td>
    		</tr>
    		<tr>
    			<th>회사한글명</th>
    			
    			<td>
    				<form:input path="comCnm" required="true" class="form-control" placeholder="회사한글명" value="테스트회사"/>
    				<form:errors path="comCnm" element="span" cssClass="error" />
    			</td>
    		</tr>
    		<tr>
    			<th>대표자</th>
    			<td>
    				<form:input path="comCeo" required="true" class="form-control" placeholder="대표자" value="테스트 대표자"/>
    				<form:errors path="comCeo" element="span" cssClass="error" />
    			</td>
    		</tr>
    		<tr>
    			<th>회사 전화번호</th>
    			<td>
    				<form:input path="comTel" required="true" class="form-control" placeholder="회사 전화번호" value="02-423-4562"/>
    				<form:errors path="comTel" element="span" cssClass="error" />
    			</td>
    		</tr>
    		<tr>
    			<th>회사 사업자번호</th>
    			<td>
    				<form:input path="comCorporate" required="true" class="form-control" placeholder="회사 사업자번호" value="132-45681-4351"/>
    				<form:errors path="comCorporate" element="span" cssClass="error" />
    			</td>
    		</tr>
    		<tr>
    			<th>회사 도메인주소</th>
    			<td>
    				<form:input path="comDomain" required="true" class="form-control" placeholder="회사 도메인주소" value="testCompany@testCompany.com"/>
    				<form:errors path="comDomain" element="span" cssClass="error" />
    			</td>
    		</tr>
    		<tr>
    			<th>회사 주소</th>
    			<td>
    				<form:input path="comAddr" required="true" class="form-control" placeholder="회사 주소" value="대전시 오류동"/>
    				<form:errors path="comAddr" element="span" cssClass="error" />
    			</td>
    		</tr>
	</table>
	<table class="table table-bordered" style="width:50%; margin-left:25%; text-align:center;">
    		<tr>
    			<th>관리자 아이디</th>
    			<td>
    				<input class="form-control" type="text" id="comId" name="comId" style="float: left; width: 75%;" placeholder="마스터 아이디" value="master011"/>
    				<button class="btn btn-success" type="button" id="idChk" onclick="fn_idChk();" value="N" style="float: left; width: 21%; margin-left: 3%; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">중복확인</button>
    			</td>
    		</tr>
    		<tr>
    			<th>관리자 비밀번호</th>
    			<td>
    				<form:input type="password" path="comPass" required="true" class="form-control" placeholder="마스터 비밀번호" name="userPW" id="pw" onchange="check_pw()"/>
    				<form:errors path="comPass" element="span" cssClass="error" />
    			</td>
    		</tr>
    		<tr>
    			<th>관리자 비밀번호 확인</th>
    			<td>
    				<input class="form-control" type="password" name="userPW2" id="pw2" onchange="check_pw()">&nbsp;<span id="check"></span>
    			</td>
    		</tr>
    		<tr id = "formTr">
				<td colspan="2" >
					<form:button type="submit" id="formBtn" class="btn btn-success" style="width: 30%; margin-left: 23%; float: left; margin-right: 2%; font-size: 20px; font-weight: bold;">서비스 신청하기</form:button>
					<form:button type="reset" class="btn btn-danger" style="width: 20%; font-size: 20px; font-weight: bold;">취소</form:button>
				</td>
			</tr>
	</table>
</form:form>
<script>
	<!-- -------------------------- -->
	 <!-- 마스터 계정 비밀번호 유효성 체크 기능 -->
	<!-- -------------------------- -->
        function check_pw(){
            var pw = document.getElementById('pw').value;
            var SC = ["!","@","#","$","%"];
            var check_SC = 0;
 
            if(pw.length < 6 || pw.length>16){
            	toastr.info('비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.');
                document.getElementById('pw').value='';
            }
            for(var i=0;i<SC.length;i++){
                if(pw.indexOf(SC[i]) != -1){
                    check_SC = 1;
                }
            }
            if(check_SC == 0){
                toastr.info('!,@,#,$,% 의 특수문자가 들어가 있지 않습니다.')
                document.getElementById('pw').value='';
            }
            if(document.getElementById('pw').value !='' && document.getElementById('pw2').value!=''){
                if(document.getElementById('pw').value==document.getElementById('pw2').value){
                    document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
                    document.getElementById('check').style.color='blue';
                }
                else{
                    document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';
                    document.getElementById('check').style.color='red';
                }
            }
        }
        
        $("#formTr").hide();
        let num = 0;
        
        <!-- -------------------------- -->
      	 <!-- 마스터 아이디 중복 체크 기능 -->
      	<!-- -------------------------- -->
		function fn_idChk(){
			$.ajax({
				url : "${cPath}/web/consulting/idChk",
				type : "post",
				dataType : "json",
				data : {"comId" : $("#comId").val()},
				success : function(data){
					if(data == 1){
						toastr.error("중복된 아이디입니다.");
						$("#formTr").hide();
					}else if(data == 0){
						$("#idChk").attr("value", "Y");
						num += 1;
						toastr.info("사용가능한 아이디입니다.");
						if(num == 2){
							$("#formTr").show();
						}
					}
				}
			})
		}
		<!-- -------------------------- -->
	   	 <!-- 회사 영문명 중복 체크 기능 -->
	   	<!-- -------------------------- -->
		function fn_codeChk(){
			$.ajax({
				url : "${cPath}/web/consulting/codeChk",
				type : "post",
				dataType : "json",
				data : {"comCode" : $("#comCode").val()},
				success : function(data){
					if(data == 1){
						toastr.error("중복된 회사명입니다.");
					}else if(data == 0){
						$("#codeChk").attr("value", "Y");
						num += 1;
						toastr.info("사용가능한 회사명입니다.");
						if(num == 2){
							$("#formTr").show();
						}
					}
				}
			})
		}
		

    </script>

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    