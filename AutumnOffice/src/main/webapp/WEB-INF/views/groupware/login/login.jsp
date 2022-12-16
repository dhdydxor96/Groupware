<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

 <html lang="en-US" dir="ltr">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- ===============================================-->
    <!--    Document Title-->
    <!-- ===============================================-->
    <title>Autumn Office</title>

    <!-- ===============================================-->
    <!--    Favicons-->
    <!-- ===============================================-->
    <link rel="apple-touch-icon" sizes="180x180" href="${cPath}/resources/web/assets/img/Autumn_Office_logo.png">
    <link rel="icon" type="image/png" sizes="32x32" href="${cPath}/resources/web/assets/img/Autumn_Office_logo.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${cPath}/resources/web/assets/img/Autumn_Office_logo.png">
    <link rel="shortcut icon" type="image/x-icon" href="${cPath}/resources/web/assets/img/Autumn_Office_logo.png">
    <link rel="manifest" href="${cPath}/resources/groupware/assets/img/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="${cPath}/resources/web/assets/img/Autumn_Office_logo.png">
    <meta name="theme-color" content="#ffffff">
    <script src="${cPath}/resources/groupware/assets/js/config.js"></script>
    <script src="${cPath}/resources/groupware/vendors/overlayscrollbars/OverlayScrollbars.min.js"></script>
    <script src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>

    <!-- ===============================================-->
    <!--    Stylesheets-->
    <!-- ===============================================-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap" rel="stylesheet">
    <link href="${cPath}/resources/groupware/vendors/overlayscrollbars/OverlayScrollbars.min.css" rel="stylesheet">
    <link href="${cPath}/resources/groupware/assets/css/theme-rtl.min.css" rel="stylesheet" id="style-rtl">
    <link href="${cPath}/resources/groupware/assets/css/theme.min.css" rel="stylesheet" id="style-default">
    <link href="${cPath}/resources/groupware/assets/css/user-rtl.min.css" rel="stylesheet" id="user-style-rtl">
    <link href="${cPath}/resources/groupware/assets/css/user.min.css" rel="stylesheet" id="user-style-default">
    <link rel="stylesheet" href="${cPath }/resources/toast/css/toastr.css"/>
    <script>
      var isRTL = JSON.parse(localStorage.getItem('isRTL'));
      if (isRTL) {
        var linkDefault = document.getElementById('style-default');
        var userLinkDefault = document.getElementById('user-style-default');
        linkDefault.setAttribute('disabled', true);
        userLinkDefault.setAttribute('disabled', true);
        document.querySelector('html').setAttribute('dir', 'rtl');
      } else {
        var linkRTL = document.getElementById('style-rtl');
        var userLinkRTL = document.getElementById('user-style-rtl');
        linkRTL.setAttribute('disabled', true);
        userLinkRTL.setAttribute('disabled', true);
      }
    </script>
    
    <style type="text/css">
    @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
    	.col-wrapper{
    		display: flex;
    		justify-content: space-between;
    	}
    *{
    	font-family: 'IBM Plex Sans KR', sans-serif;
     }
     input{
     	font-family: 'IBM Plex Sans KR', sans-serif;
     }
     .btn{
     	font-family: 'IBM Plex Sans KR', sans-serif;
     }
     span{
     	font-family: 'IBM Plex Sans KR', sans-serif;
     }
     .btn btn-outline-primary me-1 mb-1{
     	font-family: 'IBM Plex Sans KR', sans-serif;
     }
     .find-btn{
	text-align: center;
	}
	.find-btn1{
		display :inline-block;
	}
    </style>
  </head>

  <body>
  <!-- ===============================================-->
  <!--    Main Content-->
  <!-- ===============================================-->
   <main class="main" id="top">

   
