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
		<h1 style="float:left; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; text-align:left; font-size:30px;"><span class="fas fa-caret-right"></span>&nbsp;게시판 관리</h1>
		<input type="button" class="btn btn-outline-primary me-1 mb-1" id="btnDeleteCommunity" value="삭제" style="float:right; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">
		<input type="button" class="btn btn-outline-primary me-1 mb-1" id="btnNewCommunity" value="게시판 등록" style="float:right; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">
	</div>
	<hr>
			<span style="text-align: left;">기업 게시판을 관리합니다.</span>
	<br>
	<table class="table table-hover">
		<thead class="bg-200 text-black">
			<tr>
            	<th class="align-middle white-space-nowrap">
                	<div class="custom-control custom-checkbox">
                    	<input class="checkbox-bulk-select" id="checkbox-bulk-select" type="checkbox" style="margin-left: 40%;">
					</div>
				</th>
				<th class="align-middle">게시판 코드</th>
				<th class="align-middle">게시판명</th>
				<th class="align-middle">댓글 여부</th>
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
				<option value>전체</option>
				<option value="id">게시판 코드</option>
				<option value="name">게시판명</option>
			</select>
		</div>
		<div class="col-auto">
			<input type="text" name="searchWord" placeholder="검색키워드" class="form-control addrSearch" value="" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;"/>
		</div>
		<div class="col-auto">
			<input type="button" class="btn btn-outline-secondary me-1 mb-1 searchButton" value="검색" id="searchBtn" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold;">
		</div>
	</div>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop='static' data-keyboard='false'>
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="height:450px;">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:22px;">게시판 등록</h5>
      </div>
      <div class="modal-body">
		<form action='${cPath}/management/menu/insertCommunity.do' method='post' id='inputForm'>
			<br>
			<span style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">게시판 코드</span>
			<input type="text" class="form-control newInput" name="boCode" id="boCode">
			<button type="button" class="btn btn-outline-primary btn-sm mb-1" id="codeChk" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px; width:15%;">중복 확인</button>
			<br>
			<span id="spanCode" style="margin: 15%; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">1~4글자 첫글자는 영소문자</span>
			<br><br>
			<span style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">게시판 이름</span>
			<input type="text" class="form-control newInput" name="boType" id="boType">
			<br><br>
			<span class="setMargin" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">댓글 사용</span>
			<span class="setMargin2" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">예</span>
			<input type="radio" class="btn btn-outline-info btn-sm mb-1" name="boYn" id="boYn" value="Y" checked="checked">
			<span class="mb-1" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px;">아니오</span>
			<input type="radio" class="btn btn-outline-info btn-sm mb-1" name="boYn" id="boYn" value="N">
			<br><br>
		</form>
      </div>
      <div class="modal-footer">
			<input type="button" class="btn btn-outline-primary btn-sm mb-1" value="게시판 등록" id="insertCommunity" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px; width:25%;">
			<span id="spanCode2"></span>
			<input type="button" class="btn btn-outline-secondary btn-sm mb-1" value="취소" id="cancelInsertCommunity" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:16px; width:20%;">
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

   // 검색하기 버튼을 눌렀을 때 name 속성을 찾아 name, value 설정해주기
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

   // 비동기로 테이블 만들기
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
   
   // 검색하기 
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
                           $("<td>").attr("colspan", "3").html("등록된 게시판이 없습니다."));
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

      // 카테고리 추가 버튼 클릭 시 추가UI 생성
   let addCommunity = $("#btnNewCommunity").on("click", function(event){
      event.preventDefault();
      
      $("#exampleModal").modal('show')
//       addCommunity.hide();
// 		$("#btnDeleteCommunity").hide();
//       cModal.style.display = 'block';
      
      $("#content").append(
               $(inputForm).append(
            		  	 $("<hr style='margin-left:-12%; margin-right:42%;'>") 
					 ,	 $(newSpan).text("카테고리 코드")
                     ,   $(newInput).attr("name", "boCode").attr("id", "boCode")
                     ,   $(newButton).text("중복확인").attr("id", "codeChk")
                     ,   newBr
                     ,   $(newSpan).attr("id", "spanCode").html("1~4글자 첫글자는 영소문자").css('margin', '15%')
                     ,   newBr
                     ,   $(newSpan).text("카테고리 이름")
                     ,   $(newInput).attr("name", "boType").attr("id", "boType")
                     ,   newBr
                     ,   $(newSpan).text("댓글 사용").attr("class", "setMargin")
                     ,   $(newSpan).text("예").attr("class", "setMargin2")
                     ,   $(newRadio).attr("name", "boYn").attr("id", "boYn").val("Y")
                     ,   $(newSpan).text("아니오").attr("class", "mb-1")
                     ,   $(newRadio).attr("name", "boYn").attr("id", "boYn").attr("checked", "checked").val("N")
                     ,   newBr
                     ,   newBr
                     ,   $(newButton2).val("추가하기").attr("id", "insertCommunity")
                     ,   $(newSpan).attr("id", "spanCode2")
                     ,   $(newButton3).val("취소").attr("id", "cancelInsertCommunity")
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
      console.log("duppleEssential1(아이디 중복) = " , duppleEssential1)
      $("#spanId").empty();
      $("#spanCode").html("")
      
      logValue = $(this).val().trim();
      
      logRule = /^[a-z][a-zA-Z0-9]{1,3}$/
      if(logRule.test(logValue)){
         $(this).css('border', '2px solid yellowgreen');
         $("#codeChk").attr("disabled", false);         
         joinEssential1 = true;
         console.log("joinEssential1(아이디) = " , joinEssential1)
         /* $(this).css().empty(); */
      }else{
         $("#codeChk").attr("disabled", true);
         $(this).css('border', '2px solid red');
         joinEssential1 = false;
         console.log("joinEssential1(아이디) = " , joinEssential1)
         /* $(this).css().empty(); */
      }
   })
   
   
   /**
    * @functionName 함수명
    * @desc 코드 중복 검사 : 중복검사 버튼 클릭시 #communityCode가 비어있으면 alert 창을 띄워주고,
    *               입력된 값이 있으면 중복검사를 실시해 준다.
    * @param {json}   code
    * @return {string} 중복된 코드가 없으면 ok, 있으면 fail 
    */
   $(document).on("click", "#codeChk", function(event){
      var inputCode = $("#boCode").val().trim();
   
      if(inputCode.length < 1){
    	  	toastr.info("카테고리 코드를 입력하세요");
            joinEssential1 = false;
            console.log("joinEssential1(아이디) = " , joinEssential1)
            return false;
         }

       $.ajax({
            
            url : "${cPath}/management/menu/checkID.do",
            type : "get",
            data : {"code" : inputCode},
            dataType : "text",
            success: function(checkedCode){
               if(checkedCode == "ok"){
               // 성공 했을 경우 var inputCode를 readonly로 하고 중복검사를 비활성화 해줘야 함.
               $("#codeChk").attr("disabled", true);
               $("#spanCode").html("사용가능한 코드 입니다.").css('color', 'yellowgreen').css("margin", "15%;");
               duppleEssential1 = true;
               console.log("duppleEssential1(아이디 중복확인) = " , duppleEssential1)
               $("#insertCommunity").show();
               }else{
               // 실패 했을 경우 var inputCode를 빨간불로 바꿔주고 하고 중복검사 추가 버튼을 비활성화 해줘야 함.
                  $("#spanCode").html("이미 사용중인 코드 입니다.").css('margin', '15%').css('color', 'red');
                  $("#boCode").css('border', '2px solid red');
                  duppleEssential1 = false;
                  console.log("duppleEssential1(아이디 중복확인) = " , duppleEssential1)
               }
                  
            },
            error: function(xhr){
               alert("상태: " + xhr.status);
            }
         }) 
         
         
         
   })   // 중복검사 끝... 
   
   // 카테고리 추가
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
                	  toastr.info("추가 성공");
//                   $("#spanCode2").html("추가 성공").css('color', 'yellowgreen');
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
                     $("#spanCode2").html("추가 실패").css('color', 'red');
                  }
                     
               },
               error: function(xhr){
                  alert("상태: " + xhr.status);
               }
            }) 
      }
   })
   
   // 카테고리 이름 빈칸 체크
   $(document).on("keyup", "#boType", function(){
      nameVal = $("#boType").val().trim();
      console.log(nameVal);
      if( null != nameVal && "" != nameVal){
         joinEssential2 = true
         console.log("joinEssential2(이름) = " , joinEssential2)
      }else{
         joinEssential2 = false
         console.log("joinEssential2(이름) = " , joinEssential2)
      }
   })
   
   function checkValid(){
      if(joinEssential1 == false){
    	  toastr.info("카테고리 코드를 입력하세요");
         return false
      }if(duppleEssential1 == false){
    	  toastr.info("카테고리 코드 중복확인을 해주세요.");
         return false;         
      }if(joinEssential2 == false){
    	  toastr.info("카테고리 이름을 입력해주세요.")
         return false;
      }
      return true;
   }
   
    $(function(){
      // 체크박스 헤더를 클릭하면 체크박스 바디 전체 선택하는 로직
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
         console.log("체크박스 선택 개수 : " , chk_listArr.length);
      });
      
   })
   
   
   /* $("document").on("click", $(".checkboxBody"),function(event){
	   let chk_listArr = $("input:checkbox[class='checkboxBody']");
	   console.log("바디체크 길이", chk_listArr.length);
	   for (var i=0; i<chk_listArr.length; i++){
		   if(chk_listArr[i].checked == chk_listArr.length){
			   $("#checkbox-bulk-select").prop("checked");
		   }
	   }
   }) */
   
	$(document).on("click", ".checkboxBody", function(event){
		let chkBody = $("input:checkbox[class='checkboxBody']:checked");
		console.log("선택한 개수", chkBody.length)
		let chk_listArr = $("input:checkbox[class='checkboxBody']");
		console.log("체크박스의 총 개수", chk_listArr.length);
			if(chkBody.length == chk_listArr.length){
				console.log("선택한 개수", chkBody, "체크박스 개수", chk_listArr)
				$("#checkbox-bulk-select").prop("checked", true);
			}else{
				$("#checkbox-bulk-select").prop("checked", false);
			}
	})
   
	// 커뮤니티 삭제 function
	function delValue(){
		// 여기 수정
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
			toastr.info("선택된 게시판이 없습니다.");
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
		   title : "게시판을 삭제 하시겠습니까?",
		   buttons: ["취소" , "삭제"]
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
	                    	 toastr.info("삭제 성공");
	                        searchForm.submit();
	                     }else{
	                    	 toastr.info("삭제 실패");
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