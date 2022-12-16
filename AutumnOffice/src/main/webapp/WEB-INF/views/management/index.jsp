<%@page import="java.net.Inet4Address"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
h1{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
h2{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
h3{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
h4{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
h5{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
p{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
span{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
th{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
td{
	font-family: 'IBM Plex Sans KR', sans-serif;
}
</style>	

	<!-- 시큐리티 설정 -->
	<security:authorize access="isAuthenticated()">
				<security:authentication property="principal" var="principal"/>
	</security:authorize>
    
<div class="card mb-3" style="padding:1%; font-family: 'IBM Plex Sans KR', sans-serif; text-align:center; height: 1100px;  margin-top: 1%;">

<h1 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size: 40px; margin-top:6%;">🍁 ${selectIndexView.comCnm } 관리자님 환영합니다.</h1>
<br><br>
<!-- 데이터를 끌어와서 집어넣어야함 -->
<table class="table table-hover">
	<tr>
		<th style="font-weight:bold; font-size:20px;">회사명</th>
		<td style="width:40%; font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:20px;">${selectIndexView.comCnm }</td>
		<th style="font-weight:bold; font-size:20px;">담당자</th>
		<td style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:20px;">${selectIndexView.comNm }</td>
	</tr>
	
	<tr>
		<th style="font-weight:bold; font-size:20px;">도메인명</th>
		<td style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:20px;">${selectIndexView.comDomain }</td>
	<c:choose>
		<c:when test="${principal.realUser.comDiv  eq 0}">
		<th style="font-weight:bold; font-size:20px;">도입일자</th>
		<td style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:20px;">${selectIndexView.serStd }</td>
	</tr>
	
	<tr>
		<th style="font-weight:bold; font-size:20px;">사용 기간</th>
		<td style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:20px;">${selectIndexView.serStd } ~ ${selectIndexView.serEnd }</td>
		</c:when>
	</c:choose>
		<th style="font-weight:bold; font-size:20px;">로그인 IP</th>
		<td style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:20px;"><%
			out.print(Inet4Address.getLocalHost().getHostAddress());
		%></td>
	</tr>
	
</table>
<!-- chart section (chart.js)-->
<div id="chart-container">
	<br>
	<h4 style="font-family: 'IBM Plex Sans KR', sans-serif; font-weight:bold; font-size:20px; text-align:center;">금년 매출 지표</h4>
	<br>
	<canvas id="barChart"></canvas>
</div>
</div>




<script type="text/javascript">
	var barChart = document.getElementById('barChart').getContext('2d');

	var myBarChart = new Chart(barChart, {
		type: 'bar',
		data: {
			labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
			datasets : [{
				label: "Sales",
				backgroundColor: 'rgb(23, 125, 255)',
				borderColor: 'rgb(23, 125, 255)',
				data: [3, 2, 9, 5, 4, 6, 4, 6, 7, 8, 7, 4],
			}],
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



