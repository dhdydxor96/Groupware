<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.pagination{
		margin-left: 427px;
	}	
	
	.addrSet{
		position: relative;
		top: 40px;
	}
	
	.addrSelector{
		position: absolute;
		width: 100px;
		height:30px;
		top: 40px;
		left: 507px;
		
	}
	
	.addrSearch{
		position: absolute;
		width: 244px;
		height:30px;
		top: 40px;
		left: 611px;
	}
	
	.searchButton{
		position: absolute;
		width: 70px;
		height:30px;
		top: 40px;
		left: 860px;
	}
	
	section {
	   width: 85%;
	   height: 70%px;
	   background: white;
	   float: left;
	   padding : 5px;
	   position: relative;
	}
	
	.aTagSetting{
		font-size: 0.8em;
	}
	
	#addrTable{
			padding-right: 15px;
			padding-left: 10px;
			width : 100%;
			border-collapse: separate;
			border-spacing:2px;
			text-align: center;
	}
</style>
	<section>
		<h5 class="addrSet">사용자 미납 현황</h5><br><br>
		 <select class="form-control addrSelector" id="basic-example">
		  <option>전체검색</option>
		  <option>대표자명</option>
		  <option>회사명</option>
		  <option>서비스종료일</option>
		  <option>미납일</option>
		</select>
		<input class="form-control addrSearch" type="text" placeholder="검색">
		<button class="btn btn-falcon-default mr-1 searchButton" type="button" >검색</button>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>대표자명</th>
					<th>회사명</th>
					<th>서비스 시작일</th>
					<th>서비스 종료일</th>
					<th>미납일</th>
				</tr>
			</thead>
			<tbody>
			    <tr>
			      <td scope="row">추가을</td>
			      <td>가을 오피스</td>
			      <td>2021-11-01</td>
			      <td>2022-11-01</td>
			      <td>3일</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			</tbody>
		</table>
		<nav aria-label="Page navigation example">
		  <ul class="pagination">
		    <li class="page-item"><a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span></a></li>
		    <li class="page-item active"><a class="page-link" href="#">1</a></li>
		    <li class="page-item"><a class="page-link" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		    <li class="page-item"><a class="page-link" href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span></a></li>
		  </ul>
		</nav>		
	</section>