<div class="container" data-layout="container">
 
       <script>
        var isFluid = JSON.parse(localStorage.getItem('isFluid'));
        if (isFluid) {
          var container = document.querySelector('[data-layout]');
          container.classList.remove('container');
          container.classList.add('container-fluid');
        }
      </script>
     <div class="row flex-center min-vh-100 py-6">
        <div class="col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
	    <!-- ======== 시연용 ======== -->
	    <div class="find-btn">
		    <div style="width:200px" class="find-btn1" >
		    	 <form:form action="${cPath}/groupware/login/loginCheck.do" id="loginForm" method="post">
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><input class="form-control" id="userId" name="empId" type="hidden" value="n019"  /></div>
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><input class="form-control" id="userPw" name="empPass" type="hidden" value="1234" /></div>
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><button class="btn btn-outline-primary me-1 mb-1" type="submit" name="submit" style="font-family:'IBM Plex Sans KR', sans-serif; width:100%; font-weight:bold;"><span class="far fa-user"></span> 오용택 로그인</button></div>
	              </form:form>
		    </div>
		    <div style="width:200px" class="find-btn1" >
		    	 <form:form action="${cPath}/groupware/login/loginCheck.do" id="loginForm" method="post">
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><input class="form-control" id="userId" name="empId" type="hidden" value="n017"  /></div>
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><input class="form-control" id="userPw" name="empPass" type="hidden" value="1234" /></div>
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><button class="btn btn-outline-primary me-1 mb-1" type="submit" name="submit" style="font-family:'IBM Plex Sans KR', sans-serif; width:100%; font-weight:bold;"><span class="far fa-user"></span> 이찬솔 로그인</button></div>
	              </form:form>
		    </div>
		</div>
	    <div class="find-btn">
		    <div style="width:200px" class="find-btn1" >
		    	 <form:form action="${cPath}/groupware/login/loginCheck.do" id="loginForm" method="post">
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><input class="form-control" id="userId" name="empId" type="hidden" value="n015"  /></div>
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><input class="form-control" id="userPw" name="empPass" type="hidden" value="1234" /></div>
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><button class="btn btn-outline-primary me-1 mb-1" type="submit" name="submit" style="font-family:'IBM Plex Sans KR', sans-serif; width:100%; font-weight:bold;"><span class="far fa-user"></span> 이원걸 로그인</button></div>
	              </form:form>
		    </div>
		    <div style="width:200px" class="find-btn1">
		    	 <form:form action="${cPath}/management/login/loginCheck.do" id="loginForm" method="post">
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><input class="form-control" id="userId" name="comId" type="hidden" value="naver999"  /></div>
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><input class="form-control" id="userPw" name="comPass" type="hidden" value="!123456" /></div>
	                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><button class="btn btn-outline-primary me-1 mb-1" type="submit" name="submit" style="font-family:'IBM Plex Sans KR', sans-serif; width:100%; font-weight:bold;"><span class="fas fa-cog"></span> 관리자 로그인</button></div>
	              </form:form>
		    </div>
		</div>
	    <!-- ====================== -->
        	<div class="card">
            <div class="card-body p-4 p-sm-5">
              <div class="row flex-between-center mb-2">
              <a class="d-flex flex-center mb-4" href="#">
        		<img src="${pageContext.request.contextPath }/resources/web/assets/img/Autumn_Office_logo.png" alt="" width="130" />
<!--           		<span class="font-sans-serif fw-bolder fs-5 d-inline-block">Autumn</span> -->
        		</a>
                <div class="col-wrapper" style="font-family: 'IBM Plex Sans KR', sans-serif;">
                  <h5></h5>
                  <div class="form-check form-switch" style="font-family: 'IBM Plex Sans KR', sans-serif;">
                  	<span class="font-base" style="font-family: 'IBM Plex Sans KR', sans-serif;">관리자 로그인</span>
				<input class="form-check-input login-state" type="checkbox" />
			</div>
                </div>
              </div>
              <form:form action="${cPath}/groupware/login/loginCheck.do" id="loginForm" method="post">
                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><input class="form-control" id="userId" name="empId" type="text" placeholder="ID를 입력하세요"  /></div>
                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><input class="form-control" id="userPw" name="empPass" type="password" placeholder="Password를 입력하세요" /></div>
                <div class="row flex-between-center">
                  <div class="col-auto">
                    
                  </div>
                  <br>
                  <div class="col-auto"><a class="fs--1" id="passWord" href="#" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold">임시 비밀번호 발송</a></div>
                </div>
                  <br>
                <div class="mb-3" style="font-family: 'IBM Plex Sans KR', sans-serif;"><input class="btn btn-outline-primary me-1 mb-1" type="submit" name="submit" value="로그인" style="font-family:'IBM Plex Sans KR', sans-serif; width:100%; font-weight:bold;"/></div>
              </form:form>
            </div>
          </div>
        </div>
      </div>
    </div>
    

      <!-- ========================================================= 모달창========================================== -->
<div class="modal fade" id="authentication-modal" tabindex="-1" aria-labelledby="tooltippopoversLabel" aria-hidden="true" style="font-family:'IBM Plex Sans KR', sans-serif;">
  <div class="modal-dialog mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1"><button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button></div>
