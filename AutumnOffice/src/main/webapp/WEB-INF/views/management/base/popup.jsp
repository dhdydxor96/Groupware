<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<meta charset="UTF-8">

<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
.layerPopup img{
margin-bottom : 20px;}
.layerPopup:before {display:block; content:""; position:fixed; left:0; top:0; width:100%; height:100%; background:rgba(0,0,0,.5); z-index:9000}
.layerPopup .layerBox {    
z-index:10000;
position:fixed; left:50%; top:50%; transform:translate(-50%, -50%); padding:30px; background:#fff; border-radius:6px; }
.layerPopup .layerBox .title {margin-bottom:10px; padding-bottom:10px; font-weight:600; border-bottom:1px solid #d9d9d9;}
.layerPopup .layerBox .btnTodayHide {
font-size:14px; font-weight:600; color:black; 
float: left;text-decoration:none;width: 150px; 
height : 30px;line-height:30px;border:black solid 1px; text-align : center;text-decoration:none;
}
.layerPopup div{
	display : inline;
}
.layerPopup form{
	margin-right : 5% 
	font-size:16px; font-weight:600;
	weight: 110%;
	height : 30px;
	line-height:30px
}
.layerPopup #close {
font-size:16px; font-weight:600; width: 40px; height : 30px;color:black; float: right; line-height:30px; text-align : center;text-decoration:underline;
}
.layerPopup a{
	text-decoration : none;
	color : black;width: 50px;height : 40px;
}
.layerBox{
width:38%;height:75%
}
.popImg{
 width: 90%;
    height: 90%;
    margin-left: 4%;
 }
 #pop_form{
 	margin-top : -5%;
 }
</style>
<head>
<script language="JavaScript">
        function setCookie2( name, value, expiredays ) {
            var todayDate = new Date();
            todayDate.setDate( todayDate.getDate() + expiredays ); 
            document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
        }
        function closePop() {
        	console.log("@@@@@@@@@@ 체크 확인 @@@@@@@@" , document.pop_form.chkbox.checked)
            if ( document.pop_form.chkbox.checked ){
            	console.log("@@@@@@@@@@@ true 확인 ")
                setCookie2( "maindiv", "done" , 1 );
            }
            document.all['layer_popup'].style.visibility = "hidden";
        }
</script>
</head>
<body>
<!-- layer popup content -->
<div class="layerPopup" id="layer_popup" style="visibility: visible;">
    <div class="layerBox">
    	<form:form  id="popupForm" method="post">
	        <security:csrfInput/>
	        <h4 class="title"></h4>
	        <div class="cont">
	        	<c:choose>
	        		<c:when test="${not empty authEmp}">
						<p>	
							<c:url var="useImageViewURL" value="/management/menu/usePopUpImageView.do"></c:url>
							<img src="${useImageViewURL}" alt="프로필사진" width=350 height=400 usemap="#popup" alt="event page" class="popImg">
						</p>
	        		</c:when>
	        		<c:otherwise>
						<p>	
							<c:url var="imageViewURL" value="/management/menu/popUpImageView.do"></c:url>
							<img src="${imageViewURL}" alt="프로필사진" width=350 height=400 usemap="#popup" alt="event page" class="popImg">
						</p>
	        		</c:otherwise>
	        	</c:choose>
	        	<div class="popupCont" style="font-family: 'IBM Plex Sans KR', sans-serif;"></div>
	        </div>
    	</form:form>
          <form id="pop_form" name="pop_form">
          <hr>
        <div id="check" ><input type="checkbox" name="chkbox" value="checkbox" id='chkbox' >
        <label for="chkbox" style="font-family: 'IBM Plex Sans KR', sans-serif;">&nbsp;&nbsp;오늘 하루동안 보지 않기</label></div>
		<div id="close" ><a href="javascript:closePop();">닫기</a></div>    
		</form>
	</div>
</div>
</body>
<script language="Javascript">


    cookiedata = document.cookie;   
    if ( cookiedata.indexOf("maindiv=done") < 0 ){     
        document.all['layer_popup'].style.visibility = "visible";
    }
    else {
        document.all['layer_popup'].style.visibility = "hidden";
    }

	console.log("@@@@@@@ 쿠키데이터 @@@@@@@@@ : ", cookiedata);
    
    if('${authEmp}'){
		$(document).ready(function(){
			console.log("start");
			let method	= $("#popupForm").attr("method");
			
		    $.ajax({
						url		:	"${cPath}/management/base/usePopupDetail.do?${_csrf.parameterName}=${_csrf.token}"
			    	,	method	:	method
			    	,	dataType:	"json"
			    	,	contentType : "html"
			    	,	success	:	function(popup){
		    				console.log(popup);
		    				$(".title").text(popup.popupTitle)
		    				$(".popupCont").text(popup.popupContent)
		    			},
		    			errors : function(error){
		    				console.log(error.status);
		    		}
		    });
		});
	}else{
		$(document).ready(function(){
			console.log("start");
			let url		= $("#popupForm").attr("action");
			let method	= $("#popupForm").attr("method");
			
		    $.ajax({
						url		:	"${cPath}/management/base/popupDetail.do?${_csrf.parameterName}=${_csrf.token}"
			    	,	method	:	method
			    	,	dataType:	"json"
			    	,	contentType : "html"
			    	,	success	:	function(popup){
		    				console.log(popup);
		    				$(".title").text(popup.popupTitle)
		    				$(".popupCont").text(popup.popupContent)
		    			},
		    			errors : function(error){
		    				console.log(error.status);
		    		}
		    });
		});
	}
</script>
</html>