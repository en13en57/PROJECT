<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/assets/css/images/logo.png" />
<title>NG캠핑</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/main.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/swiper.min.css">



<script type="text/javascript">
	function logoutSubmit() {
		var logout = document.logout;
		logout.submit();
	}
	function change(val) {
		if (val.value == 'fst') {
			document.getElementById("selectfst").style.display = 'inline';
			document.getElementById("selectsnd").style.display = 'none';
		} else if (val.value == 'snd') {
			document.getElementById("selectfst").style.display = 'none';
			document.getElementById("selectsnd").style.display = 'inline';
		}
	}

	var csrf_token = "${_csrf.token}";
</script>



<style type="text/css">

image/x-icon {
  vertical-align: middle;
    height: 90px;
    width: 60px;
}


img {
    vertical-align: middle;
    height: 30px;
    width: 30px;
} 


element.style {
	width: 500px;
	height: 100px;
	margin: 0 auto;
}

#map {
	margin-top: 50px;
	margin-left: 300px;
}

.table-hover>tbody>tr:hover>* { -
	-bs-table-accent-bg: var(- -bs-table-hover-bg);
	color: var(- -bs-table-hover-color);
}


.table-hover>tbody>tr:hover>* { -
	-bs-table-accent-bg: var(- -bs-table-hover-bg);
	color: var(- -bs-table-hover-color);
}

.table>:not(caption)>*>* {
	padding: 0.5rem 0.5rem;
	background-color: var(- -bs-table-bg);
	border-bottom-width: 1px;
	box-shadow: inset 0 0 0 9999px var(- -bs-table-accent-bg);
}

.table>:not(caption)>*>* {
	padding: 0.5rem 0.5rem;
	background-color: var(- -bs-table-bg);
	border-bottom-width: 1px;
	box-shadow: inset 0 0 0 9999px var(- -bs-table-accent-bg);
}

table th {
	color: #ffffff;
	font-size: 0.9em;
	font-weight: 300;
	padding: 0 0.75em 0.75em 0.75em;
	text-align: center;
}
#map{ position: static; }
table {
	text-align: center;
}

.th-1 {
	width: 40px;
}

.th-2 {
	width: 80px;
}

.th-3 {
	width: 150px;
}

.th-4 {
	width: 90px;
}

.th-5 {
	width: 60px;
}

.th-6 {
	width: 40px;
}



</style>

<noscript>
	<link rel="stylesheet"
		href="${pageContext.request.contextPath }/resources/assets/css/noscript.css" />
</noscript>




</head>
<body class="is-preload landing">
	<%@ include file="../headerFooter/header.jsp"%>





	<!-- Banner -->
	<div class="col-sm-8">
		<img src="">
	</div>
	<div style="padding-top: 70px; padding-left: 10%">
		<div class="col-sm-2">
			<select name="chart" id="chart" style="float: left;"
				onchange="change(this)">
				<option value="fst" selected>캠핑장</option>
				<option value="snd">캠핑톡</option>
			</select>
		</div>
		<div id="selectfst" class="col-sm-2"
			style="float: left; ">
			<select name="list" id="list" onchange="window.open(value,'_self');">
				<option value="/camp/campsite.do">일반야영장</option>
				<option value="/camp/carCampground.do">자동차야영장</option>
				<option value="/camp/caravan.do">카라반</option>
				<option value="/camp/glamping.do" selected>글램핑</option>
			</select>
		</div>
		<div id="selectsnd" class="col-sm-2" style="float: left; display: none;">
			<select name="list" id="list" onchange="window.open(value,'_self');">
				<option value="../board/review.do" selected>캠핑후기</option>
				<option value="../board/notice.do">공지사항</option>
				<option value="../board/QnA.do">QnA</option>
			</select>
		</div>
	</div>
	<br>
	<br>
	<div>
		<p
			style="font-size: 50px; padding-left: 12%; padding-top: 5%; font-weight: bold;">글램핑</p>
	</div>
