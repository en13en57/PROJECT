<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<meta charset="utf-8" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/main.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/swiper.min.css">
<script type="text/javascript">
	function logoutSubmit() {
		var logout = document.logout;
		logout.submit();
	}
</script>

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
					src="${pageContext.request.contextPath }/resources/assets/css/images/logo.png" style="height: 60px; width: 80px;"
					alt="" /> </a>
			</h1>
			<c:set value="${sessionScope.mvo.gr_role}" var="role" />
			<c:set value="${sessionScope.mvo.mb_nick}" var="nick" />
			<c:set value="${sessionScope.mvo.del}" var="del" />
			<nav id="nav">
				<ul>
					<c:if test="${sessionScope.mvo eq null }">
						<li><a href="/main.do">Home</a></li>
						<li><a href="#">캠핑장</a>
							<ul>
								<li><a href="../camp/campsite.do">일반 야영장</a></li>
								<li><a href="../camp/carCampground.do">자동차 야영장</a></li>
								<li><a href="../camp/caravan.do">카라반</a></li>
								<li><a href="../camp/glamping.do">글램핑</a></li>
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
					<c:if test="${sessionScope.mvo ne null }">
						<c:choose>
							<c:when test="${role eq 'ROLE_USER'}">
								<li>"${nick }" 님 환영합니다.</li>
								<li><a href="/main.do">Home</a></li>
								<li><a href="#">캠핑장</a>
									<ul>
										<li><a href="../camp/campsite.do">일반 야영장</a></li>
										<li><a href="../camp/carCampground.do">자동차 야영장</a></li>
										<li><a href="../camp/caravan.do">카라반</a></li>
										<li><a href="../camp/glamping.do">글램핑</a></li>
									</ul></li>
								<li><a href="#">캠핑톡</a>
									<ul>
										<li><a href="../board/notice.do">공지사항</a></li>
										<li><a href="../board/review.do">캠핑후기</a></li>
										<li><a href="../board/QnA.do">QnA</a></li>
									</ul></li>

								<c:url value="/logout" var="logoutURL" />
								<li>
									<form action="${logoutURL }" method="post" name="logout">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }"> <a href="#"
											onclick="logoutSubmit()">로그아웃</a>
									</form>
								</li>
								<li style="vertical-align: top;">
									<form
										action='${pageContext.request.contextPath } /memberInfo/memberPage.do'
										method="POST" id="rView">
										<sec:csrfInput />
										<a href="#"
											onclick="document.getElementById('rView').submit()">마이페이지</a>
									</form>
								</li>
							</c:when>
							<c:when test="${role eq 'ROLE_USER'}">
								<li>"${nick}" 님 환영합니다.</li>
								<li><a href="/main.do">Home</a></li>
								<li><a href="#">캠핑장</a>
									<ul>
										<li><a href="../camp/campsite.do">일반 야영장</a></li>
										<li><a href="../camp/carCampground.do">자동차 야영장</a></li>
										<li><a href="../camp/caravan.do">카라반</a></li>
										<li><a href="../camp/glamping.do">글램핑</a></li>
									</ul></li>
								<li><a href="#">캠핑톡</a>
									<ul>
										<li><a href="../board/notice.do">공지사항</a></li>
										<li><a href="../board/review.do">캠핑후기</a></li>
										<li><a href="../board/QnA.do">QnA</a></li>
									</ul></li>
								<c:url value="/logout" var="logoutURL" />
								<li>
									<form action="${logoutURL }" method="post" name="logout">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }"> <a href="#"
											onclick="logoutSubmit()">로그아웃</a>
									</form>
								</li>
								<li style="vertical-align: top;">
									<form
										action='${pageContext.request.contextPath }/UserInfo/memberpageCorrect.do'
										method="POST" id="rView">
										<sec:csrfInput />


										<a href="#"
											onclick="document.getElementById('rView').submit()">마이페이지</a>
									</form>
								</li>
							</c:when>

							<c:when test="${role eq 'ROLE_ADMIN' }">
								<li>"${nick}" 님 환영합니다.</li>
								<li><a href="/main.do">Home</a></li>
								<li><a href="#">캠핑장</a>
									<ul>
									<li><a href="../camp/campsite.do">일반 야영장</a></li>
										<li><a href="../camp/carCampground.do">자동차 야영장</a></li>
										<li><a href="../camp/caravan.do">카라반</a></li>
										<li><a href="../camp/glamping.do">글램핑</a></li>
									</ul></li>
								<li><a href="#">캠핑톡</a>
									<ul>
										<li><a href="../board/notice.do">공지사항</a></li>
										<li><a href="../board/review.do">캠핑후기</a></li>
										<li><a href="../board/QnA.do">QnA</a></li>
									</ul></li>
								<c:url value="/logout" var="logoutURL" />
								<li>
									<form action="${logoutURL }" method="post" name="logout">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }"> <a href="#"
											onclick="logoutSubmit()">로그아웃</a>
									</form>
								</li>
								<li><a href="#">관리자페이지</a>
									<ul>
										<li><a href="../admin/memberManage.do">회원관리</a></li>
									</ul></li>
							</c:when>
							<c:otherwise>
								<li>"${nick}"님 메일인증을 해주시길바랍니다.</li>
								<li><a href="/main.do">Home</a></li>
								<li><a href="#">캠핑장</a>
									<ul>
											<li><a href="../camp/campsite.do">일반 야영장</a></li>
										<li><a href="../camp/carCampground.do">자동차 야영장</a></li>
										<li><a href="../camp/caravan.do">카라반</a></li>
										<li><a href="../camp/glamping.do">글램핑</a></li>
									</ul></li>
								<li><a href="#">캠핑톡</a>
									<ul>
										<li><a href="../board/notice.do">공지사항</a></li>
										<li><a href="../board/review.do">캠핑후기</a></li>
										<li><a href="../board/QnA.do">QnA</a></li>
									</ul></li>
								<c:url value="/logout" var="logoutURL" />
								<li>
									<form action="${logoutURL }" method="post" name="logout">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }"> <a href="#"
											onclick="logoutSubmit()">로그아웃</a>
									</form>
								</li>
								<li style="vertical-align: top;">
									<form
										action='${pageContext.request.contextPath }/UserInfo/memberpageCorrect.do'
										method="POST" id="rView">
										<sec:csrfInput />


										<a href="#"
											onclick="document.getElementById('rView').submit()">마이페이지</a>
									</form>
								</li>

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