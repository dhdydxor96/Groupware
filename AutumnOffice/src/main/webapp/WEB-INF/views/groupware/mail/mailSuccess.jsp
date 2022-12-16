<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>        
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>  
<script src="${cPath}/resources/groupware/vendors/lottie/lottie.min.js"></script>
<style>
	.lottie mx-auto {
		
	}
	p{
    font-family: 'IBM Plex Sans KR', sans-serif;
    }
    mt-3{
    font-family: 'IBM Plex Sans KR', sans-serif;
    }
</style>
    



<!--       <div class="container" data-layout="container"> -->
        <div class="row flex-center min-vh-50 py-6 text-center">
          <div class="col-sm-10 col-md-8 col-lg-6 col-xxl-5"><a class="d-flex flex-center mb-4" href="./index.html"><span class="text-sans-serif font-weight-extra-bold fs-5 d-inline-block">${word1 }</span></a>
            <div class="card">
              <div class="card-body p-4 p-sm-5">
                
                <div class="row align-items-center">
				  <div class="col-lg-4" style="margin-left: 22%">
				  	<c:choose>
						<c:when test="${word1 eq 'Success' }">
							<div class="lottie mx-auto" style="width: 200px; height: 200px;" data-options='{"path":"${cPath}/resources/groupware/assets/img/animated-icons/check-primary-light.json"}'></div>
						</c:when>
						<c:otherwise> 
							<div class="lottie mx-auto" style="width: 200px; height: 200px;" data-options='{"path":"${cPath}/resources/groupware/assets/img/animated-icons/warning-light.json"}'></div>
						</c:otherwise>
					 </c:choose>
				  </div>
				</div>
				
                <p class="lead mt-4 text-800 text-sans-serif font-weight-semi-bold">${word2 }</p>
                <hr />
                <p>${word3 }</p>
                <a class="btn btn-primary btn-sm mt-3" href="${cPath }/groupware/mail/mailList.do"><span class="fas fa-home mr-2"></span>메일목록</a>
                <a class="btn btn-primary btn-sm mt-3" href="${cPath }/groupware/mail/mailForwardList.do"><span class="fas fa-home mr-2"></span>보낸메일함</a>
                <a class="btn btn-primary btn-sm mt-3" href="${cPath }/groupware/mail/mailInsert.do""><span class="fab fa-telegram-plane"></span> 메일작성</a>
              </div>
            </div>
          </div>
        </div>
<!--       </div> -->
    


<!--   <div class="row align-items-center"> -->
<!--  
<!--   <div class="col-lg-4 mt-5 mt-lg-0"> -->
<!--     <div class="lottie mx-auto" style="width: 130px; height: 130px" data-options='{"path":"../../assets/img/animated-icons/warning-light.json"}'></div> -->
<!--   </div> -->
<!--   
<!-- </div> -->


          
    