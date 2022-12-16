<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>   
<style>
	
	#myDrop{
        width: 13%;
        height: 200px;
        border: 1px solid black;
        overflow : scroll;
	    margin-left: 39%;
	    margin-top: 2%;
    }
    #myFile{
    	float : left;
    }
    @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
    th{
    	text-align:center;
    }
</style>

<body>
<!-- popup -->
<c:if test="${popup.popupSta eq 1}">
	<jsp:include page="../base/popup.jsp"/>
</c:if>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif;">
	<br>
	<div>
	<h4 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:30px; float:left;"><span class="fas fa-caret-right"></span> 팝업 공지 관리</h4>
	<form action="/management/base/modifyPopupSta.do" id="setPopup">
    	<security:csrfInput/>
    	<div>
    	<table style="width: 25%;float: left;vertical-align: middle;text-align: left;margin-left: 48%;margin-top: 1%;">
    		<tr>
    			<th rowspan="2">팝업 공지 설정</th>
    			<td>
    				<c:choose>
    					<c:when test="${popup.popupSta eq 1}">
					    	<span style="font-family: 'IBM Plex Sans KR', sans-serif;">활성화</span>
							<input type="radio" name="popupSta" value="1" checked="checked">
							<span style="font-family: 'IBM Plex Sans KR', sans-serif;">비활성화</span>
							<input type="radio" name="popupSta" value="0">
    					</c:when>
    					<c:otherwise>
					    	<span style="font-family: 'IBM Plex Sans KR', sans-serif;">활성화</span>
							<input type="radio" name="popupSta" value="1">
							<span style="font-family: 'IBM Plex Sans KR', sans-serif;">비활성화</span>
							<input type="radio" name="popupSta" value="0" checked="checked">
    					</c:otherwise>
    				</c:choose>
    			</td>
    		</tr>
    	</table>
			<input type="button" id="settingPopup" class="btn btn-outline-primary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left;" value="설정"/>
		</div>
    </form>
	</div>
	<hr>
	<div style="font-family: 'IBM Plex Sans KR', sans-serif;">메인화면의 팝업공지를 설정합니다.</div>
	<br>
	<form action="?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" id="registForm">
		<div class="p-4 pb-0">
		<table class="table table-bordered" style="width: 90%; margin-left: 5%; vertical-align: middle; text-align:left;" >
			<tr>
				<th>제목</th>
				<td>
		        	<input type="text" id="popupTitle" class="form-control" name="popupTitle"  value="2022년 송년회 안내" style="margin-top:1%; margin-bottom:1%;">
				</td>
			</tr>
			<tr>
				<th style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;" >팝업 이미지 미리보기
				</th>
				<td>
					<input type="file" id="myFile" name="popImage" value="" style="margin-top:1%;"><br><br>
					<div style="float:left;">
						<c:choose>
							<c:when test="${popup.attatch.attSnm != null and not empty popup.attatch.attSnm}">
							    <c:url var="imageViewURL" value="/management/menu/popUpImageView.do"></c:url>
								<img src="${imageViewURL}" alt="프로필사진" class="preview-image" width=200 height=200 style="margin-bottom:2%;">
							</c:when>
							<c:otherwise>
							    <img style="width: 200px; height:200px; margin-bottom:2%;"  class="preview-image" src="">
							</c:otherwise>
						</c:choose>
				    </div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
		        	<textarea id="popupContent" name="popupContent" class="form-control" style="margin-top:1%; margin-bottom:1%;"></textarea>
				</td>
			</tr>
		</table>
		</div>
		<input type="hidden" id="popupSta" name="popupSta" value="1" />
		<input type="button" id="registButton" class="btn btn-outline-primary me-1 mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; margin-left:81%;" value="팝업 공지 등록하기">
	</form>
	<br>
</div>     
</body>
<script>

	var vMyFile = document.querySelector("#myFile");
	var vMyDrop = document.querySelector("#myDrop");

	// onchange="f_check(this)"
// 	function f_check(p_this){
// 		console.log(p_this.files); // 일단 누느로 화긴
// 	    readImage(p_this.files);
// 	}
	
	function readImage(input) {
		// 인풋 태그에 파일이 있는 경우
		if(input.files && input.files[0]) {
			// 이미지 파일인지 검사 (생략)
			// FileReader 인스턴스 생성
			const reader = new FileReader()
			// 이미지가 로드가 된 경우
			reader.onload = e => {
			    const previewImage = $(".preview-image")[0]
			    previewImage.src = e.target.result
			}
			// reader가 이미지 읽도록 하기
			reader.readAsDataURL(input.files[0])
		}
	}
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("myFile")
	inputImage.addEventListener("change", e => {
	    readImage(e.target)
	})

	function f_dragOver(){
		event.preventDefault();	// 이미지를 인식하고 새로운 창에 띄워주는 built in 기능 막기
	}

	// drop 했을 때 함수
	function f_drop(){
		event.preventDefault();	// f_dragOver()와 같은 이유.. 
		console.log(event.dataTransfer.files);
		var files = event.dataTransfer.files;
		vMyFile.files = files;
		
		// 드롭하여 내려 놓은 파일의 개수만큼 반복해서 읽기.
		for(var i=0; i<1; i++){
			f_readFile(files[i]);
		}
		$("#myDrop").empty();
	}
	
	// 읽기 처리를 해줄 함수
	function f_readFile(p_file){
		var fileReader = new FileReader();	// 파일을 읽어줄 객체 생성
			fileReader.readAsDataURL(p_file);	// 파라미터를 하나씩넘겨줘서 읽음
			fileReader.onload = function(){
				var vImage = document.createElement("img"); // img 태그 생성
                vImage.src = fileReader.result;
//                 vImage.width=100; vImage.height=100;
                console.log("vImage", vImage);
                vMyDrop.appendChild(vImage);
//                 var vSpan = document.createElement("span");
//                 vSpan.innerHTML = p_file.name;
//                 vMyDrop.appendChild(vSpan);
			}
	}	
	
	$("#registButton").on("click", function(){
		var inputTitle = $("#popupTitle").val().trim();
		var inputImage= $("#myFile").val().trim();
		
		if(inputTitle.length < 1){
			toastr.info("제목을 입력하세요");
			return false;
		}
		if(inputImage.length < 1){
			toastr.info("팝업이미지를 추가하세요");
			return false;
		}
	      $("#registForm").submit();
	})
	
	$("#settingPopup").on("click", function(){
		event.preventDefault();
		
		let data = $("#setPopup").serialize();
		
		console.log("data : ", data)
		
		$.ajax({
				
				url : "${cPath}/management/base/modifyPopupSta.do?"
			,	data : data
			,	dataType : "text"
			,	success : function(resp){
				// 수정 성공 메시지 띄워주기
				if(resp == "OK"){
					toastr.info("설정 완료");
				}
			},	error : function(xhr){
				console.log(xhr)
			}
		})
		
	});
		
</script>