<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${cPath}/resources/js/ckeditor/ckeditor.js"></script>

<style>
	.pagination{
		margin-left: 427px;
	}	
	
	.addrSet{
		position: relative;
		top: 40px;
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
		<h5 class="addrSet">공지</h5><br><br>
		<form>
			<table>
			<tr>
				<td class="form-group">
				    <input class="form-control" id="name" type="text" placeholder="제목">
				</td>
			</tr>
			<tr>
				<td>
					<textarea class="form-control" name="boContent" cols="30" rows="5"></textarea>
				</td>
			</tr>
			<tr>
				<td class="form-group">
				    <label for="exampleFormControlFile1">첨부파일</label>
				    <input class="form-control-file" id="exampleFormControlFile1" type="file">
				</td>
			<tr>
			</table>
			<button class="btn btn-success  mr-1 mb-1" type="button">등록</button>
			<button class="btn btn-danger mr-1 mb-1" type="button">취소</button>
		</form>
	</section>
	

	<script>
	CKEDITOR.replace('boContent', {
		filebrowserImageUploadUrl:"${cPath}/board/imageUpload.do?type=image"
	});
</script>