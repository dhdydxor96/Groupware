<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<h1>메뉴 접근 권한</h1>
<br><br>
<table class="table">
  <thead class="thead-light">
    <tr>
      <th scope="col">메뉴명</th>
      <th scope="col">상세</th>
      <th scope="col">운영자</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">근태관리</th>
      <td>부서 근태 통계</td>
      <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
   			추가
		  </button></td>
    </tr>
    <tr>
      <th scope="row">근태관리</th>
      <td>부서 연차 사용 내역</td>
      <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
   			추가
		  </button></td></td>
    </tr>
    <tr>
      <th scope="row">근태관리</th>
      <td>부서 인사 정보</td>
      <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
   			추가
		  </button></td></td>
    </tr>
        <tr>
      <th scope="row">문서관리</th>
      <td>보고서 관리</td>
      <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
   			추가
		  </button></td></td>
    </tr>
        <tr>
      <th scope="row">보고</th>
      <td>보고 지시 추가</td>
      <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
   			추가
		  </button></td></td>
    </tr>
        <tr>
      <th scope="row">보고</th>
      <td>부서별 보고서</td>
      <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
   			추가
		  </button></td></td>
    </tr>
        <tr>
      <th scope="row">보고</th>
      <td>완료된 보고서</td>
      <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
   			추가
		  </button></td></td>
    </tr>
  </tbody>
</table>

<button class="btn btn-primary mr-1 mb-1" type="button">변경완료</button>
<button class="btn btn-danger mr-1 mb-1" type="button" >취소</button>

<!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle">조직도</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body">
            <table class="table">
  				<thead class="thead-light">
    				<tr>
      					<th scope="col">사원ID</th>
      					<th scope="col">이름</th>
      					<th scope="col">부서명</th>
      					<th scope="col">직위명</th>
    				</tr>    				
  				</thead>
  				<tbody>
  				  <%-- <c:forEach var="" items=""> --%>
   					<tr>
      					<th scope="row"></th>
      					<td></td>
      					<td></td>
      					<td></td>
   					</tr>
   				  <%-- </c:forEach> --%>
  				</tbody>
  		   	</table>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-primary">추가</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>            
         </div>
      </div>
   </div>
</div>