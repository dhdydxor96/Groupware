<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
	.card{
		padding:1%;
	}
	@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
	h1{
		font-family: 'IBM Plex Sans KR', sans-serif;
		text-align : center;
	}
	h2{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	h3{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	h4{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	h5{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	p{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	span{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	th{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	td{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
   .newInput{
      width : 22%;
      display: inline-block;
      margin-left: 2%;   
   }    
   
   .mb-1{
      margin-left : 2%;   
   }
   
   #inputForm{
      width : 150%;
      margin-left : 10%;
      margin-top : 5%;
   }
   
   #insertCommunity{
      margin-left: 13.7%;
   }
   
   .setMargin{
      margin : auto;
   }
   
   .setMargin2{
      margin-left : 8%; 
   }
   
   #modal {
    position: fixed;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    background-color: rgba(128,128,128,0.5);
    display: none;
    z-index : 99999;
	}
	#content {
	    width:36%;
	    height:28%;
	    margin: 12%  40%;
	    padding : 0.3%;
	    background-color: rgb(255,255,255);
	    border-radius: 10px 10px;
	} 
	
</style>
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif;">
<br>
	<div>
		<h1 style="float:left; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; text-align:left; font-size:30px;"><span class="fas fa-caret-right"></span>&nbsp;????????? ??????</h1>
		<input type="button" class="btn btn-outline-primary me-1 mb-1" id="btnDeleteCommunity" value="??????" style="float:right; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">
		<input type="button" class="btn btn-outline-primary me-1 mb-1" id="btnNewCommunity" value="????????? ??????" style="float:right; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">
	</div>
	<hr>
			<span style="text-align: left;">?????? ???????????? ???????????????.</span>
	<br>
	<table class="table table-hover">
		<thead class="bg-200 text-black">
			<tr>
            	<th class="align-middle white-space-nowrap">
                	<div class="custom-control custom-checkbox">
                    	<input class="checkbox-bulk-select" id="checkbox-bulk-select" type="checkbox" style="margin-left: 40%;">
					</div>
				</th>
				<th class="align-middle">????????? ??????</th>
				<th class="align-middle">????????????</th>
				<th class="align-middle">?????? ??????</th>
			</tr>
		</thead>
        <tbody id="bulk-select-body">
		</tbody>
	</table>
	<div class="pagingArea" style="margin-top:1%;">
	</div>
	<div id="searchUI" class="row g-3 justify-content-center">
		<div class="col-auto">
			<select name="searchType" class="form-control">
				<option value>??????</option>
				<option value="id">????????? ??????</option>
				<option value="name">????????????</option>
			</select>
		</div>
		<div class="col-auto">
			<input type="text" name="searchWord" placeholder="???????????????" class="form-control addrSearch" value="" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;"/>
		</div>
		<div class="col-auto">
			<input type="button" class="btn btn-outline-secondary me-1 mb-1 searchButton" value="??????" id="searchBtn" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">
		</div>
	</div>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop='static' data-keyboard='false'>
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="height:450px;">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:22px;">????????? ??????</h5>
      </div>
      <div class="modal-body">
		<form action='${cPath}/management/menu/insertCommunity.do' method='post' id='inputForm'>
			<br>
			<span style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">????????? ??????</span>
			<input type="text" class="form-control newInput" name="boCode" id="boCode">
			<button type="button" class="btn btn-outline-primary btn-sm mb-1" id="codeChk" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px; width:15%;">?????? ??????</button>
			<br>
			<span id="spanCode" style="margin: 15%; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">1~4?????? ???????????? ????????????</span>
			<br><br>
			<span style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">????????? ??????</span>
			<input type="text" class="form-control newInput" name="boType" id="boType">
			<br><br>
			<span class="setMargin" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">?????? ??????</span>
			<span class="setMargin2" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">???</span>
			<input type="radio" class="btn btn-outline-info btn-sm mb-1" name="boYn" id="boYn" value="Y" checked="checked">
			<span class="mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">?????????</span>
			<input type="radio" class="btn btn-outline-info btn-sm mb-1" name="boYn" id="boYn" value="N">
			<br><br>
		</form>
      </div>
      <div class="modal-footer">
			<input type="button" class="btn btn-outline-primary btn-sm mb-1" value="????????? ??????" id="insertCommunity" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px; width:25%;">
			<span id="spanCode2"></span>
			<input type="button" class="btn btn-outline-secondary btn-sm mb-1" value="??????" id="cancelInsertCommunity" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px; width:20%;">
      </div>
    </div>
  </div>
</div>
<form id="searchForm">
   <input type="hidden" name="page" />
   <input type="hidden" name="searchType" />
   <input type="hidden" name="searchWord" />
</form>
<script   src='<%=request.getContextPath()%>/resources/js/jquery-3.6.0.min.js?<%=System.currentTimeMillis()%>'></script>
<script>

   // ???????????? ????????? ????????? ??? name ????????? ?????? name, value ???????????????
   let searchUI = $("#searchUI").on("click", "#searchBtn", function(event) {
      let inputTags = searchUI.find(":input[name]");
      $.each(inputTags, function(index, inputTag) {
         let name = $(this).attr("name")
         let value = $(this).val()
         searchForm.get(0)[name].value = value;
      
         console.log("name:", name);
         console.log("value:", value);
      })
      
      console.log("searchUI:" , searchUI);
      console.log("inputTags:" , inputTags);
      
      searchForm.submit();
   });
   
   let pageTag = $("[name=page]");
   let listBody = $("#bulk-select-body");
   let pagingArea = $(".pagingArea").on("click", "a", function(event) {
      event.preventDefault();
      let page = $(this).data("page");
      if (!page)   return false;
      pageTag.val(page);
      
      searchForm.submit();
      return false;
   });

   // ???????????? ????????? ?????????
   let makeBoard = function(index, board) {
	   let div = $("<div>")
      let trTag = $("<tr>").append(
                     $("<td>").append(
                           $(div).append(
                                 $("<input>").attr("class", "checkboxBody")
                                          .attr("type", "checkbox")
                                          .attr("id", "checkbox-" + index)
                                          .attr("value", board.boCode)
                              ,   $("<label>").attr("class", "checkboxBody")
                                          .attr("for", "checkbox-" + index)
                           ).attr("class", "custom-control ").css("margin-left", "3%")
                        ).attr("class", "align-middle white-space-nowrap")
                  ,   $("<th>").html(board.boCode).attr("class", "align-middle")
                  ,   $("<td>").html(board.boType).attr("class", "align-middle")
                  ,   $("<td>").html(board.boYn).attr("class", "align-middle")
               ).attr("id", "bulk-select-body");
      return trTag;
   }
   
   // ???????????? 
   let searchForm = $("#searchForm").on("submit",   function(event) {
      
            event.preventDefault();
            let url = this.action;
            let method = this.method;
            let data = $(this).serialize();
            
            console.log("url : " , url);
            console.log("data : " , data);
            
            $.ajax({
               url : url,
               method : method,
               data : data,
               dataType : "json",
               success : function(pagingVO) {
                  
                  console.log("pagingVO : " , pagingVO);
                  console.log("pagingVO.dataList : " ,  pagingVO.dataList);
                  
                  let listBody = $("#bulk-select-body");
                  
                  listBody.empty();
                  pagingArea.empty();
                  pageTag.val("");
                  
                  let boardList = pagingVO.dataList;
                  let boards= [];
                  
                  if (boardList.length > 0) {
                     $.each(boardList, function(index, board) {
                        let tr = makeBoard(index, board);
                        boards.push(tr);
                     });
                  }else {
                     let tr = $("<tr>").html(
                           $("<td>").attr("colspan", "3").html("????????? ???????????? ????????????."));
                     boards.push(tr);
                  }
                  if($("input:checkbox[class='checkboxBody']:checked").length == 0){
                     $("#checkbox-bulk-select").prop("checked", false);      
                     
                  } 
                  listBody.append(boards);
                  let pagingHTML = pagingVO.pagingHTML;
                  pagingArea.html(pagingHTML);
               },
               error : function(errorResp) {
                  console.log(errorResp.status);
               }
            });
            return false;
         }).submit();
   
   let newInput = "<input type='text' class='form-control newInput'>";
   let newButton = "<button type='button' class='btn btn-outline-primary btn-sm mb-1' />";
   let newButton2 = "<input type='button' class='btn btn-outline-primary btn-sm mb-1'>";
   let newButton3 = "<input type='button' class='btn btn-outline-primary btn-sm mb-1'>";
   let newRadio = "<input type='radio' class='btn btn-outline-info btn-sm mb-1'>"
   let newSpan = "<span></span>";
   let newBr = "<br>";
   let inputForm = "<form action='${cPath}/management/menu/insertCommunity.do' method='post' id='inputForm'></form>";
   
   var joinEssential1 = false;
   var joinEssential2 = false;
   var duppleEssential1 = false;
   
	const cModal = document.querySelector('#modal');

      // ???????????? ?????? ?????? ?????? ??? ??????UI ??????
   let addCommunity = $("#btnNewCommunity").on("click", function(event){
      event.preventDefault();
      
      $("#exampleModal").modal('show')
//       addCommunity.hide();
// 		$("#btnDeleteCommunity").hide();
//       cModal.style.display = 'block';
      
      $("#content").append(
               $(inputForm).append(
            		  	 $("<hr style='margin-left:-12%; margin-right:42%;'>") 
					 ,	 $(newSpan).text("???????????? ??????")
                     ,   $(newInput).attr("name", "boCode").attr("id", "boCode")
                     ,   $(newButton).text("????????????").attr("id", "codeChk")
                     ,   newBr
                     ,   $(newSpan).attr("id", "spanCode").html("1~4?????? ???????????? ????????????").css('margin', '15%')
                     ,   newBr
                     ,   $(newSpan).text("???????????? ??????")
                     ,   $(newInput).attr("name", "boType").attr("id", "boType")
                     ,   newBr
                     ,   $(newSpan).text("?????? ??????").attr("class", "setMargin")
                     ,   $(newSpan).text("???").attr("class", "setMargin2")
                     ,   $(newRadio).attr("name", "boYn").attr("id", "boYn").val("Y")
                     ,   $(newSpan).text("?????????").attr("class", "mb-1")
                     ,   $(newRadio).attr("name", "boYn").attr("id", "boYn").attr("checked", "checked").val("N")
                     ,   newBr
                     ,   newBr
                     ,   $(newButton2).val("????????????").attr("id", "insertCommunity")
                     ,   $(newSpan).attr("id", "spanCode2")
                     ,   $(newButton3).val("??????").attr("id", "cancelInsertCommunity")
            )
      )
   })      
   
   $(document).on("click", "#cancelInsertCommunity", function(){
		$("#boCode").val('');
		$("#boCode").css('border', '1px solid #ebedf2')
		$("#boType").val('');
		$("#spanCode").html('');
		$("#boYn").prop("checked", true);
		$("#codeChk").attr("disabled", true);
		$("#exampleModal").modal('hide')
//       cModal.style.display = 'none';
//       $("#inputForm").remove();
//       addCommunity.show();
//       $("#btnDeleteCommunity").show();
//       $(".py-card").show();

		
   })
   
      $(document).on("keyup", "#boCode", function(){

      /* $(this).css().empty(); */
      duppleEssential1 = false;
      console.log("duppleEssential1(????????? ??????) = " , duppleEssential1)
      $("#spanId").empty();
      $("#spanCode").html("")
      
      logValue = $(this).val().trim();
      
      logRule = /^[a-z][a-zA-Z0-9]{1,3}$/
      if(logRule.test(logValue)){
         $(this).css('border', '2px solid yellowgreen');
         $("#codeChk").attr("disabled", false);         
         joinEssential1 = true;
         console.log("joinEssential1(?????????) = " , joinEssential1)
         /* $(this).css().empty(); */
      }else{
         $("#codeChk").attr("disabled", true);
         $(this).css('border', '2px solid red');
         joinEssential1 = false;
         console.log("joinEssential1(?????????) = " , joinEssential1)
         /* $(this).css().empty(); */
      }
   })
   
   
   /**
    * @functionName ?????????
    * @desc ?????? ?????? ?????? : ???????????? ?????? ????????? #communityCode??? ??????????????? alert ?????? ????????????,
    *               ????????? ?????? ????????? ??????????????? ????????? ??????.
    * @param {json}   code
    * @return {string} ????????? ????????? ????????? ok, ????????? fail 
    */
   $(document).on("click", "#codeChk", function(event){
      var inputCode = $("#boCode").val().trim();
   
      if(inputCode.length < 1){
    	  	toastr.info("???????????? ????????? ???????????????");
            joinEssential1 = false;
            console.log("joinEssential1(?????????) = " , joinEssential1)
            return false;
         }

       $.ajax({
            
            url : "${cPath}/management/menu/checkID.do",
            type : "get",
            data : {"code" : inputCode},
            dataType : "text",
            success: function(checkedCode){
               if(checkedCode == "ok"){
               // ?????? ?????? ?????? var inputCode??? readonly??? ?????? ??????????????? ???????????? ????????? ???.
               $("#codeChk").attr("disabled", true);
               $("#spanCode").html("??????????????? ?????? ?????????.").css('color', 'yellowgreen').css("margin", "15%;");
               duppleEssential1 = true;
               console.log("duppleEssential1(????????? ????????????) = " , duppleEssential1)
               $("#insertCommunity").show();
               }else{
               // ?????? ?????? ?????? var inputCode??? ???????????? ???????????? ?????? ???????????? ?????? ????????? ???????????? ????????? ???.
                  $("#spanCode").html("?????? ???????????? ?????? ?????????.").css('margin', '15%').css('color', 'red');
                  $("#boCode").css('border', '2px solid red');
                  duppleEssential1 = false;
                  console.log("duppleEssential1(????????? ????????????) = " , duppleEssential1)
               }
                  
            },
            error: function(xhr){
               alert("??????: " + xhr.status);
            }
         }) 
         
         
         
   })   // ???????????? ???... 
   
   // ???????????? ??????
   $(document).on("click", "#insertCommunity", function(){
      event.preventDefault();
      
      let inputCode = $("#boCode").val().trim();
      let inputName = $("#boType").val().trim();
      var inputYn   = $('input[name="boYn"]:checked').val().trim();
      
      let url = "${cPath}/management/menu/insertCommunity.do?${_csrf.parameterName}=${_csrf.token}"
      
      if(checkValid()){
         $.ajax({
               
               url : url,
               method : 'POST',
               data : {      "boCode" : inputCode
                        ,   "boType" : inputName
                        ,   "boYn" : inputYn
                    },
               dataType : "text",
               success: function(success){
                  if(success == "OK"){
                	  toastr.info("?????? ??????");
//                   $("#spanCode2").html("?????? ??????").css('color', 'yellowgreen');
//                   $("#inputForm").remove();
//                   cModal.style.display = 'none';
//                   addCommunity.show();
//                   $("#btnDeleteCommunity").show();
//                   $(".py-card").show();
						$("#boCode").val('');
						$("#boCode").css('border', '1px solid #ebedf2')
						$("#boType").val('');
						$("#spanCode").html('');
						$("#boYn").prop("checked", true);
						$("#codeChk").attr("disabled", true);
						$("#exampleModal").modal('hide')
                  searchForm.submit();
                  }   
               if($("input:checkbox[class='checkboxBody']:checked").length == 0){
                  $("#checkbox-bulk-select").prop("checked", false);      
                  }else{
                     $("#spanCode2").html("?????? ??????").css('color', 'red');
                  }
                     
               },
               error: function(xhr){
                  alert("??????: " + xhr.status);
               }
            }) 
      }
   })
   
   // ???????????? ?????? ?????? ??????
   $(document).on("keyup", "#boType", function(){
      nameVal = $("#boType").val().trim();
      console.log(nameVal);
      if( null != nameVal && "" != nameVal){
         joinEssential2 = true
         console.log("joinEssential2(??????) = " , joinEssential2)
      }else{
         joinEssential2 = false
         console.log("joinEssential2(??????) = " , joinEssential2)
      }
   })
   
   function checkValid(){
      if(joinEssential1 == false){
    	  toastr.info("???????????? ????????? ???????????????");
         return false
      }if(duppleEssential1 == false){
    	  toastr.info("???????????? ?????? ??????????????? ????????????.");
         return false;         
      }if(joinEssential2 == false){
    	  toastr.info("???????????? ????????? ??????????????????.")
         return false;
      }
      return true;
   }
   
    $(function(){
      // ???????????? ????????? ???????????? ???????????? ?????? ?????? ???????????? ??????
      $("#checkbox-bulk-select").on("click", function(event){
         let chk_listArr = $("input:checkbox[class='checkboxBody']");
            console.log("chk_listArr", chk_listArr);
         for (var i=0; i<chk_listArr.length; i++){
            chk_listArr[i].checked = this.checked;
         }
         $("#btnDelete").show();
         if(!this.checked){
            $("#btnDelete").hide();
         }
         console.log("???????????? ?????? ?????? : " , chk_listArr.length);
      });
      
   })
   
   
   /* $("document").on("click", $(".checkboxBody"),function(event){
	   let chk_listArr = $("input:checkbox[class='checkboxBody']");
	   console.log("???????????? ??????", chk_listArr.length);
	   for (var i=0; i<chk_listArr.length; i++){
		   if(chk_listArr[i].checked == chk_listArr.length){
			   $("#checkbox-bulk-select").prop("checked");
		   }
	   }
   }) */
   
	$(document).on("click", ".checkboxBody", function(event){
		let chkBody = $("input:checkbox[class='checkboxBody']:checked");
		console.log("????????? ??????", chkBody.length)
		let chk_listArr = $("input:checkbox[class='checkboxBody']");
		console.log("??????????????? ??? ??????", chk_listArr.length);
			if(chkBody.length == chk_listArr.length){
				console.log("????????? ??????", chkBody, "???????????? ??????", chk_listArr)
				$("#checkbox-bulk-select").prop("checked", true);
			}else{
				$("#checkbox-bulk-select").prop("checked", false);
			}
	})
   
	// ???????????? ?????? function
	function delValue(){
		// ?????? ??????
		var url = "${cPath}/management/menu/communityDelete.do?${_csrf.parameterName}=${_csrf.token}"
		var valueArr = new Array();
		var list = $(".checkboxBody");
		for(var i=0; i<list.length; i++){
			if(list[i].checked){
				valueArr.push(list[i].value);
			}
		}
		console.log("valueArr", valueArr);
		if(valueArr.length == 0){
			toastr.info("????????? ???????????? ????????????.");
		}else{
			chkSwal(); 
		}
	}
   
	$("#btnDeleteCommunity").on("click", function(){
		delValue();
	})
   
	let chkSwal = function(title, text){
		var url = "${cPath}/management/menu/communityDelete.do?${_csrf.parameterName}=${_csrf.token}"
		var valueArr = new Array();
		var list = $(".checkboxBody");
		for(var i=0; i<list.length; i++){
			if(list[i].checked){
			   valueArr.push(list[i].value);
			}
		}
	   swal({
		   title : "???????????? ?????? ???????????????????",
		   buttons: ["??????" , "??????"]
		}).then((value) => {
			if(value){
	               $.ajax({
	                     url : url
	                  ,   method : 'POST'
	                  ,   data : JSON.stringify(valueArr)
	                  ,   contentType : "application/json;charset=UTF-8"   
	                  ,   
	                  success: function(resp){
	                     if(resp = 1){
	                    	 toastr.info("?????? ??????");
	                        searchForm.submit();
	                     }else{
	                    	 toastr.info("?????? ??????");
	                     }
	                  }
	                  ,
	                  error : function(errorResp) {
	                     console.log(errorResp.status);
	                  }
	               });                  
			}
		}) 
   };
   
   
      
</script>
<style>
   .setInline{
      display: inline-block;
   }
</style>