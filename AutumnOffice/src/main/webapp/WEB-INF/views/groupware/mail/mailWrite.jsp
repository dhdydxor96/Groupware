<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>        
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!--JSTL foreach문 공백제거  -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

	<!-- 시큐리티 설정 -->
	<security:authorize access="isAuthenticated()">
				<security:authentication property="principal" var="principal"/>
	</security:authorize>
  

<style>
.mb-0 {
    margin-bottom: 10px !important;
}
.px-card{
	 font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>

<script src="${cPath}/resources/js/ckeditor/ckeditor.js"></script>
	<form:form class="card" id="mailInsert" action="${cPath }/groupware/mail/mailInsert.do" method="post" enctype="multipart/form-data" >
            <div class="card-header bg-light">
                <h4 class="mb-0" style="font-size: 25px; font-weight:bold;float: left;"><span class="fas fa-envelope-open"></span> 메일 작성</h4>
              <div class="col-auto"  style="magin-top: 5px; float: right;" >
              <a id="address" type="button" class="btn btn-falcon-primary btn-sm" href="javascript:fn_mailAddress();" style="font-family: 'IBM Plex Sans KR', sans-serif"><span class="fas fa-plus me-1" data-fa-transform="shrink-3">
              </span>주소록</a></div>
            </div>
  
		    
            <div class="card-body p-0">
              <div class="border border-top-0 border-200">
            <div id="emailBody">   
                <c:if test="${not empty toAddress}">
					<button type='button' class='border px-2 rounded-3  flex-between-center bg-blue dark__bg-1000 my-1 fs--1 toEmails' value="${toAddress}">${toAddress}
				    <a class="text-500 p-1 ms-2 detach" href="#" data-bs-toggle="tooltip" data-bs-placement="right" >
				    <span class="fas fa-times"></span></a></button> 
				</c:if>
				<c:if test="${not empty toAddresses}">
				<c:forEach var="item" items="${toAddresses}" >
				   <button type='button' class='border px-2 rounded-3  flex-between-center bg-blue dark__bg-1000 my-1 fs--1 toEmails' value="${fn:trim(item)}">${fn:trim(item)}
				    <a class="text-500 p-1 ms-2 detach" href="#" data-bs-toggle="tooltip" data-bs-placement="right" >
				    <span class="fas fa-times"></span></a></button> 
				</c:forEach>
				</c:if>
<!-- 		  ---------------------------------이메일주소 추가되는 공간========================================== -->
				<input id="toMails" type="hidden" name="toMails"/>
		    </div>
                <input class="form-control border-0 rounded-0 outline-none px-card" id="email-to" type="email" aria-describedby="email-to" placeholder="보낼 메일을 입력 후 엔터키를 눌러주세요"  />
              </div>
              <div class="border border-top-0 border-200">
              <input class="form-control border-0 rounded-0 outline-none px-card" id="email-form" type="email" aria-describedby="email-from" value="${principal.realUser.empMail}"  readonly/>
              </div>
              <div class="border border-top-0 border-200">
              <input class="form-control border-0 rounded-0 outline-none px-card" id="email-nickName" type="email" aria-describedby="email-nickName" placeholder="이름이나 닉네임을 입력해주세요" name="nickName" />
              </div>
              <div class="border border-y-0 border-200">
                <input class="form-control border-0 rounded-0 outline-none px-card" id="email-subject" type="text" aria-describedby="email-subject" placeholder="제목을 입력해주세요" name="title" />
              </div>
           
                <textarea class="tinymce d-none" name="content"></textarea>
                
          
              <div class="bg-light px-card py-3">
                <div class="d-inline-flex flex-column" id="fileBody">
<!--                   ==========================파일들어올곳=============== -->
<!--                   ==========================파일들어올곳=============== -->
                  
                </div>
              </div>
            </div>
           
            <div class="card-footer border-top border-200 d-flex flex-between-center">
              <div class="d-flex align-items-center">
                <button class="btn btn-outline-primary btn-sm px-5 me-2" type="button" id="send" style="font-family: 'IBM Plex Sans KR', sans-serif">Send</button>
                <input class="d-none" id="email-attachment" type="file" name="files" multiple/>
            	<label class="me-2 btn btn-light btn-sm mb-0 cursor-pointer" for="email-attachment" data-bs-toggle="tooltip" data-bs-placement="top" title="Attach files"><span class="fas fa-paperclip fs-1" data-fa-transform="down-2"></span></label>
                <input class="d-none" id="email-image" type="file" accept="image/*" />
                <label class="btn btn-light btn-sm mb-0 cursor-pointer" for="email-image" data-bs-toggle="tooltip" data-bs-placement="top" title="Attach images"><span class="fas fa-image fs-1" data-fa-transform="down-2"></span></label>
              </div>
              <div class="d-flex align-items-center">
                <div class="dropdown font-sans-serif me-2 btn-reveal-trigger">
                  <button class="btn btn-link text-600 btn-sm dropdown-toggle btn-reveal dropdown-caret-none" id="email-options" type="button" data-bs-toggle="dropdown" data-boundary="viewport" aria-haspopup="true" aria-expanded="false"><span class="fas fa-ellipsis-v" data-fa-transform="down-2"></span></button>
                  <div class="dropdown-menu dropdown-menu-end border py-2" aria-labelledby="email-options"><a class="dropdown-item" href="#!">Print</a><a class="dropdown-item" href="#!">Check spelling</a><a class="dropdown-item" href="#!">Plain text mode</a>
                    <div class="dropdown-divider"></div><a class="dropdown-item" href="#!">Archive</a>
                  </div>
                </div>
                <button class="btn btn-light btn-sm" type="reset" data-bs-toggle="tooltip" data-bs-placement="top" title="reset"> <span class="fas fa-trash"></span></button>
              </div>
            </div>
          </form:form>
          
          
          
<!-- ================================================= -->
<!-- Modal Area -->
<!-- ================================================= -->
  <!--  모달창 -->
<div class="modal fade" id="tooltippopovers" tabindex="-1" aria-labelledby="tooltippopoversLabel" aria-hidden="true">
  <div class="modal-dialog mt-2 modal-dialog-centered" role="document">
    <div class="modal-content border-0" style="
    width: 63%; modal-dialog:center;">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1"><button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button></div>
        <div class="bg-light rounded-top-lg py-3 ps-4 pe-6">
          <h4 class="mb-1" id="tooltippopoversLabel">사원리스트</h4>
        </div>
        <div class="p-4 pb-0">
          <div class="row">
            <div class="col" >
        
            	<ul id="modalList" class="scrollbar" >
            
            	</ul>
   				<hr>
                 
                 <div class="mb-3">
<!--                  <button class="btn btn-outline-primary me-1 mb-1" type="submit" id="create" name="submit"  style="width:100%; font-weight:bold;  font-family: 'IBM Plex Sans KR', sans-serif;">개설하기</button> -->
                 </div>
             
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
<!-- ================================================= -->
<!-- Modal Area End-->
<!-- ================================================= -->          

<!-- ================================================= -->
<!-- Toast Area -->
<!-- ================================================= -->
<div class="position-fixed top-50 start-50 translate-middle" style="z-index: 9999" aria-live="polite" aria-atomic="true" style="min-height: 300px;">
  	<div class="toast fade" id="liveToast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header bg-secondary text-white"><strong class="me-auto">success!</strong><small></small>
      	<button class="btn-close btn-close-white" type="button" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    	<div class="toast-body"></div>
  	</div>
</div>
<!-- ================================================= -->
<!-- Toast Area End -->
<!-- ================================================= -->   
          
 <script defer="defer">

 
 let $emailTo = $("#email-to");
 let $emailBody = $("#emailBody");
 let mail = [];
 
CKEDITOR.replace("content",{
	filebrowserImageUploadUrl:"${cPath}/board/imageUpload.do?type=image"	
});  // id값

//input 엔터키 이벤트
$emailTo.keydown(function(key) {
	if( key.keyCode == 13 ){
		let address =	$(this).val();
		 if(address.indexOf("@")>=0){
		fn_toEmail(address);
	   
		$(this).val("");
		 }else{
			 toastr.error("올바른 이메일을 입력해주세요!");
			 
			 $(this).val("");
		 }
	}
});

//발신메일주소 UI만드는 함수
function fn_toEmail(address){
	
 let email = "<button type='button' class='border px-2 rounded-3  flex-between-center bg-blue dark__bg-1000 my-1 fs--1 toEmails' value="+address+">";
     email += address;
     email +=`<a class="text-500 p-1 ms-2 detach" href="#" data-bs-toggle="tooltip" data-bs-placement="right" title="Detach">
    		  <span class="fas fa-times"></span></a></button>`; 
   
   $emailBody.append(email);
	
}

//x클릭 시 지우는 이벤트
$(document).on('click','.detach',function(){
	$(this).parent('button').remove();
});


//메일 전송
$("#send").on("click",function(){
	   $(".toEmails").each(function (i) {
	        mail.push($(this).attr('value'))
	    });
	   if(mail.length>0){
		   $("#toMails").val(mail);
		   $("#mailInsert").submit();
	   }else{
		   toastr.error("이메일은 필수입니다!");
		 
	   }
	       
});

//파일 넣으면 생성되는 로직
$("#email-attachment").on("change",function(){
  
	let files = document.querySelector("#email-attachment");
	let inputFiles = files.files;
	console.log(inputFiles.length);
	for(let i=0;i<inputFiles.length;i++){
		console.log(inputFiles[i].name);
	
	let filePathSplit = inputFiles[i].name.split('\\'); 
	let fileName = filePathSplit[filePathSplit.length-1];
	
	let picture="";
	if(fileName.indexOf('PNG') > 0 || fileName.indexOf('jpg') > 0){
		picture += "fa-image";
	}else{
		picture += "fa-file-archive";
	}
	
	text= "<div class='border px-2 rounded-3 d-flex flex-between-center bg-white dark__bg-1000 my-1 fs--1'>";
	text+= "<span class='fs-1 far "+picture+"'></span><span class='ms-2'>"+fileName+"</span>";
	text+= `<a class="text-300 p-1 ms-6" href="#!" data-bs-toggle="tooltip" data-bs-placement="right" title="Detach">
		    <span class="fas fa-times"></span></a></div>`;

	$("#fileBody").append(text);
	}
});

//주소록 함수 
  function fn_mailAddress(){
	  $("#tooltippopovers").modal("show");
	
	$("#modalList").empty();
	$.ajax({
		url : "${cPath}/groupware/approval/departmentList.do",
		method : "get",
		dataType : "json",
		success : function(resp) {
			let departmentList = resp;
			$.each(departmentList, function(index, department) {
				let employeeList = department.employeeList;
				let deptTag = $("<li>").attr("class", "treeview-list-item")
									.append(
										$("<a>").attr("data-bs-toggle", "collapse")
												.attr("href", "#treeviewNo-" + index)
												.attr("role", "button")
												.attr("aria-expanded", "false")
												.append(
													$("<p>").attr("class", "treeview-text")
															.text(department.depNm)
												)
									);
				$("#modalList").append(deptTag);
				let empTag = $("<ul>").attr("class", "collapse treeview-list")
								.attr("id", "treeviewNo-" + index)
								.attr("data-show", "false");
				$.each(employeeList, function(num, employee){
					empTag.append(
						$("<li>").attr("class", "treeview-list-item")
								.append(
									$("<div>").attr("class", "treeview-item")
											.append(
												$("<a>").attr("class", "flex-1")
														.attr("href", "#!")
														.append(
															$("<p>").attr("class", "treeview-text app-empId")
																	.data("empId", employee.empId)
																	.data("empNm", employee.empNm)
																	.data("empMail",employee.empMail)
																	.data("depNm", department.depNm)
																	.data("jobNm", employee.job.jobNm)
																	.data("jobId", employee.job.jobId)
																	.data("escNm", employee.empStcode)
																	.append(
																		$("<span>").attr("class", "me-2 far fa-user text-secondary")
																	)
																	.append(employee.empNm + " " + employee.job.jobNm)
														)
											)
								)
					)
				})
				
				deptTag.after(empTag);
					
			});
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
};

	
//주소록 사원 클릭 이벤트
$(document).on('click','.app-empId',function(){

	let address = $(this).data('empMail');
    $("#tooltippopovers").modal("hide");
	fn_toEmail(address);
	
});



</script>
    