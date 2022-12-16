<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	text-align : center;
}
h5{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
p{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
span{
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-align : center;
}
ul{
	font-family: 'IBM Plex Sans KR', sans-serif;
	
}
li{
	font-family: 'IBM Plex Sans KR', sans-serif;
	
}
</style>
	<!-- -------------------------- -->
   	 <!-- 회사 찾아 오시는 길 소개(웹페이지) -->
   	<!-- -------------------------- -->
	<br>
    <h1 style="font-size: 60px;">찾아오시는 길</h1>
    <hr>
    <br>
    <h2 style="font-size : 45px;">[대전 본사]</h2>
    <br>
    <ul style="margin-left:25%; font-size : 25px;">
    	<li style="font-size : 25px;"><label style="font-weight:bold;">도로명 주소</label> : 대전 중구 계룡로 846 3층 </li>
    	<li style="font-size : 25px;"><label style="font-weight:bold;">지번 주소</label> : 대전 중구 오류동 175-13 3층 </li>
    	<li style="font-size : 25px;"><label style="font-weight:bold;">대표 전화</label> : 042-222-8202 </li>
    </ul>
    <div id="map" style="width:50%;height:500px; margin-left:25%;"></div>
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8093bac0a735032097e7b67a753ed132&libraries=services"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(36.32662492140825, 127.40698001618316),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('대전 중구 계룡로 846', function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });

		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">AutumnOffice</div>'
		        });
		        infowindow.open(map, marker);

		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});    

	</script>
