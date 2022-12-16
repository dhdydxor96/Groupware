<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

    
 		<div class="card mb-3">
 		   <div class="card-header bg-light">
              <h4 class="mb-0" style="font-size: 25px; font-weight:bold;float: left;"><span class="fas fa-envelope-open"></span> ${mail }</h4>
           </div>
            <div class="card-body d-flex justify-content-between">
              <div><a class="btn btn-falcon-default btn-sm" href="${cPath }/groupware/mail/mailForwardList.do" data-bs-toggle="tooltip" data-bs-placement="top" title="Back to inbox"><span class="fas fa-arrow-left"></span></a><span class="mx-1 mx-sm-2 text-300">|</span>
                <button class="btn btn-falcon-default btn-sm forward" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Forward"><span class="fab fa-telegram-plane"></span></button>
                <button class="btn btn-falcon-default btn-sm ms-1 ms-sm-2" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete" id="delete"><span class="fas fa-trash-alt"></span></button>
                
                
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

         <form:form id="deleteMail" method="post" action="${cPath }/groupware/mail/sendMailDetailDelete.do">
         	<input id="mailNo" type="hidden" name="mailNo">
         </form:form>
          </div>
         
 
         
         
<script>

		
let mailNo = ${mailNo};
detailView();		 
function detailView(){
	  $.ajax({
			url : "${cPath }/groupware/mail/mailForwardDetail.do",
			method : "get",
			data : {"mailNo" : mailNo},
			dataType : "json",
			success : function(res) {
				console.log(res);
				
				let sendMail = res;   
				let content ="";
				if(sendMail.content!=null){
					content=sendMail.content;
				}
				let	text = "";		
					text +=	`<div class="card-header">
							      <div class="row">
							        <div class="col-md d-flex">
						
							          <div class="flex-1 ms-2" >`;
					text +=             "<h5 class='mb-0'>"+sendMail.title+"</h5><a class='text-800 fs--1' href=''#!''><span class='fw-semi-bold from'>"+sendMail.toAddress+"</span></a>";
					
					text +=           "</div>";
					text +=         "</div>";
					text +=         "<div class='col-md-auto ms-auto d-flex align-items-center ps-6 ps-md-3'><small>"+sendMail.sendDate.substring(0,sendMail.sendDate.length-5)+"</small><span class='fas fa-star text-warning fs--1 ms-2'></span></div>";
					
					text +=       `</div>
							    </div>
							    
							    <div class="card-body bg-light">
					              <div class="row justify-content">
					                <div class="col-lg-8 col-xxl-6">
					 		     <div id="fileBody" class="d-inline-flex flex-column"></div>`;
					text +=        content;         
					                 
					text +=         `</div>
					              </div>
					            </div>`;
						
						$("#mailBody").append(text);
						
						
						if(res.attatchList[0].attNo!=null){		
							let attatchText = "";
								$.each(res.attatchList, function(index,attatchList){
									let viewURL = "${cPath }/groupware/mail/mailDownload.do?what="+attatchList.attNo;
									let picture = "";
									
									
								if(attatchList.attMime.indexOf('image') < 0){
									picture += "fa-file-archive";
								}else{
									picture += "fa-image";
								}
							
								attatchText+= "<div class='border px-2 rounded-3 d-flex flex-between-center bg-white dark__bg-1000 my-1 fs--1'>";
								attatchText+= "<span class='fs-1 far "+picture+"'></span><span class='ms-2'><a href="+viewURL+">"+attatchList.attFnm+"("+attatchList.attFas+")</a></span>";
								attatchText+= `<a class="text-300 p-1 ms-6" href="#!" data-bs-toggle="tooltip" data-bs-placement="right" title="Detach">
									    <span class="fas fa-times"></span></a></div>`;

								});
			 				$("#fileBody").append(attatchText);
							
							}
					},
					error : function(xhr) {
						console.log(xhr.status);
					}
				});    	

}
	        	 

				//메일 삭제 
	        	  $("#delete").on('click',function(){
	        		  $("#mailNo").val(mailNo);
	        		  $("#deleteMail").submit();
	        		 
	        	  });
	        	  
	        	  
	        	  //이전페이지버튼
	        	  $("#up").on("click",function(){

	        		  $.ajax({
						url : "${cPath }/groupware/mail/mailForwardNextPage.do",
						method : "get",
						dataType : "json",
						success : function(res) {
							console.log(res);
							let mailNos = [];
							$.each(res, function(index,mailList){
								mailNos.push(mailList.mailNo);
								
							});
							
							let index = mailNos.indexOf(mailNo);
							console.log("mailNos"+mailNos);
							console.log("index"+index);
							if((index-1)<0){
								toastr.error("이전 메일이 없습니다!");
		 	        			
							}else{
								
								location.href="${cPath }/groupware/mail/mailForwardDetail.do?mailNo="+mailNos[index-1];
							}
						},
						error : function(xhr) {
							console.log(xhr.status);
						}
					});
	        	  });
	        	  
	        	  //다음페이지버튼
	        	  $("#down").on("click",function(){
	         		  
	        		  $.ajax({
							url : "${cPath }/groupware/mail/mailForwardNextPage.do",
							method : "get",
							dataType : "json",
							success : function(res) {
								console.log(res);
								let mailNos = [];
								$.each(res, function(index,mailList){
									mailNos.push(mailList.mailNo);
									
								});
								
								let index = mailNos.indexOf(mailNo);
							
								if((index+1)==mailNos.length){
									toastr.error("다음 메일이 없습니다!");
			 	        			
								}else{
									
									location.href="${cPath }/groupware/mail/mailForwardDetail.do?mailNo="+mailNos[index+1];
								}
							},
							error : function(xhr) {
								console.log(xhr.status);
							}
						});
	        	  });	        	  
	        
	        	  
	        	  
	        	  //FORWARD 이벤트
	      	 	$(document).on("click",".forward",function(){
	  				let toAddresses = [];	
	  				let str = $(".from").text();
	  				
	      	 		
	  				if(str.indexOf('[') >= 0){
	  					let addresses = str.substring(1,str.length-1);
	  					let words = addresses.split(',');
	  					
	  					$.each(words, function(index,word){
	  						toAddresses.push(word);
	  					});
	  				}else{
	  					toAddresses.push(str);
	  				}
	  					
	  		 		 $.ajax({
	  						url : "${cPath }/groupware/mail/mailCheckBoxInsert.do",
	  						method : "get",
	  						data : {toAddresses : toAddresses},
	  						dataType : "html",
	  						success : function(res) {
	  							
	  						    location.href="${cPath }/groupware/mail/mailInsert.do?check=OK";
	  						},
	  						error : function(xhr) {
	  							console.log(xhr.status);
	  						}
	  				});
	      	 	});	        	  

</script>
          