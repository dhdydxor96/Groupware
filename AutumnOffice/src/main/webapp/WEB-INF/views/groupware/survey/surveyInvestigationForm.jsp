<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}

#r1{
	font-family: 'IBM Plex Sans KR', sans-serif; 
	font-weight: bold;
}
</style>
<div class="card mb-3" style="padding:1%; text-align: center; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<h3 style="font-weight: bold; font-size:30px; font-family: 'IBM Plex Sans KR', sans-serif; text-align:left;"><span class="fas fa-chart-pie"></span>&nbsp;설문 조사 등록</h3>
	<hr>
	<br>
	<form:form method="post" modelAttribute="surveyInvestigation" enctype="multipart/form-data">
		<table id="myTable" class="table table-bordered" style="vertical-align: middle; width: 90%; margin-left: 5%; ">
		<tr>
			<th>설문 제목</th>
			<td>
				<form:select path="surNo" id="s1" onchange="optionChange();" required="true" class="form-select"  style="font-family: 'IBM Plex Sans KR', sans-serif; ">
					<option value></option>
					<c:forEach items="${surveyList }" var="survey">
						<form:option value="${survey.surNo }" label="${survey.surTitle }" />
					</c:forEach>
				</form:select>
				<form:errors path="surNo" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>문항 내용</th>
			<td>
				<form:select path="surqueNo" id="s2" required="true" class="form-select"  style="font-family: 'IBM Plex Sans KR', sans-serif; ">
					<option value></option>
					<c:forEach items="${surveyQuestionList }" var="surveyQuestion">
					
						<form:option value="${surveyQuestion.surqueNo }" label="${surveyQuestion.surqueContent }" />
					</c:forEach>
				</form:select>
				<form:errors path="surqueNo" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>문항 유형</th>
			<td>
				<input type="radio" name="surinvType" id="r1" value="객관식"><label for="r1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-size : 20px; margin-right:10%;">객관식</label>
 				<input type="radio" name="surinvType" id="r2" value="주관식"><label for="r2" style="font-family: 'IBM Plex Sans KR', sans-serif; font-size : 20px;">주관식</label>
			</td>
		</tr>	
				<tr id="surarcNo1">
					<th>객관식 답변 1번</th>
					<td>
						<form:select path="surinvFirst" name="surarcNo" class="form-control s3"  style="font-family:'IBM Plex Sans KR', sans-serif;  width:65%; float:left; margin-right:5%;">
							<option value>항목 내용</option>
							<c:forEach items="${surveyArticleList }" var="surveyArticle">
								<form:option value="${surveyArticle.surarcContent }" label="${surveyArticle.surarcContent }" />
							</c:forEach>
						</form:select>
						<form:errors path="surinvFirst" element="span" cssClass="error" />
						<input type="button" id="offDisplay1" class="btn btn-outline-secondary me-1 mb-1" style="float:left;" value="항목 지우기">
					</td>
				</tr>
				<tr id="surarcNo2">
					<th>객관식 답변 2번</th>
					<td>
						<form:select path="surinvSecond" name="surarcNo" class="form-control s4"  style="font-family:'IBM Plex Sans KR', sans-serif;  width:65%; float:left; margin-right:5%;">
							<option value>항목 내용</option>
							<c:forEach items="${surveyArticleList }" var="surveyArticle">
								<form:option value="${surveyArticle.surarcContent }" label="${surveyArticle.surarcContent }" />
							</c:forEach>
						</form:select>
						<form:errors path="surinvSecond" element="span" cssClass="error" />
						<input type="button" id="offDisplay2" class="btn btn-outline-secondary me-1 mb-1" style="float:left;" value="항목 지우기">
					</td>
				</tr>
				<tr id="surarcNo3">
					<th>객관식 답변 3번</th>
					<td>
						<form:select path="surinvThird" name="surarcNo" class="form-control s5"  style="font-family:'IBM Plex Sans KR', sans-serif;  width:65%; float:left; margin-right:5%;">
							<option value>항목 내용</option>
							<c:forEach items="${surveyArticleList }" var="surveyArticle">
								<form:option value="${surveyArticle.surarcContent }" label="${surveyArticle.surarcContent }" />
							</c:forEach>
						</form:select>
						<form:errors path="surarcNo" element="span" cssClass="error" />
						<input type="button" id="offDisplay3" class="btn btn-outline-secondary me-1 mb-1" style="float:left;" value="항목 지우기">
					</td>
				</tr>
				<tr id="surarcNo4">
					<th>객관식 답변 4번</th>
					<td>
						<form:select path="surinvFour" name="surarcNo" class="form-control s6"  style="font-family:'IBM Plex Sans KR', sans-serif; width:65%; float:left; margin-right:5%;">
							<option value>항목 내용</option>
							<c:forEach items="${surveyArticleList }" var="surveyArticle">
								<form:option value="${surveyArticle.surarcContent }" label="${surveyArticle.surarcContent }" />
							</c:forEach>
						</form:select>
						<form:errors path="surinvFour" element="span" cssClass="error" />
						<input type="button" id="offDisplay4" class="btn btn-outline-secondary me-1 mb-1" style="float:left;" value="항목 지우기">
					</td>
				</tr>
				<tr id="surarcNo5">
					<th>객관식 답변 5번</th>
					<td>
						<form:select path="surinvFive" name="surarcNo" class="form-control s7"  style="font-family:'IBM Plex Sans KR', sans-serif;  width:65%; float:left; margin-right:5%;">
							<option value>항목 내용</option>
							<c:forEach items="${surveyArticleList }" var="surveyArticle">
								<form:option value="${surveyArticle.surarcContent }" label="${surveyArticle.surarcContent }" />
							</c:forEach>
						</form:select>
						<form:errors path="surinvFive" element="span" cssClass="error" />
						<input type="button" id="offDisplay5" class="btn btn-outline-secondary me-1 mb-1" style="float:left;" value="항목 지우기">
					</td>
				</tr>
		<tr id="surinvAnswer">
			<th>주관식 답변 내용</th>
			<td>
				<textarea rows="5" cols="50" name="surinvAnswer" class="form-control" style="font-family: 'IBM Plex Sans KR', sans-serif; "></textarea>
			</td>
		</tr>
		</table>
		<br>
				<form:button type="submit" class="btn btn-outline-primary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; width: 25%;font-size: 15px;font-weight: bold;">설문 조사 등록</form:button>
				<a href="${cPath }/groupware/survey/surveyInvestigationList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold; width: 25%; margin-left:5%;">취소</a>
	</form:form>
	<br>	
