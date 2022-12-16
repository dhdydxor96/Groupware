<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 
<style>
.box{
	margin:15px;

}
.box-sm{
	margin:10px;
}
</style>
    
<div class="card md-3">

	<div>
		<h3>주간업무보고</h3>
		<h6>| 개발팀</h6>
	</div>
	<hr>
	<div>
		<h6>보고주기 : 매주 목요일 </h6>
		<h6>보고자 : 이찬솔, 윤정식 </h6>
		<h6>참조자 : 없음 </h6>
		<h6>주간 이슈 사항만 간략하게 보고 </h6>
	</div>
</div>
<br>
<div class="card md-3">

	<h6 style="color:red">미보고자</h6>
		<div class="box" style="background-color: #FFE4E1">
			<div class="box-sm" style="width:150px;background-color: white">
				(프로필) OOO 사원
			</div>
		</div>
</div>
<br>
<div class="card md-3">
	<h6 style="color:skyblue">보고자</h6>
		<div class="box" style="background-color: #AFEEEE">
			<div class="box-sm" style="width:150px;background-color: white">
				(프로필) OOO 사원
			</div>
		</div>

</div>
<br>
<div class="table-responsive scrollbar card md-3">
  <table class="table table-hover table-striped overflow-hidden">
    <thead>
      <tr>
        <th scope="col">보고일자</th>
        <th scope="col">보고제목</th>
        <th scope="col">보고자</th>
      </tr>
    </thead>
    <tbody>
      <tr class="align-middle">
        <td class="text-nowrap">2022-10-10</td>
        <td class="text-nowrap">보고합니다</td>
        <td class="text-nowrap">윤정식</td>
      </tr>
      <tr class="align-middle">
        <td class="text-nowrap">2022-10-10</td>
        <td class="text-nowrap">보고합니다</td>
        <td class="text-nowrap">윤정식</td>
      </tr>
    </tbody>
  </table>
</div>


<script>
	$(".align-middle").on('click', function(event){
		location.href="${cPath}/groupware/report/dept/deptReportContentDetail.do";
	})

</script> 