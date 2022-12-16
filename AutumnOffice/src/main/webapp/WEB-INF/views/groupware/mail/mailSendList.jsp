<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
	<div class="card mb-3">
			<div class="card-header bg-light">
              <h4 class="mb-0" style="font-size: 25px; font-weight:bold;float: left;"><span class="fas fa-envelope-open"></span> ${mail }</h4>
              
            </div>
            <div class="card-header">
              <div class="row align-items-center">
                <div class="col d-flex align-items-center">
                  <div class="form-check mb-0 d-none d-sm-block">
                    <input id="cbx_chkAll" class="form-check-input checkbox-bulk-select" type="checkbox"  />
                  </div>
                  <button class="btn btn-falcon-default btn-sm ms-sm-1" type="button" onclick="location.reload()"><span class="fas fa-redo"></span></button>
                  <div class="dropdown font-sans-serif">
                    <button class="btn btn-falcon-default text-600 btn-sm dropdown-toggle dropdown-caret-none ms-2" type="button" id="email-filter" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="fas fa-sliders-h"></span></button>
                    <div class="dropdown-menu border py-0" aria-labelledby="email-filter">
                      <div class="bg-white dark__bg-dark py-2"><a class="dropdown-item d-flex justify-content-between" href="#!">All<span class="fas fa-check" data-fa-transform="down-4 shrink-4"></span></a><a class="dropdown-item" href="#!">Unread</a><a class="dropdown-item" href="#!">To me</a><a class="dropdown-item" href="#!">Flagged</a><a class="dropdown-item" href="#!">Mentions</a><a class="dropdown-item" href="#!">Attachments</a></div>
                    </div>
                  </div>
                  <div class="border-start ms-3 ps-3" id="emails-actions">
                    <div class="btn-group btn-group-sm">
                      <button class="btn btn-falcon-default forward" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Forward"><span class="fab fa-telegram-plane"></span></button>
                      <button id="allDelete" class="btn btn-falcon-default" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete"><span class="fas fa-trash-alt"></span></button>
                      
                      
                    </div>
                  </div>
                </div>
                <div class="col-auto"><a class="btn btn-falcon-primary btn-sm" href="${cPath }/groupware/mail/mailInsert.do" style="font-family: 'IBM Plex Sans KR', sans-serif"><span class="fas fa-plus me-1" data-fa-transform="shrink-3"></span>메일작성</a></div>
              </div>
            </div>
            <div class="card-body fs--1 border-top border-200 p-0" id="emails">
           
<!--               =====================================여기부터 메일 리스트=================================================== -->
<!--               =====================================여기부터 메일 리스트=================================================== -->
<!--               =====================================여기부터 메일 리스트=================================================== -->

     
            </div>
        
            <div class="card-footer d-flex justify-content-between align-items-center">
          
            </div>
      			 <div class="pagingArea">
				</div>
              <div id="searchUI" class="row g-3 justify-content-center" >
				<div class="col-auto">
					<select name="searchType" class="form-select addrSelector" style="font-family: 'IBM Plex Sans KR', sans-serif">
						<option value>전체</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="toAddress">받는사람</option>
					</select>
				</div>
				<div class="col-auto">
					<input type="text" name="searchWord" placeholder="검색키워드"
						class="form-control addrSearch" style="font-family: 'IBM Plex Sans KR', sans-serif" value=""/>
				</div>
				<div class="col-auto">
				 	<input type="button" class="btn btn-falcon-default mr-1 searchButton" style="font-family: 'IBM Plex Sans KR', sans-serif" value="검색" id="searchBtn">
				</div>
			</div>
			<br>
          </div>
          	
        
          
   			 <form:form id="deleteMail" method="post" action="${cPath }/groupware/mail/sendMailDelete.do">
	         	<input id="mailNo" type="hidden" name="mailNo">
	         </form:form>
	          <form:form id="searchForm" method="get" action="${cPath }/groupware/mail/mailForwardList.do">
	         	<input type="hidden" name="page" />
	         	<input type="hidden" name="searchType" />
				<input type="hidden" name="searchWord" />
	         </form:form>          



       
<script>
$("#cbx_chkAll").prop("checked", false);

//메일 리스트 함수
fn_mailList();

let pageTag = $("[name=page]");

//검색메소드
$("#searchUI").on("click", "#searchBtn", function(event) {
	let inputTags = $("#searchUI").find(":input[name]");
	$.each(inputTags, function(index, inputTag) {
		let name = $(this).attr("name")
		let value = $(this).val()
		$("#searchForm").get(0)[name].value = value;
	
		console.log("name:"+ name);
		console.log("value:"+ value);
	})
	
	console.log("searchUI:" + searchUI);
	console.log("inputTags:" + inputTags);
	
	fn_mailList()
});

