<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${cPath }/resources/groupware/jstree/dist/themes/proton/style.min.css" />

<style type="text/css">
img{
	-webkit-user-drag: none;
}
.archive-wrapper {
	height: 700px;
	padding: 15px;
	min-width: 1000px;
}
.archive-content{
	height: 600px;
	display: flex;
	justify-content: space-between;
	margin-top:15px;
}
.content-area{
	float:right;
	width : 1100px;
	overflow: auto;
	overflow-x: hidden; 
	border-top :1px solid #D8D8D8;
	padding-top : 15px;
}
#tree-area{
	width: 230px;
	margin-right:50px;
	border:1px solid #D8D8D8;
	border-radius: 5px;
	overflow: auto;
}
.file-block{
	width:100%;
	height:115px;
	border: 1px solid #D8D8D8;
	border-radius: 8px;
}
.file-block:hover{
	background-color: #ECF2FC;
	cursor: pointer;
}
.content-block{
	display:inline-block;
	width:115px;
	margin:5px;
	-webkit-user-select:none;
	-moz-user-select:none;
	-ms-user-select:none;
	user-select:none;
}
.img-box{
	text-align: center;
}
.block-img{
	margin : 0 auto;
}
.block-check{
	margin-left: 4px;
}
.file-name{
	text-align: center;
	font-size: 0.8em;
}
.button-block{
	display: inline-block;
	margin-right:8px;
	cursor: pointer;
	-webkit-user-select:none;
	-moz-user-select:none;
	-ms-user-select:none;
	user-select:none
}
.button-block:hover{
	border-bottom: 1px solid #D8D8D8;
}
.button-block:active{
	color: #D8D8D8;
}
.archive-buttons{
	margin-left: auto;
	margin-right: 25px;
	height:20px;
}
.dropdown-inner{
	margin-left : 15px;
	margin-right : 15px;
}
.dropdown-inner > p{
	margin:0;
	color:#BDBDBD;
}
#create-dir{
	margin-top : 5px;
	float:right;
}
.alert-ok{
	background-color : #2E64FE;
}
.app-content{
	min-width:800px;
}
.add-area{
	width:600px;
	margin:0 auto;
}
.add-table{
	height:300px;
	overflow: auto;
	overflow-x: hidden;
}
.add-label{
	height:50px;
}
#selfile-area{
	table-layout: fixed;
	width: 450px;
}
#selfile-area > tr > td:first-child{
	width:450px;
}
#selfile-area > tr > td:nth-child(2){
	width:100px;
}
#file-label{
	cursor: pointer;
	float:right;
	margin-top:10px;
	margin-right:20px;
}
#file-label > span:hover{
	border-bottom: 1px solid #D8D8D8;
}
#file-label > span:active{
	color: #D8D8D8;
}
.progress{
	padding:0px !important;
}
.progress-setting{
	height:52px;
}
.btn-area{
	height:40px;
}
</style>
<div class="archive-wrapper card md-3">
	<h4>개인 자료실</h4>
	<div class="archive-buttons">
		<div id="back" class="button-block">
			<img src="${cPath }/resources/groupware/icon/backward.png">
			<span>상위 폴더로</span>
		</div>
		<div id="upload" class="button-block" data-bs-toggle="modal" data-bs-target="#error-modal" id="app-info">
			<img src="${cPath }/resources/groupware/icon/upload.png">
			<span>업로드</span>
		</div>
		<div id="download" class="button-block">
			<img src="${cPath }/resources/groupware/icon/download.png">
			<span>다운로드</span>
		</div>
		<div id="newdir" class="button-block" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			<img src="${cPath }/resources/groupware/icon/add-folder.png">
			<span>새 디렉토리</span>
		</div>
		<!-- drop down ============================================== -->
		<div class="dropdown font-sans-serif d-inline-block mb-2">
			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<div class="dropdown-inner">
					<p>폴더 이름</p>
					<div class="dropdown-divider"></div>
					<input id="dirName" type="text" name="dirName" autocomplete="off" class="form-control form-control-sm"/>
					<button id="create-dir" type="button" class="btn btn-outline-primary btn-sm">생성</button>
				</div>
			</div>
		</div>
		<!-- ======================================================== -->
		<div id="remove" class="button-block">
			<img src="${cPath }/resources/groupware/icon/remove.png">
			<span>삭제</span>
		</div>
	</div>
	<div class="archive-content">
		<div id="tree-area" class="scrollbar">
		</div>
		<div class="content-area scrollbar">
		</div>
	</div>
