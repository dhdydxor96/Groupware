<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="${cPath}/resources/js/ckeditor/ckeditor.js"></script>
 
<style>
.box{
	margin:15px;

}
.box-sm{
	margin:10px;
}
button{
	width:100px;
	
}
</style>
    
<div class="card md-3">

	<div>
		<h3>주간업무보고</h3>
		<h6>| 개발팀</h6>
	</div>
</div>
<br>
<div class="card md-3">

	<h5>OOO대리</h5>
	<br>
	
	<textarea name="boContent" rows="" cols=""></textarea>

<br><br><br>

<div style="text-align: center;">
	<button class="btn btn-primary me-1 mb-1">등록</button><button class="btn btn-secondary me-1 mb-1">취소</button>
</div>


</div>
<script>
	CKEDITOR.replace('boContent'); //textArea의 ID값을 넣어준다 ★
</script>