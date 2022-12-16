<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>
<c:set var="surveyInvestigation" value="${surveyInvestigation }"/>
<c:set var="surveyResponse" value="${surveyResponse }"/>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
	font-weight:bold;
}
</style>
<div class="card mb-3" style="padding:5%; font-family: 'IBM Plex Sans KR', sans-serif;">
<h3 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; float:left; font-size:30px;"><span class="fas fa-chart-pie"></span>&nbsp;진행중인 객관식 설문 조사 결과 통계</h3>
<hr>
<table class="table table-bordered" style="width: 100%; vertical-align: middle;">
		<tr>
			<th style="width:20%;">설문 제목</th>
			<td>${surveyResponse[0].surTitle}</td>
		</tr>
		<tr>
			<th>설문 목적</th>
			<td>${surveyResponse[0].surPurpose}</td>
		</tr>	
		<tr>
			<th>설문작성 안내내용</th>
			<td>${surveyResponse[0].surGuide}</td>
		</tr>
		<tr>
			<th>설문 기간</th>
			<td>${surveyResponse[0].surSdate} ~ ${surveyResponse[0].surEdate}</td>
		</tr>
</table>

<form>
	<input type="hidden" value="${surveyResponse[0].surinvFirst}" id = "surinvFirst">
	<input type="hidden" value="${surveyResponse[0].surinvSecond}" id = "surinvSecond">
	<input type="hidden" value="${surveyResponse[0].surinvThird}" id = "surinvThird">
	<input type="hidden" value="${surveyResponse[0].surinvFour}" id = "surinvFour">
	<input type="hidden" value="${surveyResponse[0].surinvFive}" id = "surinvFive">
	<input type="hidden" value="${surveyResponse[0].surresChofirst}" id = "surresChofirst">
	<input type="hidden" value="${surveyResponse[0].surresChosecond}" id = "surresChosecond">
	<input type="hidden" value="${surveyResponse[0].surresChothird}" id = "surresChothird">
	<input type="hidden" value="${surveyResponse[0].surresChofour}" id = "surresChofour">
	<input type="hidden" value="${surveyResponse[0].surresChofive}" id = "surresChofive">
</form>
<br>
<div>
  <canvas id="logChart"></canvas>
</div>
	<br><br>
	<a href="${cPath }/groupware/survey/surveyProgressList.do" id="backBtn" class="btn btn-outline-secondary me-1 mb-1" style="margin-left:39%; width:25%; font-weight: bold; font-family: 'IBM Plex Sans KR', sans-serif;">목록</a>
</div>
<script>

  let label = [];
  let dataResult =[];

  var ctx = document.getElementById('logChart').getContext('2d');

  var surinvFirst = $("#surinvFirst").val();
  var surinvSecond = $("#surinvSecond").val();
  var surinvThird = $("#surinvThird").val();
  var surinvFour = $("#surinvFour").val();
  var surinvFive = $("#surinvFive").val();
  
  if(surinvFirst != null && surinvFirst != ''){
	  label.push(surinvFirst);
  }
  if(surinvSecond != null && surinvSecond != ''){
  	label.push(surinvSecond);
  }
  if(surinvThird != null && surinvThird != ''){
 	label.push(surinvThird);
  }
  if(surinvFour != null && surinvFour != ''){
  	label.push(surinvFour);
  }
  if(surinvFive != null && surinvFive != ''){
  	label.push(surinvFive);
  }
  
  
  var surresChofirst = $("#surresChofirst").val();
  var surresChosecond = $("#surresChosecond").val();
  var surresChothird = $("#surresChothird").val();
  var surresChofour = $("#surresChofour").val();
  var surresChofive = $("#surresChofive").val();
  
  if(surresChofirst != null){
  dataResult.push(surresChofirst);
}
  if(surresChosecond != null){
	  dataResult.push(surresChosecond);
}
  if(surresChothird != null){
	  dataResult.push(surresChothird);
}
  if(surresChofour != null){
	  dataResult.push(surresChofour);
}
  if(surresChofive != null){
	  dataResult.push(surresChofive);
}
  
  
  
  
  
  var myChart = new Chart(ctx, {
    type: 'pie',
    data: {
      labels: label ,
      datasets: [{
    	  data: dataResult , //컨트롤러에서 모델로 받아온다.
          backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 205, 86, 0.2)',
              'rgba(88, 255, 111, 0.2)',
              'rgba(224, 224, 224, 0.2)',

          ],
          borderColor: [
              'rgba(255,99,132,1)',
              'rgba(54, 162, 235, 1)',
              'rgba(255, 205, 86, 1)',
              'rgba(88, 255, 111, 1)',
              'rgba(224, 224, 224, 1)',

          ],
          borderWidth: 1
      }
      ]
  },
  options: {
      scales: {
          yAxes: [{
              ticks: {
                  beginAtZero:true
              }
          }]
      }
  }
});
</script>