<!-- 	<div style="padding-right: 7%; padding-bottom: 3%;">
		<div class="col-sm-1" style="float: right;">
			<input type="button" value="검색" onclick="search();">
		</div>

		<div class="col-sm-2" style="float: right;">
			<input type="text" name="searchtext" />
		</div>

		<div class="col-sm-1.8" style="float: right;">
			<select name="searchType" id="search" style="float: left;">
				<option value="all" selected>전체</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select> <br>
		</div>
	</div> -->
		<div id="map" style="width: 100%; height: 800px; margin-left: 10px;"></div>
		<br>


	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=eae203b516d5693eb4a9560f2bb8505b"></script>

	<script>
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			level : 6
		//지도의 레벨(확대, 축소 정도)
		};

		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

		if (navigator.geolocation) {

			// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			navigator.geolocation
					.getCurrentPosition(function(position) {

						var lat = position.coords.latitude, // 위도
						lon = position.coords.longitude; // 경도

						var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
						message = '<div style="padding:5px; color:white; width:250px; background-color:blue;">현재위치</div>';

						// 마커와 인포윈도우를 표시합니다
						displayMarker(locPosition, message);

					});

		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

			var locPosition = new kakao.maps.LatLng(33.450701, 126.570667), message = 'geolocation을 사용할수 없어요..'

			displayMarker(locPosition, message);
		}

		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
		var mappingData = {};
		var positions = new Array();
		var overlaies = new Array();
		function test() {
			$.ajax({
				type : "post",
				url : "/camp/selectGlamping.do",
				dataType : "json",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("X-CSRF-TOKEN", csrf_token);
				},
				success : function(data) {
					var list = data;
					for (var i = 0; i < list.length; i++) {
						var spotObj = {
							title : list[i].idx,
							name : list[i].facltNm,
							latlng : new kakao.maps.LatLng(list[i].mapY,
									list[i].mapX),
							kndNm : list[i].induty
						};
						var overlay = {
							title : list[i].idx
						}
						positions.push(spotObj);
						overlaies.push(overlay);
					}

					for (var a = 0; a < positions.length; a++) {
						// 마커 이미지의 이미지 크기 입니다
						var imageSize = new kakao.maps.Size(30, 30);

						// 마커 이미지를 생성합니다   
						if (positions[a].kndNm === '글램핑') {
							var markerImage = new kakao.maps.MarkerImage(
									imageSrc, imageSize);
						}

						var marker = new kakao.maps.Marker({
							map : map, // 마커를 표시할 지도
							position : positions[a].latlng, // 마커를 표시할 위치
							title : positions[a].name, // 마커의 타이틀(마우스를 올리면 타이틀 표기)
							image : markerImage
						// 마커 이미지 
						});
						marker.setMap(map); // 마커 표기

						// 이것이 중요 
						// 마커의 정보와 데이터를 담아둔 맵핑데이터 
						mappingData[list[a].idx] = {
							data : list[a],
							marker : marker
						};

						// 마커를 클릭 시 커스텀 오버레이 생성
						kakao.maps.event.addListener(marker, 'click', test2(map, marker));

					}
				},
				error : function() {
					alert('에러가 발생하였습니다. 관리자에게 문의하세요.');
				}
			});
		}

		function test2(map, marker) {
			return function() {
				   var code = marker.getTitle();
				map.setCenter(marker.getPosition());
				var iwContent = 
				'<div style="padding:5px; color:black; width:1000px; height:400px; font-size: 20px;">' +
				'<form action="/camp/detailPage.do" method="post" target="_blank" onsubmit=window.open("/camp/detailPage.do", "상세보기페이지", "width=1225, height=900, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );">' +
				  '<input type="hidden" name="var" value="'+code+'">' + 
				  '<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />' +
			    		'<div style="font-size:35px; padding-top :20px; font-weight: bold;">'+ mappingData[code].data.facltNm  + '</div> <br>' +
			    		'<div class="row">' +
			    		'<div class="col-md-1" style="padding-right: 1px;"><img src="' + mappingData[code].data.firstImageUrl +'"style="width:250px; height:250px;"></div>' +
			    			'<div class="col-md-8 style="width :100%;">' + 
			    			 '<div class="col-md-6" style="padding-left: 200px; width :100%; font-weight: bold; font-size:20px;">주소 : '+ mappingData[code].data.addr1 +'</div>'+
			    			 '<div class="col-md-6" style="padding-left: 200px; width :100%; font-weight: bold; font-size:20px;">유형 : '+ mappingData[code].data.induty +'</div>'+
			    			 '<div class="col-md-6" style="padding-left: 200px; width :100%; font-weight: bold; font-size:20px;">소개 : '+ mappingData[code].data.lineIntro +'</div>'+
			    		'</div>'+
			    		'<div style="text-align:center"> <input type="submit" style="background-color:blue; color:white;" value="상세페이지"> </div> </form>'+
			    		
			    '</div>'

				 // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
				 console.log(mappingData[code].data);
				iwPosition = new kakao.maps.LatLng(marker.getPosition()); //인포윈도우 표시 위치입니다
				iwRemoveable = true;
				// 인포윈도우를 생성합니다
				var infowindow = new kakao.maps.InfoWindow({
					position : iwPosition,
					content : iwContent,
					removable : iwRemoveable
				});
				infowindow.open(map, marker);

			}
		}
		
	
	
		
		function displayMarker(locPosition, message) {

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
				map : map,
				position : locPosition
			});

			var iwContent = message, // 인포윈도우에 표시할 내용
			iwRemoveable = true;

			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
				content : iwContent,
				removable : iwRemoveable
			});

			// 인포윈도우를 마커위에 표시합니다 
			infowindow.open(map, marker);

			// 지도 중심좌표를 접속위치로 변경합니다
			map.setCenter(locPosition);
		}
		$(document).ready(function() {
			test()
			alert('정보를 불러오는중입니다. 잠시 기다려주시면 마커가 표시됩니다.')
		});
	</script>


	<!-- Footer -->
	<%@ include file="../headerFooter/footer.jsp"%>

	<!-- Scripts -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/jquery.scrolly.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/jquery.dropotron.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/jquery.scrollex.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/browser.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/breakpoints.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/util.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/main.js"></script>
	<%-- 	<script
		src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script> --%>



</body>
</html>