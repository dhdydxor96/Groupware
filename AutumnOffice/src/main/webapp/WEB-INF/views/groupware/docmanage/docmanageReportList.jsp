<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="card md-3">

	<h3>보고서 관리</h3>
	<hr>
	<br>
	
		<select class="form-control" style="width: 120px">
			<option>검색조건</option>
			<option>제목</option>
		</select>
		<input type="text" class="form-control" placeholder="검색 내용" style="width: 120px" />
	
	<br>
	
	<div class="table-responsive scrollbar">
	  <table class="table table-hover table-striped overflow-hidden">
	    <thead>
	      <tr>
	        <th scope="col">No</th>
	        <th scope="col">제목</th>
	        <th scope="col">작성자</th>
	        <th scope="col">부서</th>
	        <th scope="col">날짜</th>
	        <th scope="col">조회수</th>
	      </tr>
	    </thead>
	    <tbody>
	      <tr class="align-middle">
	        <td class="text-nowrap">3</td>
	        <td class="text-nowrap">주간보고</td>
	        <td class="text-nowrap">OOO</td>
	        <td class="text-nowrap">개발팀</td>
	        <td class="text-nowrap">2022-11-04</td>
	        <td class="text-nowrap">25</td>
	      </tr>
	      <tr class="align-middle">
	        <td class="text-nowrap">2</td>
	        <td class="text-nowrap">월간보고</td>
	        <td class="text-nowrap">OOO</td>
	        <td class="text-nowrap">개발팀</td>
	        <td class="text-nowrap">2022-11-04</td>
	        <td class="text-nowrap">25</td>
	      </tr>
	      <tr class="align-middle">
	        <td class="text-nowrap">1</td>
	        <td class="text-nowrap">월간보고</td>
	        <td class="text-nowrap">OOO</td>
	        <td class="text-nowrap">개발팀</td>
	        <td class="text-nowrap">2022-11-04</td>
	        <td class="text-nowrap">25</td>
	      </tr>
	    </tbody>
	  </table>
	</div>
	
<script>
	$(".align-middle").on('click', function(event){
		location.href="${cPath}/groupware/docmanage/docManagerReportDetail.do";
	})

</script> 
	
	<pre>
	
	
	
	</pre>

</div>