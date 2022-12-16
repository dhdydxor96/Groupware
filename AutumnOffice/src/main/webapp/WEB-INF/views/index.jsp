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
	a{
		text-decoration: none;
		color: #6E6E6E;
	}
	a:hover{
		text-decoration: none;
		color: black;
		transition:0.5s;
	}
	.menu-wrapper{
		display: flex;
		justify-content: space-between;
	}
	.menu-box{
		width:150px;
		height: 150px;
		border:1px solid #FFFFFF; 
		border-radius:8px;
		text-align: center;
		padding-top:15px;
		font-weight: bold;
	}
	.menu-box:hover{
		box-shadow: 2px 2px 6px 2px #BDBDBD;
		transition:0.5s;
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
        	<div class="card">
            <div class="card-body p-4 p-sm-5">
              <div class="row flex-between-center mb-2">
              <a class="d-flex flex-center mb-4">
        		<img src="${pageContext.request.contextPath }/resources/web/assets/img/Autumn_Office_logo.png" alt="" width="130" />
        		</a>
              </div>
              <div class="menu-wrapper">
	              <a href="${cPath}/web/index.do" class="menu-box">
	              	<img src="${cPath }/resources/groupware/icon/home.png" class="menu-logo"><br><br>
	              	<span>홈페이지 가기</span>
	              </a>
	              <a href="${cPath }/groupware/login/login.do" class="menu-box">
	              	<img src="${cPath }/resources/groupware/icon/networking.png" class="menu-logo"><br><br>
	              	<span>그룹웨어 가기</span>
	              </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
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
</html>
	<h4><a href="${pageContext.request.contextPath }/web/index.do">Autumn Office 사이트 가기</a></h4>
	<h4><a href="${pageContext.request.contextPath }/groupware/login/login.do">Autumn GroupWare 가기</a></h4>
	<h4><a href="${pageContext.request.contextPath }/management/index.do">Autumn GroupWare Management 가기</a></h4>