<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- JSTL 사용 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/assets/css/images/logo.png" />
<title>캠핑은 NG캠핑!</title>
<%-- 반응형 디자인 --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%-- 부트스트랩 SDK 시작 --%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<%-- 부트스트랩 SDK 끝 --%>
<%-- jQuery SDK --%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<%-- css --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/main.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/swiper.min.css">
<%-- 카카오 맵 API를 사용하기 위한 SDK --%>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=eae203b516d5693eb4a9560f2bb8505b"></script>

<script type="text/javascript">
	// 로그아웃 클릭시
	function logoutSubmit() {
		var logout = document.logout;
		logout.submit();
	}
	// 카카오맵 api geolocation 허용 하면, 
	if (navigator.geolocation) {
		// GeoLocation을 이용해서 
		navigator.geolocation.getCurrentPosition(function(position) {
			// 접속 위치를 가져온다
			var lat = position.coords.latitude; // 위도 mapy
			var lon = position.coords.longitude; // 경도 mapx
			// 해당 id 태그에 값 담기
			document.getElementById("lon").value = lon;
			document.getElementById("lat").value = lat;
		});
		// geolocation 허용하지 않으면,
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		// 기본 위치값
		var lat = 33.450701; // 위도 mapy
		var lon = 126.570667; // 경도 mapx
		// 해당 id 태그에 값 담기
		document.getElementById("lon").value = lon;
		document.getElementById("lat").value = lat;
	}

	function send() {
		document.getElementById("camp").submit();
	}
</script>
<%-- 페이지의 스크립트 유형을 지원하지 않거나, 브라우저가 스크립트를 비활성화한 경우 보여줄 HTML 구획을 정의 --%>
<noscript>
	<link rel="stylesheet"
		href="${pageContext.request.contextPath }/resources/assets/css/noscript.css" />
</noscript>
</head>

<body class="is-preload landing">
	<!-- Header -->
	<header id="header">
		<h1 id="logo">
			<a href="/main.do"><img
				src="${pageContext.request.contextPath }/resources/assets/css/images/logo.png"
				style="height: 60px; width: 80px;" alt="" /> </a>
		</h1>
		<form
			action='${pageContext.request.contextPath } /memberInfo/memberPage.do'
			method="POST" id="rView">
			<sec:csrfInput />
		</form>
		<!-- 로그아웃 폼 -->
		<c:url value="/logout" var="logoutURL" />
		<form action="${logoutURL }" method="post" name="logout">
			<input type="hidden" name="${_csrf.parameterName }"
				value="${_csrf.token }">
		</form>
		<!-- 권한 변수 설정 -->
		<c:set value="${sessionScope.mvo.gr_role}" var="role" />
		<c:set value="${sessionScope.mvo.mb_nick}" var="nick" />
		<!-- 탈퇴한 회원인지 판단 -->
		<c:set value="${sessionScope.mvo.del}" var="del" />
		<!-- 위도 경도 전송 폼 -->
		<form id="camp" action="/camp/campsite.do">
			<input type="hidden" id="lat" name="lat"> <input
				type="hidden" id="lon" name="lon">
		</form>
		<nav id="nav">
			<ul>
				<!-- 로그인이 되지 않았을 때 -->
				<c:if test="${sessionScope.mvo eq null }">
					<li><a href="/main.do">Home</a></li>
					<li><a href="#">캠핑장</a>
						<ul>
							<li><a style="cursor: pointer;" onclick="send();">캠핑장 찾기</a></li>
						</ul></li>
					<li><a href="#">캠핑톡</a>
						<ul>
							<li><a href="../board/notice.do">공지사항</a></li>
							<li><a href="../board/review.do">캠핑후기</a></li>
							<li><a href="../board/QnA.do">QnA</a></li>
						</ul></li>
					<li><a href="/insert.do">회원가입</a></li>
					<li><a href="/login.do">로그인</a></li>
				</c:if>
				<!-- 로그인이 되었을 때 -->
				<c:if test="${sessionScope.mvo ne null }">
					<!-- 이메일 인증한 회원이 접속했을 때 -->
					<c:choose>
						<c:when test="${role eq 'ROLE_USER'}">
							<li>"${nick }" 님 환영합니다.</li>
							<li><a href="/main.do">Home</a></li>
							<li><a href="#">캠핑장</a>
								<ul>
									<li><a style="cursor: pointer;" onclick="send();">캠핑장
											찾기</a></li>
								</ul></li>
							<li><a href="#">캠핑톡</a>
								<ul>
									<li><a href="../board/notice.do">공지사항</a></li>
									<li><a href="../board/review.do">캠핑후기</a></li>
									<li><a href="../board/QnA.do">QnA</a></li>
								</ul></li>
							<li><a href="#" onclick="logoutSubmit()">로그아웃</a></li>
							<li style="vertical-align: top;"><a href="#"
								onclick="document.getElementById('rView').submit()">마이페이지</a></li>
						</c:when>
						<c:when test="${role eq 'ROLE_ADMIN' }">
							<!-- 관리자로 로그인 하였을 때 -->
							<li>"${nick}" 관리자님 환영합니다.</li>
							<li><a href="/main.do">Home</a></li>
							<li><a href="#">캠핑장</a>
								<ul>
									<li><a style="cursor: pointer;" onclick="send();">캠핑장
											찾기</a></li>
								</ul></li>
							<li><a href="#">캠핑톡</a>
								<ul>
									<li><a href="../board/notice.do">공지사항</a></li>
									<li><a href="../board/review.do">캠핑후기</a></li>
									<li><a href="../board/QnA.do">QnA</a></li>
								</ul></li>

							<li><a href="#" onclick="logoutSubmit()">로그아웃</a></li>
							<li>
								<form
									action='${pageContext.request.contextPath }/admin/memberManage.do'
									method="POST" id="memberManage">
									<sec:csrfInput />
									<a href="#"
										onclick="document.getElementById('memberManage').submit()">회원관리</a>
								</form>
							</li>
						</c:when>
						<c:otherwise>
							<!-- 메일 인증하지 않은 회원이 로그인 하였을 때 -->
							<li>"${nick}"님 메일인증을 해주시길바랍니다.</li>
							<li><a href="/main.do">Home</a></li>
							<li><a href="#">캠핑장</a>
								<ul>
									<li><a style="cursor: pointer;" onclick="send();">캠핑장
											찾기</a></li>
								</ul></li>
							<li><a href="#">캠핑톡</a>
								<ul>
									<li><a href="../board/notice.do">공지사항</a></li>
									<li><a href="../board/review.do">캠핑후기</a></li>
									<li><a href="../board/QnA.do">QnA</a></li>
								</ul></li>
							<li><a href="#" onclick="logoutSubmit()">로그아웃</a></li>
							<li style="vertical-align: top;"><a href="#"
								onclick="document.getElementById('rView').submit()">마이페이지</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		</nav>
	</header>

	<!-- Scripts -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/browser.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/breakpoints.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/util.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/main.js"></script>
</body>
</html>