</div>
<script>
function optionChange(){
	let s2 = $("#s2");
	let surNo = $("#s1 option:selected").val();
	$.ajax({
		url : "${cPath}/groupware/survey/surveyQuestion.do",
		type : "get",
		dataType : "json",
		data : {"surNo" : surNo },
		success : function(surveyQuestionList){
			s2.empty();
			let options = [];
			$.each(surveyQuestionList, function(index, surveyQuestion){
				let option = $("<option>").attr("value", surveyQuestion.surqueNo)
										.text(surveyQuestion.surqueContent);
				options.push(option);
			});
			s2.append(options);
		},error : function(data){
			
		}
	})
}

$("input:radio[name=surinvType]").click(function(){
	if($("input:radio[name=surinvType]:checked").val()=='객관식'){
		let s3 = $(".s3");
		let s4 = $(".s4");
		let s5 = $(".s5");
		let s6 = $(".s6");
		let s7 = $(".s7");
		let surqueNo = $("#s2 option:selected").val();
		console.log("항목번호 : " + surqueNo);
		$.ajax({
			url : "${cPath}/groupware/survey/surveyArticle.do",
			type : "get",
			dataType : "json",
			data : {"surqueNo" : surqueNo },
			success : function(surveyArticleList){
				let options1 = [];
				let options2 = [];
				let options3 = [];
				let options4 = [];
				let options5 = [];
				s3.empty();
				$.each(surveyArticleList, function(index, surveyArticle){
						
						let option = $("<option>").attr("value", surveyArticle.surarcContent)
												.text(surveyArticle.surarcContent);
						options1.push(option);
						
						if(surveyArticle.surarcTurn == 1){
				            $('#surarcNo1').attr('style', "display:'';");							
						}else{
				            $('#surarcNo1').val("");						
						}
					})
				s3.append(options1);

				s4.empty();
				$.each(surveyArticleList, function(index, surveyArticle){
					
						let option = $("<option>").attr("value", surveyArticle.surarcContent)
												.text(surveyArticle.surarcContent);
						options2.push(option);
						
						if(surveyArticle.surarcTurn == 2){
				            $('#surarcNo2').attr('style', "display:'';");							
						}else{
				            $('#surarcNo2').val("");						
						}
					})
				s4.append(options2);
				
				s5.empty();
					$.each(surveyArticleList, function(index, surveyArticle){
						
						let option = $("<option>").attr("value", surveyArticle.surarcContent)
												.text(surveyArticle.surarcContent);
						options3.push(option);
						
						if(surveyArticle.surarcTurn == 3){
				            $('#surarcNo3').attr('style', "display:'';");							
						}else{
				            $('#surarcNo3').val("");						
						}
					})
				s5.append(options3);
					
				s6.empty();
					$.each(surveyArticleList, function(index, surveyArticle){
						
						let option = $("<option>").attr("value", surveyArticle.surarcContent)
												.text(surveyArticle.surarcContent);
						options4.push(option);
						
						if(surveyArticle.surarcTurn == 4){
				            $('#surarcNo4').attr('style', "display:'';");							
						}else{
				            $('#surarcNo4').val("");						
						}
					})
				s6.append(options4);
					
				s7.empty();
					$.each(surveyArticleList, function(index, surveyArticle){
						
						let option = $("<option>").attr("value", surveyArticle.surarcContent)
												.text(surveyArticle.surarcContent);
						options5.push(option);
						
						if(surveyArticle.surarcTurn == 5){
				            $('#surarcNo5').attr('style', "display:'';");							
						}else{
				            $('#surarcNo5').val("");			
						}
					})
				s7.append(options5);
					
					
				if(surveyArticleList.length < 3){
					$('#surarcNo3').empty();
					$('#surarcNo4').empty();
					$('#surarcNo5').empty();
				}else if(surveyArticleList.length < 4){
					$('#surarcNo4').empty();
					$('#surarcNo5').empty();
				}else if(surveyArticleList.length < 5){
					$('#surarcNo5').empty();
				}
					
			},error : function(data){
				
			}
		})
	}
})

