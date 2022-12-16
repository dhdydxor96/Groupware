<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	td {
		padding:1%;
	}

</style>

    
<div class="card md-3">

	<br>
	
	<h3>보고 지시 추가</h3>

	<br>
	
	<table>
		<tr>
			<th>제목</th>
			<td><input type="text" class="form-control" /></td>
		</tr>
		<tr>
			<th>설명</th>
			<td><input type="text" class="form-control" /></td>
		</tr>
		<tr>
			<th>비공개 여부</th>
			<td><input type="checkbox" /> 비공개 설정</td>
		</tr>
	</table>
	<hr>
	<table>
		<tr>
			<th>보고자</th>
			<td>
				<input type="radio" />부서원 전체&nbsp;&nbsp; 
				<input type="radio" />직접지정 &nbsp;&nbsp; 
				<span class="fas fa-plus"></span> 추가
			</td>
		</tr>
		<tr>
			<th>참조자</th>
			<td>
				<span class="fas fa-plus"></span> 추가
			</td>
		</tr>
		<tr>
			<th>유형</th>
			<td>
				<input type="radio" />정기보고서&nbsp;&nbsp; 
				<input type="radio" />수시보고서&nbsp;&nbsp; <br>
				<input type="date"  />
			</td>
		</tr>
		
		
		<tr>
			<td colspan="2" style="text-align: center">
				<button class="btn btn-primary me-1 mb-1">등록</button>
				<button class="btn btn-secondary me-1 mb-1">취소</button>
			</td>
		</tr>
			
	</table>
	



</div>