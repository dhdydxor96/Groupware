<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style type="text/css">
.app-title {
	width: 40%;
}

.card-img-top{
	width:80px;
	margin-left:15px;
	margin-top:15px;
}

.def-padding-sm{
	padding:8px;
}

.def-padding-lg{
	padding:20px;
}

.app-doapp{
	width:100%;
}

.app-docArea{
	margin-top:25px;
}

.def-margin-sm{
	margin-top:50px;
}

</style>

<div class="card mb-3 def-padding-lg def-margin-sm">
	<div class="app-docArea">
		<h4>기안 진행 문서</h4>
		<table class="table table-hover overflow-hidden docBox-table">
			<thead>
				<tr>
					<th scope="col">문서번호</th>
					<th scope="col">결재양식</th>
					<th scope="col" style="width: 30%">제목</th>
					<th scope="col">기안자</th>
					<th scope="col" style="width:20%">기안일</th>
					<th scope="col">결재상태</th>
				</tr>
			</thead>
			<tbody class="draft">
				
			</tbody>
		</table>
	</div>
	
	<div class="app-docArea">
	<h4>완료 문서</h4>
		<table class="table table-hover overflow-hidden docBox-table">
			<thead>
				<tr>
					<th scope="col">문서번호</th>
					<th scope="col">결재양식</th>
					<th scope="col" style="width: 30%">제목</th>
					<th scope="col">기안자</th>
					<th scope="col" style="width:20%">기안일</th>
					<th scope="col">결재상태</th>
				</tr>
			</thead>
			<tbody class="complete">
			
			</tbody>
		</table>
	</div>
</div>

<form id="detailDocForm" method="get" action="${cPath }/groupware/approval/doc/docDetail.do">
	<input type="hidden" name="eleNo"/>
	<input type="hidden" name="eleMenu" value="결재 대기 문서"/>
</form>

<script type="text/javascript" defer="defer">

	!function(){
		$.ajax({
			url : "${cPath}/groupware/approval/approvalHome.do",
			method : "get",
			dataType : "json",
			success : function(resp) {
				console.log(resp);
				let draftDataList = resp.draftDataList;
				let completeDataList = resp.completeDataList;
				let waitDataList = resp.waitDataList;
				
				let draftArea = $(".draft");
				let completeArea = $(".complete");
				
				console.log(draftDataList);
				console.log(completeDataList);
				console.log(waitDataList);
				
				let draftTrTags = [];
				
				if(draftDataList.length > 0){
					$.each(draftDataList, function(index, data){
						let tr = makeTrTag(data);
						draftTrTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "6")
								 .html("조건에 맞는 게시글이 없음.")
					);
					draftTrTags.push(tr);
				}
				
				draftArea.append(draftTrTags);
				
				let completeTrTags = [];
				
				if(completeDataList.length > 0){
					$.each(completeDataList, function(index, data){
						let tr = makeTrTag(data);
						completeTrTags.push(tr);
					});
				}else{
					let tr = $("<tr>").html(
						$("<td>").attr("colspan", "6")
								 .html("조건에 맞는 게시글이 없음.")
					);
					completeTrTags.push(tr);
				}
				
				completeArea.append(completeTrTags);
				
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	}();
	
	let makeTrTag = function(data){
		let trTag = $("<tr>").attr("class", "docTr")
					.append( $("<td>").attr("class", "eleNo").text(data.eleNo) )
					.append( $("<td>").text(data.appForm.apfCat) )
					.append( $("<td>").text(data.eleTit) )
					.append( $("<td>").text(data.empNm) )
					.append( $("<td>").text(data.eleCrd) );
		switch(data.appStatus.apsStatus){
		case '0':
		trTag.append( $("<td>").append($("<span>")
		.attr("class", "badge badge-soft-primary")
		.text("진행중")));
		break;
		case '1':
		trTag.append( $("<td>").append($("<span>")
		.attr("class", "badge badge-soft-success")
		.text("승인")));
		break;
		case '2':
		trTag.append( $("<td>").append($("<span>")
		.attr("class", "badge badge-soft-danger")
		.text("반려")));
		break;
		}
		
		return trTag;
	}
	
	// =============================================
	// 결재 문서 상세보기
	// =============================================
	let detailDocForm = $("#detailDocForm");
	let docTr = $(document).on("click", ".docTr", function(){
		let eleNo = $(this).find(".eleNo").text();
		detailDocForm.find("input[name=eleNo]").val(eleNo);
		detailDocForm.submit();
	});
</script>