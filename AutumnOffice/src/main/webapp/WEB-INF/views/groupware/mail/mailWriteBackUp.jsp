<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>  

<script src="${cPath}/resources/js/ckeditor/ckeditor.js"></script>
	<form:form class="card" id="mailInsert" action="${cPath }/groupware/mail/mailInsert.do" method="post" enctype="multipart/form-data" >
            <div class="card-header bg-light">
              <h5 class="mb-0">메일 작성</h5>
              <div class="col-auto">
              <a id="address" type="button" class="btn btn-falcon-primary btn-sm" href="javascript:fn_mailAddress();" ><span class="fas fa-plus me-1" data-fa-transform="shrink-3">
              </span>주소록</a></div>
            </div>
            
            <div class="card-body p-0">
              <div class="border border-top-0 border-200">
                <input class="form-control border-0 rounded-0 outline-none px-card" id="email-to" type="email" aria-describedby="email-to" placeholder="To" name="toMails"/>
              </div>
              <div class="border border-top-0 border-200">
              <input class="form-control border-0 rounded-0 outline-none px-card" id="email-form" type="email" aria-describedby="email-from" value="chansol128@naver.com"  readonly/>
              </div>
              <div class="border border-top-0 border-200">
              <input class="form-control border-0 rounded-0 outline-none px-card" id="email-nickName" type="email" aria-describedby="email-nickName" placeholder="nickName" name="nickName" />
              </div>
              <div class="border border-y-0 border-200">
                <input class="form-control border-0 rounded-0 outline-none px-card" id="email-subject" type="text" aria-describedby="email-subject" placeholder="Subject" name="title" />
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
                <button class="btn btn-primary btn-sm px-5 me-2" type="button" id="send">Send</button>
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
                <button class="btn btn-light btn-sm" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete"> <span class="fas fa-trash"></span></button>
              </div>
            </div>
          </form:form>
          
          
          
<!-- ================================================= -->
<!-- Modal Area -->
<!-- ================================================= -->
  <!--  모달창 -->
<div class="modal fade" id="tooltippopovers" tabindex="-1" aria-labelledby="tooltippopoversLabel" aria-hidden="true">
  <div class="modal-dialog mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1"><button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button></div>
<!--       <div class="modal-body"> -->
        <div class="bg-light rounded-top-lg py-3 ps-4 pe-6">
          <h4 class="mb-1" id="tooltippopoversLabel">멤버리스트</h4>
        </div>
        <div class="p-4 pb-0">
          <div class="row">
            <div class="col" >
            	<ul id="modalList" class="scrollbar">
            
            	</ul>
  				<input type="submit" class="btn btn-secondary" id="create" value="개설하기"/>
             
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
<!-- ================================================= -->
<!-- Modal Area End-->
<!-- ================================================= -->          
          
 <script defer="defer">
 let $emailTo = $("#email-to");
 
CKEDITOR.replace("content",{
	filebrowserImageUploadUrl:"${cPath}/board/imageUpload.do?type=image"	
});  // id값

//메일 전송
$("#send").on("click",function(){
	alert($emailTo.val());
	$("#mailInsert").submit();
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

	let mail = [];
//주소록 사원 클릭 이벤트
$(document).on('click','.app-empId',function(){
	mail.push($(this).data('empMail'));
	$("#tooltippopovers").modal("hide");
	$("#email-to").val(mail);
	alert($("#email-to").val());
	
	
});



</script>
    