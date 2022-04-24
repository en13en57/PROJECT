<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- JSTL 사용 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<style type="text/css">
#banner1 {
	padding: 200px;
	padding-top: 300px;
}
</style>

<%-- 페이지의 스크립트 유형을 지원하지 않거나, 브라우저가 스크립트를 비활성화한 경우 보여줄 HTML 구획을 정의 --%>
<noscript>
	<link rel="stylesheet"
		href="${pageContext.request.contextPath }/resources/assets/css/noscript.css" />
</noscript>
</head>

<body class="is-preload landing">

		<!-- header -->
		<%@ include file="../headerFooter/header.jsp"%>

		<!-- Banner -->
		<section id="banner1">
			<div class="row">
				<div class="col-md-8" style="padding-left: 30%;">
					<!-- 회원이 비밀번호 찾기를 이용 할 경우 아래의 코드가 실행된다. -->
					<c:if test="${mode eq 1}">
						<form action="${pageContext.request.contextPath}/login.do"
							method="post">
							<br />
							<div style="text-align: center;">
								임시번호가 이메일로 전송되었습니다.<br> 확인 후 로그인해주세요.
							</div>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />

							<div class="col-md-4" style="padding-left: 100px;">
								<input type="submit" value="로그인 가기" style="height: 95px;" />
							</div>
						</form>
					</c:if>
					<!-- 관리자가 임시비밀번호 발급시에는 아래의 코드들이 실행됨. -->
					<c:if test="${mode ne 1}">
						<div style="text-align: center;">
							선택하신 회원의 임시비밀번호를 <br>설정하여 메일로 전송했습니다.<br>
						</div>
						<div class="col-md-4" style="padding-left: 28%;">
							<a href="/admin/memberManage.do"><input type="button"
								value="돌아가기" style="height: 95px;" /></a>
						</div>
					</c:if>
				</div>
			</div>
		</section>

	<!-- Footer -->
	<%@ include file="../headerFooter/footer.jsp"%>

	<!-- Scripts -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/jquery.min.js"></script>
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
</body>
</html>