<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

    
 		<div class="card mb-3">
 		  <div class="card-header bg-light">
              <h4 class="mb-0" style="font-size: 25px; font-weight:bold;float: left;"><span class="fas fa-envelope-open"></span> ${mail }</h4>
           </div>
            <div class="card-body d-flex justify-content-between">
              <div><a class="btn btn-falcon-default btn-sm" href="${cPath }/groupware/mail/mailList.do" data-bs-toggle="tooltip" data-bs-placement="top" title="Back to inbox"><span class="fas fa-arrow-left"></span></a><span class="mx-1 mx-sm-2 text-300">|</span>
                <button class="btn btn-falcon-default btn-sm forward" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Forward"><span class="fab fa-telegram-plane"></span></button>
                <button class="btn btn-falcon-default btn-sm ms-1 ms-sm-2" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete" id="delete"><span class="fas fa-trash-alt"></span></button>
                <button class="btn btn-falcon-default btn-sm ms-1 ms-sm-2" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Important" id="important"><span class="fas fa-star"></span></button>
                <button class="btn btn-falcon-default btn-sm ms-1 ms-sm-2 d-none d-sm-inline-block" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Print"><span class="fas fa-print"></span></button>
              </div>
              <div class="d-flex">
                <div class="d-none d-md-block">
                  <button id="up" class="btn btn-falcon-default btn-sm ms-2" type="button"><span class="fas fa-chevron-up"></span></button>
                  <button id="down" class="btn btn-falcon-default btn-sm ms-2" type="button"><span class="fas fa-chevron-down"></span></button>
                </div>
                <div class="dropdown font-sans-serif">
                  <button class="btn btn-falcon-default text-600 btn-sm dropdown-toggle dropdown-caret-none ms-2" type="button" id="email-settings" data-bs-toggle="dropdown" data-boundary="viewport" aria-haspopup="true" aria-expanded="false"><span class="fas fa-cog"></span></button>
                  <div class="dropdown-menu dropdown-menu-end border py-2" aria-labelledby="email-settings"><a class="dropdown-item" href="#!">Configure inbox</a>
                    <div class="dropdown-divider"></div><a class="dropdown-item" href="#!">Settings</a><a class="dropdown-item" href="#!">Themes</a>
                    <div class="dropdown-divider"></div><a class="dropdown-item" href="#!">Send feedback</a><a class="dropdown-item" href="#!">Help</a>
                    
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="card" id="mailBody">
         <form:form id="deleteMail" method="post" action="${cPath }/groupware/mail/mailDetailDelete.do">
         	<input id="mailNo" type="hidden" name="mailNo">
         </form:form>
          
            <div class="card-footer">
              <div class="row justify-content-between">
                <div class="col"><a class="btn btn-falcon-default btn-sm ms-2 forward" href="#"><span class="fas fa-location-arrow" data-fa-transform="down-2"></span><span class="d-none d-sm-inline-block ms-1">Forward</span></a></div>
             
              </div>
            </div>
          </div>
         
      
<script>

		
	        	 let mailNo = ${mailNo};
	        	  $.ajax({
					url : "${cPath }/groupware/mail/mailDetail.do",
					method : "get",
					data : {"mailNo" : mailNo},
					dataType : "json",
					success : function(res) {
						console.log(res);
						let mail = res;   
						let	text = "";		
							text +=	`<div class="card-header">
									      <div class="row">
									        <div class="col-md d-flex">
								
									          <div class="flex-1 ms-2">`;
							text +=             "<h5 class='mb-0'>"+mail.subject+"</h5><a class='text-800 fs--1' href=''#!'' style=\"font-family: 'IBM Plex Sans KR', sans-serif\"><span id='forwardFrom' class='fw-semi-bold' data-from='"+mail.from+"'>"+mail.from+"</span></a>";
							text +=           "</div>";
							text +=         "</div>";
							text +=         "<div class='col-md-auto ms-auto d-flex align-items-center ps-6 ps-md-3'><small>"+mail.sentDate+"</small><span class='fas fa-star text-warning fs--1 ms-2'></span></div>";
							text +=       `</div>
									    </div>
									    
									    <div class="card-body bg-light">
							              <div class="row justify-content-center">
							                <div class="col-lg-8 col-xxl-6">`;
							text +=        mail.messageContent;         
							                 
							text +=         `</div>
							              </div>
							            </div>`;
						
						$("#mailBody").append(text);
					},
					error : function(xhr) {
						console.log(xhr.status);
					}
				});
	        	  
	        	  //메일 삭제 
	        	  $("#delete").on('click',function(){
	        		  $("#mailNo").val(mailNo);
	        		  $("#deleteMail").submit();
	        		 
	        	  });
	        	  
	        	  $("#important").on('click',function(){
	        			$.ajax({
	    					url : "${cPath }/groupware/mail/importMailInsert.do",
	    					method : "get",
	    					data : { mailNo : mailNo},
	    					dataType : "json",
	    					success : function(res) {
	    						if(res=="OK"){
	    							toastr.info("중요메일함에 저장되었습니다!");
	    						 
	    						 }
	    					},
	    					error : function(xhr) {
	    						console.log(xhr.status);
	    					}
	    				});
	        		 
	        	  });
	        
  //FORWARD 이벤트
  $(".forward").on("click",function(){
	  let toAddress = $("#forwardFrom").data("from");
	 location.href="${cPath }/groupware/mail/mailInsert.do?toAddress="+toAddress;
  });
  
  $("#up").on("click",function(){
	  let index;
	  index = mailNo+1;
	  if(index>1000){
		  toastr.error("이전 메일이 없습니다!");
	  }else{
	  	location.href="${cPath }/groupware/mail/mailDetail.do?mailNo="+index;
	  }
  });
  
  $("#down").on("click",function(){
	  let index;
	  index = mailNo-1;
	  if(index<1){
		  toastr.error("다음 메일이 없습니다!");
		  
	  }else{
	  	location.href="${cPath }/groupware/mail/mailDetail.do?mailNo="+index;
	  }
  });
	        
</script>
          