</div>
<!-- ================================================================================ -->
<!-- Modal Area -->
<!-- ================================================================================ -->
<div class="modal fade" id="error-modal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog modal-dialog-centered modal-lg mt-6"
		role="document">
		<div class="modal-content position-relative app-content">
			<div class="position-absolute top-0 end-0 mt-2 me-2 z-index-1">
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-lg py-3 ps-4 pe-6 bg-light">
					<h4 class="mb-1" id="modalExampleDemoLabel"></h4>
				</div>
				<div class="file-wrapper">
					<div class="add-area">
						<div class="add-label">
							<label id="file-label" for="uploadFile">
								<img src="${cPath }/resources/groupware/icon/upload.png">
								<span>추가</span>
							</label>
							<input type="file" name="uploadFile" id="uploadFile" multiple="multiple" style="display:none;">
						</div>
						<div class="add-table scrollbar">
							<table id="selfile-area" class="table table-hover">
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="btn-area">
					<button class="btn btn-outline-secondary" id="cancel" type="button"
						data-bs-dismiss="modal">취소</button>
					<button class="btn btn-outline-primary" id="file-submit" type="button">업로드</button>
					<button class="btn btn-outline-primary" id="modal-close" type="button">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ================================================================================ -->
<script src="${cPath }/resources/groupware/jstree/dist/jstree.min.js"></script>
<script type="text/javascript" defer="defer">
	let treeData = []; 							// jstree에서 사용할 object가 저장될 배열
	let id = 1;									// jstree node 하나의 id
	let dataToJson = null;						// data를 json으로 파싱한 값을 담을 전역 변수
	let treeArea = $("#tree-area");				// jstree가 담길 div
	let contentArea = $(".content-area");		// 폴더 내부의 파일들이 담길 div
	let thisPath = "";							// 현재 폴더 경로
	let thisId = 1;								// 현재 폴더의 id
	let thisParent = 1;							// 현재 폴더 부모 폴더의 id
	let modal = $("#error-modal");				// 업로드 버튼클릭시 나오는 모달
	// -----------------------------------------------------------------
	// 페이지 로드되면 한번만 실행
	// ftp 서버에 있는 파일 리스트 로딩해서 jstree 로 맵핑
	!function() {

		$.ajax({
			url : "${cPath}/groupware/archive/dirDepthList.do",
			method : "get",
			data : {
				path : ""
			},
			dataType : "json",
			success : function(resp) {
				let root = fn_makeTreeObj(id, "#", "내 문서");
				treeData.push(root);
				contentArea.empty();
				$.each(resp, function(index, data) {
					if(data.dir == true){
						id++;
						let treeObj = fn_makeTreeObj(id, 1, data.text);
						
						treeData.push(treeObj);
					}
					let divBlock = fn_makeBlock(data);
					contentArea.append(divBlock);
				});
				if( !(treeData.length > 0) ) return;
				dataToJson = JSON.stringify(treeData);
				fn_bindJstree(dataToJson);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});

	}();
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 업로드 버튼 클릭 이벤트
	// 모달에 선택한 파일리스트 비우기
	// 선택한 파일 저장된 배열 비우기
	// 파일 삭제를 위한 fileId 초기화
	let uploadBtn = $("#upload");
	uploadBtn.on("click", function(){
		fileLabel.show();
		selfileArea.empty();
		cancelBtn.show();
		fileSubmitBtn.show();
		saveFileArr.length = 0; 
		fileId = 0;
		modalCloseBtn.hide();
	});
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 로컬에서 파일 선택시 이벤트
	// 선택된 파일 리스트를 saveFileArr에 저장
	// tr 태그를 만들어 ui에 표시
	// 삭제를 위한 fileId를 증가
	let saveFileArr = [];
	let fileLabel = $("#file-label");
	let uploadFile = $("#uploadFile");
	let fileId = 0;
	let selfileArea = $("#selfile-area");
	let cancelBtn = $("#cancel");
	let fileSubmitBtn = $("#file-submit");
	let modalCloseBtn = $("#modal-close");
	uploadFile.on("change", function(){
		console.log(this.files);
		let files = this.files;
		for(let i=0;i<files.length;i++){
			let file = files[i];
			let objFile = {
				id : fileId
				, file : file
			}
			saveFileArr.push(objFile);
			let fileName = file.name;
			if(fileName.length > 30){
				fileName.substring(0,30) + "..";
			}
			let fileSize = getByteSize(file.size);
			
			let trTag = fn_makeTrTag(fileId + 1, fileName, fileSize);
			selfileArea.append(trTag);
			
			fileId++;
		}
	});
	
	// 모달 내부에서 파일 업로드 버튼 클릭
	// saveFileArr에 들어있던 파일 리스트를 비동기 통신
	// 현재 위치한 폴더가 path 이다.
	let fileSubmit = $("#file-submit");
	fileSubmit.on("click", function(){
		if(saveFileArr.length <= 0){
			toastr.error("선택한 파일이 없습니다.");
			return;
		}
		fileLabel.hide();
		fn_uploadAjaxAwait(saveFileArr, thisPath);
	});
	
	async function fn_uploadAjaxAwait(files, thisPath){
		
		let filebox = $(".progress-setting");
		let btnDel = $(".btn-del");
		
		cancelBtn.hide();
		fileSubmitBtn.hide();
		btnDel.remove();
		console.log(btnDel);
		
		for(let i=0;i<files.length;i++){
			
			let form = new FormData();
			let file = files[i].file;
			form.append("uploadFile", file);
			form.append("path", thisPath);
			
			let progressbar = fn_makeProgressTag();
			console.log(progressbar);
			console.log(filebox[i]);
			$(filebox[i]).after(progressbar);
			var promise = await fn_uploadAjax(i, form);
		}
		
		fn_ajaxMoveDir(thisPath);
		modalCloseBtn.show();
	}
	
	function fn_uploadAjax(index, data){
		
		let progressbar = $(".progress-bar");
		let completeTd = $(".complete-td");
		
		return new Promise(function(resolve, reject){
			$.ajax({
				xhr: function() {
					var xhr = new window.XMLHttpRequest();
					
					xhr.upload.addEventListener("progress", function(event) {
						if (event.lengthComputable) {
							var percentComplete = event.loaded / event.total;
							percentComplete = parseInt(percentComplete * 100);
							
							$(progressbar[index]).attr("style", "width:"+percentComplete+"%");
							let iconTag = $("<img>").attr("src", "${cPath}/resources/groupware/icon/check.png")
													.attr("class", "icon-img");
							if (percentComplete === 100) {
								$(completeTd[index]).append(iconTag);	
							}
						}
					}, false);
					return xhr;
				},
				url : "${cPath}/groupware/archive/uploadFile.do",
				method : "post",
				data : data,
				contentType : false,
				processData : false,
				enctype : 'multipart/form-data',
				dataType : "json",
				success : function(resp) {
					console.log(resp);
					resolve(resp);
				},
				error : function(errorResp) {
					console.log(errorResp.status);
					reject(errorResp);
				}
			});
		});
	}
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 업로드 완료 후 닫기 버튼을 통해 모달창 닫기
	modalCloseBtn.on("click", function(){
		modal.modal("hide");
	});
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 모달 내부에서 선택한 파일 삭제하는 이벤트
	// 삭제 버튼에 저장한 data를 꺼내와서 saveFileArr에서 삭제
	// tr태그 한줄 삭제
	$(document).on("click", ".btn-del", function(){
		let id = $(this).data("saveid");
		saveFileArr.splice(id, 1);
		let delElement = $(this).parent().parent();
		delElement.remove();
		console.log("del after : ", saveFileArr);
	});	
	// ===================================================================
	
	// -------------------------------------------------------------------
	// 바이트를 kb, mb, gb, tb로 계산해주는 함수
	const getByteSize = (size) => {
		const byteUnits = ["KB", "MB", "GB", "TB"];
		
		for(let i=0;i<byteUnits.length;i++) {
			size = Math.floor(size / 1024);
		  if(size<1024) return size.toFixed(1) + byteUnits[i];
		}
	};
	// ===================================================================
	
	// -------------------------------------------------------------------
	// tr 태그 생성 함수
	// id : 삭제를 위해 버튼에 data 속성에 저장시킬 id
	// text : 파일 이름
	// size : 파일 사이즈
	// tr 태그 한줄을 만들어서 반환
	function fn_makeTrTag(id, text, size){
		let trTag = $("<tr>").attr("class", "progress-setting")
							.append( $("<td>").text(text) )
							.append( $("<td>").text(size) )
							.append( $("<td>").attr("class", "complete-td")
											.append( $("<button>").attr("class", "btn btn-light btn-del")
																	.data("saveid", id-1)
																	.append( $("<span>").attr("class", "fas fa-trash-alt") ) ) 
																);
		
		return trTag;
	}
	
	function fn_makeProgressTag(){
		let progress = $("<tr>").append( 
				$("<td>").attr("colspan", 3)
						.append(
							$("<div>").attr("class", "progress")
									.attr("style", "height:2px;")
									.append(
										$("<div>").attr("class", "progress-bar")
													.attr("role", "progressbar")
													.attr("style", "width: 0%")
													.attr("aria-valuenow", "25")
													.attr("aria-valuemin", "0")
													.attr("aria-valuemax", "100")
									)
						)	
			);	
		return progress;
	}
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 현재 폴더에 저장된 파일 하나 UI를 만들어주는 함수
	// data의 dir을 통해 매개변수의 데이터가 파일인지 폴더인지 검사하고 폴더이면 폴더 이미지 생성
	// 파일 제목 뒤에서 첫번째 . 을 찾아서 확장자 비교하여 파일 아이콘 생성
	// 파일 제목 길이가 8보다 클 시에 8뒤에 텍스트 자르고 ..으로 변환
	function fn_makeBlock(data){
		let text = data.text;
		let dotIndex = text.lastIndexOf(".");
		let fileExtention = text.substring(dotIndex+1, text.length);
		let imgTag;
		let cutText = "";
		
		if(data.dir){
			imgTag = fn_makeDirImg(text);
		}else{
			imgTag = fn_makeExtensionImg(fileExtention);
		}
		
		if(text.length > 8){
			cutText = text.substring(0,8) + "..";
		}else{
			cutText = text;
		}
		
		let contentBlock = $("<div>").attr("class", "content-block")
									.append(
										$("<div>").attr("class", "file-block")
												.append( 
														$("<input>").attr("type", "checkbox")
														.attr("name", "fileName")
														.attr("value", text)
														.attr("class", "form-check-input block-check")
												)
												.append( $("<br>"))
												.append(
													$("<div>").attr("class", "img-box")
																.append(imgTag)
												)
									).append(
										$("<p>").attr("class", "file-name")
												.text(cutText)
									);
		
		let research = contentBlock.find(".file-block");
		if(data.dir){
			research.attr("class", "file-block dir").data("fnm", text);
		}
		return contentBlock;						
	}
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 새 폴더 생성 버튼 이벤트
	// 버튼 클릭했을때 폴더 이름적는 input tag 초기화
	let newdir = $("#newdir");
	let dirInput = $("#dirName");
	newdir.on("click", function(){
		dirInput.val("");
	});
	
	// 생성할 폴더 이름을 적고 생성버튼 누를시 이벤트
	// 특수문자 정규식을 이용해 특수문자 체크
	// 정규식을 통과하지 못했을 시 toastr 띄우고 return
	// 정규식 통과했을 시 ftp서버 폴더 생성 비통기통신
	let createDirBtn = $("#create-dir");
	createDirBtn.on("click", function(){
		let dirName = dirInput.val();
		const regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g;
		let reg = regExp.test(dirName);
		console.log(reg);
		if(reg){
			toastr.error("특수문자는 사용할 수 없습니다.");
			return;
		}
		let path = thisPath;
		let result = fn_createDir(path, dirName);
	});
	
	// 현재 경로와 생성할 폴더 이름을 파라미터로 받는다.
	// ftp서버에 생성이 완료됐으면 jstree에 자식노드 추가
	// ftp서버에 생성이 완료됐으면 현재 폴더 fn_ajaxMoveDir을 통해 다시 로드
	function fn_createDir(path ,dirName){
		$.ajax({
			url : "${cPath}/groupware/archive/createDir.do",
			method : "post",
			data : {path : path, dirName : dirName},
			dataType : "json",
			success : function(resp) {
				if(resp){
					fn_ajaxMoveDir(path);
					id++;
					let treeObj = fn_makeTreeObj(id, thisId, dirName);
					treeArea.jstree("create_node", thisId, treeObj, "last");
				}else{
					toastr.error("같은 이름의 폴더가 존재합니다.");
					return false;
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				toastr.info("폴더 생성 실패");
			}
		});
		return true;
	}
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 상위 폴더 이동 이벤트
	// 현재 경로를 받아와서 "/"로 자르고 맨뒤 경로의 길이 받아와서 자른다.
	// 상위폴더 경로로 다시 로드
	// 현재 폴더 id, 상위 폴더 id 셋팅
	let backBtn = $("#back");
	backBtn.on("click", function(){
		let cutPathArr = thisPath.split("/");
		let strlength = cutPathArr[cutPathArr.length-1].length + 1;
		let backPath = thisPath.substr(0, thisPath.length - strlength);
		thisPath = fn_ajaxMoveDir(backPath);
		
		thisId = treeArea.jstree(true).get_node(thisId).parent;
		thisParent = treeArea.jstree(true).get_node(thisId).parent;
		console.log("thisId : ", thisId);
		console.log("thisParent : ", thisParent);
	});
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 파라미터 경로로 ftp 서버에 접속해 파일을 로드시켜주는 함수
	function fn_ajaxMoveDir(path){
		$.ajax({
			url : "${cPath}/groupware/archive/dirDepthList.do",
			method : "get",
			data : {
				path : path
			},
			dataType : "json",
			success : function(resp) {
				contentArea.empty();
				$.each(resp, function(index, data) {
					let divBlock = fn_makeBlock(data);
					contentArea.append(divBlock);
				});
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		return path;
	}
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 다운로드 버튼 이벤트
	// 체크된 파일 리스트 불러오기
	// 체크한 파일 없을 시 toastr 출력하고 return
	// 폴더 선택했을 시 toastr 출력하고 return
	// 선택한 파일 for문으로 비동기 통신
	let downloadBtn = $("#download");
	downloadBtn.on("click", function(){
		let checkBoxs = $(".block-check:checked");
		let path = thisPath;
		let dir = $(checkBoxs[0]).parent().attr("class");
		let dirCheck = dir.indexOf("dir");
		if(checkBoxs.length == 0){
			toastr.error("체크한 파일이 없습니다.");
			return;
		}
		if(dirCheck >= 0){
			toastr.error("폴더는 다운받을 수 없습니다.");
			return;
		}
		for(let i=0;i<checkBoxs.length;i++){
			fn_fileDownload(path, checkBoxs[i].value);
		}
	});
	
	// ftp 서버에서 파일을 삭제하는 비동기 통신
	// 파라미터 : 다운로드 할 파일이 위치한 경로, 다운로드할 파일 이름
	function fn_fileDownload(path, fileName){
		let data = {
			path : path
			, fileName : fileName
		}
		let jsonData = JSON.stringify(data);
		
		const xhr = new XMLHttpRequest();
		
		xhr.open("POST", "${cPath}/groupware/archive/fileDownload.do");
		xhr.setRequestHeader(header, token);
		xhr.responseType = "blob";
		xhr.setRequestHeader('Content-Type', 'application/json');
		
		xhr.onreadystatechange = function(){
			if(this.readyState == 4 && this.status == 200){
				var link=document.createElement('a');
				link.href=window.URL.createObjectURL(this.response);
				link.download=fileName;
				link.click();
			}
		}
		xhr.send(jsonData);
	}
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 삭제 버튼 이벤트
	// sweetalert를 통한 검증
	let removeBtn = $("#remove");
	removeBtn.on("click", function(){
		let checkBoxs = $(".block-check:checked");
		let path = thisPath;
		if(checkBoxs.length == 0){
			toastr.info("체크한 파일이 없습니다.");
			return;
		}
		
		swal({
			title : "정말 삭제하시겠습니까?"
			, text : "삭제한 파일은 복구할 수 없습니다."
			, icon : "warning"
			, buttons : {
				cancel : "취소"
				, confirm : {
					text : "삭제", 
					className: "alert-ok",
				}
			}
		}).then((isConfirm) => {
			if(isConfirm){
				let values = [];
				for(let i=0;i<checkBoxs.length;i++){
					values.push(checkBoxs[i].value);
				}
				let data = {
					"path" : path
					, "fileName" : values
				};
				
				let result = true;
				
				fn_fileRemove(data);
			}else{
				return;
			}
		});
	});
	
	// 파일 여러개 삭제할 시에 비동기 통신의 시간차이로 인해 stream 오류 발생
	// 해결하려고 promise 를 사용
	function fn_fileRemove(data){
		let result = true;
		let promise = new Promise( (resolve, reject) => {
			$.ajax({
				url : "${cPath}/groupware/archive/removeFile.do",
				method : "post",
				data : data,
				dataType : "json",
				success : function(resp) {
					result = resp;
					
					resolve(result);
				},
				error : function(errorResp) {
					reject(result);
					console.log(errorResp.status);
				}
			});
		} );
		
		promise.then( (resolve) => {
			let test = fn_ajaxMoveDir(data.path);
			
			$.each(data.fileName, function(index, fileName){
				for(let i=1;i<=id;i++){
					let node = treeArea.jstree(true).get_node(i);
					if(node.text == fileName){
						let nodeId = node.id;
						treeArea.jstree(true).delete_node(nodeId);
						break;
					}
				}
			});
			
			
		}).catch( (reject) => {
			toastr.error("파일 삭제 실패!");
		});
		
		return result;
	}
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 화면에 생성된 파일 이미지 클릭시 발생 이벤트
	// 토글형식으로 체크박스 운용
	$(document).on("click", ".img-box", function(){
		let checkbox = $(this).parent().find("input[name=fileName]");
		let checked = checkbox.is(":checked");
		if(checked){
			checkbox.prop("checked", false);
		}else{
			checkbox.prop("checked", true);
		}
	});
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 화면에 출력된 파일 박스 더블클릭시 이벤트
	// 파일 내부로 이동하면서 현재 경로, 현재 id 셋팅, 화면 다시 로드
	$(document).on("dblclick", ".dir", function(){
		let fnm = $(this).data("fnm");
		
		for(let i=1;i<=id;i++){
			let node = treeArea.jstree(true).get_node(i);
			console.log("thisId : ",node);
			console.log("thisParent : ",node.parent);
			if(node.text == fnm && thisId < node.id){
				thisId = node.id;
				thisParent = node.parent;
				break;
			}
		}
		console.log("thisId : ",thisId);
		let save = "/" + fnm;
		let path = thisPath + save;
		thisPath = path;
		
		$.ajax({
			url : "${cPath}/groupware/archive/dirDepthList.do",
			method : "get",
			data : {
				path : path
			},
			dataType : "json",
			success : function(resp) {
				contentArea.empty();
				$.each(resp, function(index, data) {
					let divBlock = fn_makeBlock(data);
					contentArea.append(divBlock);
				});
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	});
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 디렉토리 이미지 태그 생성
	function fn_makeDirImg(){
		let cPath = "${cPath}";
		let src = cPath + "/resources/groupware/icon/folder.png";
		
		let imgTag = $("<img>").attr("src", src)
								.attr("class", "block-img");
		
		return imgTag;
	}
	// ==================================================================
	
	// ------------------------------------------------------------------
	// 확장자별 이미지 태그 생성
	// parameter 파일 확장자명
	function fn_makeExtensionImg(textExtention){
		let src = "";
		let cPath = "${cPath}";
		switch(textExtention){
		case "exe":
			src = cPath + "/resources/groupware/icon/exe.png";
			break;
		case "jpg":
			src = cPath + "/resources/groupware/icon/image.png";
			break;
		case "jpeg":
			src = cPath + "/resources/groupware/icon/image.png";
			break;
		case "gif":
			src = cPath + "/resources/groupware/icon/image.png";
			break;
		case "png":
			src = cPath + "/resources/groupware/icon/image.png";
			break;
		case "pdf":
			src = cPath + "/resources/groupware/icon/pdf.png";
			break;
		case "xlsx":
			src = cPath + "/resources/groupware/icon/sheets.png";
			break;
		case "xls":
			src = cPath + "/resources/groupware/icon/sheets.png";
			break;
		case "zip":
			src = cPath + "/resources/groupware/icon/zip.png";
			break;
		default:
			src = cPath + "/resources/groupware/icon/file.png";
			break;
		}
		let imgTag = $("<img>").attr("src", src)
								.attr("class", "block-img");
		
		return imgTag;
	}
	// ==================================================================

	// ------------------------------------------------------------------
	// jstree 맵핑
	function fn_bindJstree(data) {
		treeArea.jstree({
			'plugins': ["wholerow"],
			'core' : {
				'check_callback' : true,
				'themes' : {
					'name' : 'proton',
					'responsive' : true
				},
				'data' : JSON.parse(data)
			}
		});
	}
	// ==================================================================

	// ------------------------------------------------------------------
	// jstree에서 사용할 데이터 셋팅하는 함수
	// parameter id, 부모노드 아이디, 노드 이름
	// return 오브젝트
	function fn_makeTreeObj(id, parent, dirName) {
		let treeObj = new Object();
		treeObj.id = id;
		treeObj.parent = parent;
		treeObj.text = dirName;
		
		return treeObj;
	}
	// ==================================================================

	// ------------------------------------------------------------------
	// ftp 서버에서 사용할 경로를 만들어주는 함수
	// parameter 선택한 노드 이름, 선택한 노드의 부모 배열
	// return 선택한 노드의 ftp서버 path
	function fn_makePath(text, parents) {
		let path = "";
		for (let i = parents.length - 1; i >= 0; i--) {
			let id = parents[i];
			let temp = treeArea.jstree(true).get_node(id).text;
			if(temp == "내 문서") continue;
			if (id == "#") {
				continue;
			} else {
				path += "/";
			}
			path += temp;
		}
		path += ("/" + text);
		if(text == "내 문서") path = "";
		thisPath = path;
		return path;
	}
	// ==================================================================

	// ------------------------------------------------------------------
	// jstree에 자식 노드 추가하는 함수
	function fn_addChild(data) {
		let test = treeArea.jstree("create_node", data.parent, data, "last",
				function(new_node) {
					treeArea.jstree("open_node", treeArea
							.jstree("get_selected"));
				});
	}
	// ==================================================================

	// ------------------------------------------------------------------
	// 노드 선택시 이벤트
	// ajax로 비동기 통신을 한 후 자식노드가 있다면 새로 생성
	treeArea.on('select_node.jstree', function(e, data) {
		treeArea.jstree("open_node", treeArea
				.jstree("get_selected"));
		let parents = data.node.parents;
		let parent = data.node.id;
		let text = data.node.text;
		let path = fn_makePath(text, parents);
		let children = data.node.children;
		thisPath = path;
		thisId = parent;
		thisParent = parents[0];
		console.log("thisId", thisId);
		console.log("thisParent", thisParent);
		console.log(data);
		$.ajax({
			url : "${cPath}/groupware/archive/dirDepthList.do",
			method : "get",
			data : {
				path : path
			},
			dataType : "json",
			success : function(resp) {
				contentArea.empty();
				$.each(resp, function(index, data) {
					if ( !(children.length > 0) ) {
						if(data.dir == true){
							id++;
							let treeObj = fn_makeTreeObj(id, parent, data.text);
							fn_addChild(treeObj);
						}
					}
					let divBlock = fn_makeBlock(data);
					contentArea.append(divBlock);
				});
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	})
	// ==================================================================
</script>