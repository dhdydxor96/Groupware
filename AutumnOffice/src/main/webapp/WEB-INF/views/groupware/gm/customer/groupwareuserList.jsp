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
		left: 550px;
		
	}
	
	.addrSearch{
		position: absolute;
		width: 244px;
		height:30px;
		top: 40px;
		left: 654px;
	}
	
	.searchButton{
		position: absolute;
		width: 70px;
		height:30px;
		top: 40px;
		left: 903px;
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
		<h5 class="addrSet">그룹웨어 사용자 조회</h5><br><br>
		<select class="form-control addrSelector" id="basic-example">
		    <option>전체검색</option>
		    <option>제목</option>
		    <option>날짜</option>
	 	</select>
	 	<input class="form-control addrSearch" type="text" placeholder="검색">
	 	<button class="btn btn-falcon-default mr-1 searchButton" type="button" >검색</button>	
		<table class="table table-hover">
			<thead class="thead-dark">
				<tr>
					<th>대표자명</th>
					<th>회사명</th>
					<th>회사주소</th>
					<th>회사전화번호</th>
					<th>휴대폰번호</th>
					<th>사용자수</th>
					<th>사용용량</th>
					<th>사용자 정보</th>
				</tr>
			</thead>
			<tbody>
			    <tr>
			      <td scope="row">추가을</td>
			      <td>가을 오피스</td>
			      <td>중구 용두동</td>
			      <td>042-8282-8282</td>
			      <td>010-5279-7942</td>
			      <td>100</td>
			      <td>100GB</td>
			      <td><button type="button" class="btn btn-outline-info groupwareuserDetail">상세보기</button></td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td scope="row">1</td>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
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
	<hr>
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script>

	$(".groupwareuserDetail").on("click", function(){
		 $('#exampleModal').modal('show');
	})
	</script>