$(document).ready(function(){
	$('#surinvAnswer').attr('style', "display:none;");
	$('#surarcNo1').attr('style', "display:none;");
	$('#surarcNo2').attr('style', "display:none;");
	$('#surarcNo3').attr('style', "display:none;");
	$('#surarcNo4').attr('style', "display:none;");
	$('#surarcNo5').attr('style', "display:none;");
    // 라디오버튼 클릭시 이벤트 발생
    $("input:radio[name=surinvType]").click(function(){
 
        if($("input[name=surinvType]:checked").val() == "객관식"){
            $("textarea[name=surinvAnswer]").attr("disabled",true);
            // radio 버튼의 value 값이 객관식이라면 비활성화
//             $('#surarcNo1').attr('style', "display:'';");
//             $('#surarcNo2').attr('style', "display:'';");
//             $('#surarcNo3').attr('style', "display:'';");
//             $('#surarcNo4').attr('style', "display:'';");
//             $('#surarcNo5').attr('style', "display:'';");
            $('#surinvAnswer').attr('style', "display:none;");
 
        }else if($("input[name=surinvType]:checked").val() == "주관식"){
              $("textarea[name=surinvAnswer]").attr("disabled",false);
            // radio 버튼의 value 값이 주관식이라면 활성화
              $('#surarcNo1').attr('style', "display:none;");
              $('#surarcNo2').attr('style', "display:none;");
              $('#surarcNo3').attr('style', "display:none;");
              $('#surarcNo4').attr('style', "display:none;");
              $('#surarcNo5').attr('style', "display:none;");
              $('#surinvAnswer').attr('style', "display:'';");
        }
    });
});

$(function(){
	$('#offDisplay1').click(function() {
		if($("#surarcNo1").css("display")!="none"){
			$('#surarcNo1').hide();
		}	
	});
});
$(function(){
	$('#offDisplay2').click(function() {
		if($("#surarcNo2").css("display")!="none"){
			$('#surarcNo2').hide();
		}	
	});
});
$(function(){
	$('#offDisplay3').click(function() {
		if($("#surarcNo3").css("display")!="none"){
			$('#surarcNo3').hide();
		}	
	});
});
$(function(){
	$('#offDisplay4').click(function() {
		if($("#surarcNo4").css("display")!="none"){
			$('#surarcNo4').hide();
		}	
	});
});
$(function(){
	$('#offDisplay5').click(function() {
		if($("#surarcNo5").css("display")!="none"){
			$('#surarcNo5').hide();
		}	
	});
});


</script>


