<!--       <div class="modal-body"> -->
        <div class="bg-light rounded-top-lg py-3 ps-4 pe-6">
          <h4 class="mb-1" id="tooltippopoversLabel" style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight: bold;"><span class="fas fa-search"></span>&nbsp;비밀번호 찾기</h4>
        </div>
        <hr>
        <div class="p-4 pb-0">
          <div class="row">
            <div class="col" style="font-family:'IBM Plex Sans KR', sans-serif;">
                 <form name="information" id="information" method="post" action="${cPath}/commons/login/employeeCheck.do">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                  <div class="mb-3"><label class="form-label" for="modal-auth-name" style="font-family: 'IBM Plex Sans KR', sans-serif; " >사원 아이디</label><input class="form-control" type="text" autocomplete="on" id="modal-auth-name" placeholder="ID를 입력하세요" name="empId" value="n019"></div>
                  <div class="mb-3"><label class="form-label" for="modal-auth-email" style="font-family: 'IBM Plex Sans KR', sans-serif;" >이메일 주소</label><input class="form-control" type="email" autocomplete="on" id="modal-auth-email" placeholder="Email을 입력하세요" name="empMail" value="dhdydxor15@naver.com"></div>
                  <br>
                  <div class="mb-3"><button class="btn btn-outline-primary me-1 mb-1" type="submit" id="sendPass" name="submit"  style="width:100%; font-weight:bold;">임시 비밀번호 전송</button></div>
                </form>
                <div class="position-relative mt-5">
                  <hr>
               
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>  
<!--    모달창====================================================================끝====================================== -->







  </main>
  <!-- ===============================================-->
  <!--    End of Main Content-->
  <!-- ===============================================-->

  <!-- ===============================================-->
  <!--    JavaScripts-->
  <!-- ===============================================-->
  <script src="${cPath}/resources/groupware/vendors/popper/popper.min.js"></script>
  <script src="${cPath}/resources/groupware/vendors/bootstrap/bootstrap.min.js"></script>
  <script src="${cPath}/resources/groupware/vendors/anchorjs/anchor.min.js"></script>
  <script src="${cPath}/resources/groupware/vendors/is/is.min.js"></script>
  <script src="${cPath}/resources/groupware/vendors/fontawesome/all.min.js"></script>
  <script src="${cPath}/resources/groupware/vendors/lodash/lodash.min.js"></script>
  <script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
  <script src="${cPath}/resources/groupware/vendors/list.js/list.min.js"></script>
  <script src="${cPath}/resources/groupware/assets/js/theme.js"></script>
  <script src="${cPath }/resources/toast/js/toastr.min.js"></script>
</body>

<script type="text/javascript" defer="defer">
	//toast setting================================
	toastr.options.positionClass="toast-top-center";
	toastr.options.timeOut = 1500;
	// =============================================
	let loginForm = $("#loginForm");
	let userId = $("#userId");
	let userPw = $("#userPw");
	let loginState = $(".login-state").on("click", function(){
	 if ($(this).is(':checked')) {
		 	console.log("dd");
	        loginForm.attr("action", "${cPath}/management/login/loginCheck.do");
	        userId.attr("name", "comId");
	        userPw.attr("name", "comPass")
	    }
	    else {
	  	  	loginForm.attr("action", "${cPath}/groupware/login/loginCheck.do");
		  	userId.attr("name", "empId");
	        userPw.attr("name", "empPw");
	    }
	});
	console.log(loginState.get(0));
	
// 	비밀번호 찾기 버튼을 누르면 모달창이 생성됨
	$("#passWord").on('click',function(){
		$("#authentication-modal").modal('show');
	});
	
	$("#sendPass").on('click',function () {
		let url = this.action;
		let method = this.method;
		let data = $("[name=information]").serialize();
		event.preventDefault();

		
		console.log(url, method, data);
		
		 $.ajax({
	            url : "${cPath}/commons/login/employeeCheck.do",
	            method : "POST",
	            data : data,
	            dataType : "JSON",
	            success : function(count){
	            	if(count == 1){
	            		toastr.info("임시 비밀번호가 전송되었습니다.")
	            		
	            	}else{
	            		toastr.info("입력된 정보가 일치하지 않습니다.")
	            	}
	            },
	            error: function(errorResp){
	                console.log(errorResp.status);
	            	            		
	            }
	       });
		
		}).submit();
	
	
	
	
</script>

</html>