//메일리스트 뿌리기
function fn_mailList(){
	
	let page =0;
	if($("[name=page]").val()==null){
		page=1;
	}else{
		page=$("[name=page]").val();
	}
	let data = $("#searchForm").serialize();
		
          $.ajax({

			url : "${cPath }/groupware/mail/mailForwardList.do",
			data : data,
			method : "get",
			dataType : "json",
			success : function(res) {
				
				console.log(res);
          		let mailList = res.dataList;
    		
				console.log(mailList);
				let texts =[];
			
					let text = "";
					$.each(mailList, function(index,mail){
						let attatchVali ="";
						
						if(mail.attatchList[0].attNo!=null){
							$.each(mail.attatchList, function(index,attatchList){
								
							attatchVali += fn_image(attatchList);
							});
						}
		        text+=" <div id='fromParent' class='row border-bottom border-200 hover-actions-trigger hover-shadow py-2 px-1 mx-0 bg-white dark__bg-dark' data-href='${cPath }/groupware/mail/mailForwardDetail.do?mailNo="+mail.mailNo+"'>";
		        text+=`     <div class="btn-group btn-group-sm z-index-2 hover-actions end-0 me-3" style="width: 10rem;">
			                  <button class="btn btn-light hover-bg-200 singleForward" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Forward"><span class="fab fa-telegram-plane"></span></button>`;
			     text+="      <button id='delete' data-value="+mail.mailNo+" class='btn btn-light hover-bg-200' type='button' data-bs-toggle='tooltip' data-bs-placement='top' title='Delete'><span class='fas fa-trash-alt'></span></button>";
			     text+=`  	</div>
			                <div class="col-auto d-none d-sm-block">
			                  <div class="d-flex bg-white dark__bg-dark">
			                    <div class="form-check mb-0 fs-0">`;
			     text+="             <input class='form-check-input' name='chk' type='checkbox' id='checkbox-2' data-bulk-select-row='data-bulk-select-row' data-from="+mail.toAddress+" data-value="+mail.mailNo+">";
			     text+=`         </div><span class="fas fa-envelope-open" data-fa-transform="down-4"></span>
			    	 
			                  </div>
			                </div>
			                <div class="col col-md-9 col-xxl-10">
			                  <div class="row">
			                    <div class="col-md-4 col-xl-3 col-xxl-2 ps-md-0 mb-1 mb-md-0">
			                      <div class="d-flex position-relative"> `;
			       text+=       	 "<div id='from' class='flex-1 ms-2'><a class='fw-bold stretched-link inbox-link' href='${cPath }/groupware/mail/mailForwardDetail.do?mailNo="+mail.mailNo+"'>"+mail.toAddress+"</a>";
			      	
			       text+=            `</div>
			                      </div>
			                    </div>`;
			       text+=        "<div class='col'><a class='d-block inbox-link' href='${cPath }/groupware/mail/mailForwardDetail.do?mailNo="+mail.mailNo+"'><span class='fw-bold'>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"+mail.title+"</span></a>";
			       text+= 		"&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"+attatchVali;
			       text+=          `</div>
			                      </div>
			                    </div>`;
			      text+=      "<div class='col-auto ms-auto d-flex flex-column justify-content-between'><span class='fw-bold'>"+mail.sendDate.substring(0,mail.sendDate.length-5)+"</span><span class='fas text-warning fa-star ms-auto mb-2 d-sm-none' data-fa-transform='down-7'></span></div>";
			      text+=     "</div>";

					
					});
				texts.push(text);
				$("#emails").empty();
				$("#emails").append(texts);
				$(".pagingArea").empty();
				$(".pagingArea").append(res.pagingHTML);
				pageTag.val("");
			},
			error : function(xhr) {
				console.log(xhr.status);
			}
		});
		}
		$(".pagingArea").on("click", "a", function(event){
			event.preventDefault();
			let page = $(this).data("page");
			if(!page) return false;
			$("[name=page]").val(page);
			fn_mailList();
			return false;
		});
          
          //메일 삭제 
    	  $(document).on('click',"#delete",function(){
          
    		  let mailNo = $(this).data("value");
    		  $("#mailNo").val(mailNo);
    		  $("#deleteMail").submit();
    		 
    	  });
          
          
    	  $("#deleteMail").on("submit", function(event){
  			event.preventDefault();
  			
  			
  			let url = this.action;
  			let method = this.method;
  			let mailNo = $("#mailNo").val();
  			$.ajax({
  				url : url,
  				method : method,
  				data : {mailNo : mailNo},
  				dataType : "json", 
  				success : function(resp) {
  					 	 toastr.info("삭제가 완료되었습니다!");
						 
						 fn_mailList();
  				
  				},
  				error : function(errorResp) {
  					console.log(errorResp.status);
  				}
  			});
  			return false;
  		});
          
          
    	 	//체크박스 이벤트
    		$("#cbx_chkAll").click(function() {
				if($("#cbx_chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
				else $("input[name=chk]").prop("checked", false);
			});

    	 	//체크박스 하나씩 전부 선택할 시 전체 체크박스도 체크
			$(document).on('click','input[name=chk]',function() {
				
				let total = $("input[name=chk]").length;
				let checked = $("input[name=chk]:checked").length;

				if(total != checked) $("#cbx_chkAll").prop("checked", false);
				else $("#cbx_chkAll").prop("checked", true); 
			});
    	 	
    	 	//체크박스 선택된 값 지우기
    	 	$("#allDelete").on("click",function(){
    	 		
    	 		let deleteNos = [];
    	 		//체크된 값 배열에 넣기
    	 		$('input:checkbox[name=chk]').each(function (index) {
					if($(this).is(":checked")==true){
						deleteNos.push($(this).data("value"));
			   	 	}
				})
				if(deleteNos.length==0){
					toastr.error("체크된 값이 없습니다! 메일을 선택해주세요");
    	 		 
    	 		 return;
				}
				//배열 오름차순 정렬
				deleteNos.sort(function(a, b) { 
					return a - b;
				});
    	 		console.log(deleteNos);
    	 		
    	 		$.ajax({
					url :"${cPath }/groupware/mail/sendMailCheckDelete.do",
					method : "post",
					data : {deleteNos : deleteNos},
					dataType : "json",
					success : function(res) {
							toastr.info("삭제가 완료되었습니다!");
							$("#cbx_chkAll").prop("checked", false);
							fn_mailList();
						
					},
					error : function(xhr) {
						console.log(xhr.status);
					}
				});
    	 	});
    	 	
    	 	function fn_image(attatchList){
    	 	    let type="";
    	 		 if(attatchList.attFnm.indexOf("pdf")>=0){
    	 			type="'fas fa-file-pdf text-danger'";
    	 		 }else if(attatchList.attFnm.indexOf("xlsx")>=0){
    	 	    	type="'fas fa-file-alt text-success'"; 
    	 	     }else if(attatchList.attMime.indexOf("image")>=0){
    	 	    	type="'fas fa-image text-danger'";
    	 	     }else{
    	 	    	type="'fas fa-file-alt text-primary'";
    	 	     }
    	 		 console.log(type);
	    	 	let viewURL = "${cPath }/groupware/mail/mailDownload.do?what="+attatchList.attNo;
	    	 	attatchText = "";
	    	 	attatchText +=  "<a class='d-inline-flex align-items-center border rounded-pill px-3 py-1 me-2 mt-2 inbox-link' href="+viewURL+" data-gallery='gallery-7'>";
	    	 	attatchText +=  "<span class="+type+" data-fa-transform='grow-4'></span><span class='ms-2'>"+attatchList.attFnm+"("+attatchList.attFas+")</span></a>";
    	 	
    	 		return attatchText
    	 	
    	 	}
    	 	
    	 	
    	 	
    	 	 //체크박스FORWARD 이벤트
    	 	$(document).on("click",".forward",function(){
    	 		
    	 	let toAddresses = [];	
    	 		
    	 		$('input:checkbox[name=chk]').each(function (index) {
					if($(this).is(":checked")==true){
						let $div = $(this).parents("#fromParent");
						let str = $div.find("#from").text();
					      
						if(str.indexOf('[') >= 0){
							let addresses = str.substring(1,str.length-1);
							let words = addresses.split(',');
							
							
							$.each(words, function(index,word){
								toAddresses.push(word);
							});
						}else{
							toAddresses.push(str);
						}
							
						
			   	 	}
				})
						
				if(toAddresses.length==0){
					 toastr.error("체크된 값이 없습니다! 메일을 선택해주세요");
    	 		 
    	 		 return;
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
    	 	 
    	 	 
    	 	  //싱글 FORWARD 이벤트
    	 	$(document).on("click",".singleForward",function(){
				let toAddresses = [];	
				let $div = $(this).parents("#fromParent");
				let str = $div.find("#from").text();
    	 		
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