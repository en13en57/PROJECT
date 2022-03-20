<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/assets/css/images/logo.png" />
<title>NG캠핑 로그인</title>
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
<!-- 네이버 스크립트-->
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
	
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/main.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/swiper.min.css">
<script type="text/javascript">

</script>

<style type="text/css">


element.style {
    width: 500px;
    height: 100px;
    margin: 0 auto;
}

#banner1 {
	padding:200px;
	padding-top:300px;
}


#content1 {
	text-align: left;
}

textarea {
	height: 15em;
	border: none;
	resize: none;
	background-color: white;
	color: black;
}

#member_position {
	padding-left: 27%;
}

#login {
	padding-left: 27%;
	width: 1000px;
	height: 1000px;
	
}

</style>

<noscript>
	<link rel="stylesheet"
		href="${pageContext.request.contextPath }/resources/assets/css/noscript.css" />
</noscript>




</head>
<body class="is-preload landing">
	<div id="page-wrapper">

		<!-- Header -->
		<header id="header">
			<h1 id="logo">
				<a href="/main.do"><img
					src="${pageContext.request.contextPath }/resources/assets/css/images/logo.png"
					alt="" /> </a>
			</h1>
			<nav id="nav">
				<ul>
					<li><a href="/main.do">Home</a></li>
					<li><a href="#">캠핑장</a>
						<ul>
							<li><a href="#">일반 야영장</a></li>
							<li><a href="#">자동차 야영장</a></li>
							<li><a href="#">카라반</a></li>
							<li><a href="#">글램핑</a></li>
						</ul></li>

					<li><a href="#">캠핑톡</a>
						<ul>
							<li><a href="#">공지사항</a></li>
							<li><a href="#">캠핑후기</a></li>
							<li><a href="#">QnA</a></li>
						</ul></li>
					<li><a href="/insert.do">회원가입</a></li>
					<li><a href="/login.do">로그인</a></li>
				</ul>
			</nav>
		</header>
		<!-- Banner -->
		<section id="banner1">
			<form action="${pageContext.request.contextPath}/login" method="post">
				<%-- 로그인 실패시 에러메세지 출력 --%>
				<c:if test="${not empty error }">
					<div style="color: red;">${error }</div>
				</c:if>
				<%-- 로그아웃시 메세지 출력 --%>
				<c:if test="${not empty msg }">
					<div style="color: green;">${msg }</div>
				</c:if>
				<div class="row">
					<div style="text-align: left; padding-left: 30%;">
						아이디/비번 로그인
					</div>
					<div class="col-md-8" style="padding-left: 30% ">
						<input type="text" class="form-control" id="ID" name="mb_ID"placeholder="아이디입력" required>
						<input type="password" class="form-control" id="password" name="mb_password"placeholder="비밀번호입력" required>
					</div>
					
					<!-- 시큐리트에서 사용자가 지정한 폼을 사용하려면 반드시 아래의 코드를 첨부해줘야 한다.-->
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				 
					<div class="col-md-4">
						<input type="submit" value="로그인" style="height: 95px; float: left;"/>
					</div>
					<!-- 
					<div class="col-md-4">
						<input type="button" value="로그인" style="height: 95px; float: left;" onclick="login()"/>
					</div>
					 -->
					
					<div style="font:white;  font-size: 10px; text-align:left; padding-left: 65%;">
						<a href="/findUserId.do">아이디찾기</a>
						&nbsp; | &nbsp;
						<a href="/findPassword.do">비밀번호 찾기 </a>
						&nbsp; | &nbsp;
						<a href="/insert.do">회원가입 </a>
					</div>
				</div> 
			</form>
	
			<div class="row" style="width: 300px; height: 300px; margin: 0 auto; padding-right:3;" >
				<div class="col-md-4">
					<!-- 네이버아이디로로그인 버튼 노출 영역 -->
					
			  		<%-- <a id="naverIdLogin_loginButton" href="#"><img width="50"
						src="${pageContext.request.contextPath }/resources/images/naverLogin.png"
						alt="" />
					</a> --%>
					
					<a id="" href="${ kakao_url }"><img width="50"
						src="${pageContext.request.contextPath }/resources/images/naverLogin.png"
						alt="" />
					</a>
				</div>
				<div class="col-md-4">
					<a href="${ kakao_url }"><span id="kakao"><img width="50"
						src="${pageContext.request.contextPath }/resources/images/kakaoLogin.png"
						alt="" /></span>
					</a>
				</div>
				<div class="col-md-4">
					<a href="${ google_url }"><span id="google"><img width="50"
						src="${pageContext.request.contextPath }/resources/images/googleLogin.png"
						alt="" /></span>
					</a>
				</div>
			</div>
		</section>
		

		<!-- Footer -->
		<footer id="footer">
			<ul class="icons">
				<li><a href="https://twitter.com/?lang=ko"
					class="icon brands alt fa-twitter" target="_blank"><span
						class="label">Twitter</span></a></li>
				<li><a href="https://www.facebook.com/"
					class="icon brands alt fa-facebook-f" target="_blank"><span
						class="label">Facebook</span></a></li>
				<li><a href="https://www.instagram.com/"
					class="icon brands alt fa-instagram" target="_blank"><span
						class="label">Instagram</span></a></li>
				<li><a href="mailto:Email@email.com"
					class="icon solid alt fa-envelope"><span class="label">Email</span></a></li>
			</ul>
			<ul class="copyright">
				<li>&copy; COPYRIGHT(C) 2022. Green Academy in Sungnam.</li>
				<li>Made by 김가람, 강두오, 서해성</li>
			</ul>
		</footer>
	</div>


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
<script>
<!-- 네이버 로그인API  -->

var naverLogin = new naver.LoginWithNaverId(
			{
				clientId: "eT2NCIHgedo2uVebssZm", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
				callbackUrl: "http://localhost:8080/oauth2/naver/callback.do", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
				isPopup: false,
				callbackHandle: true
			}
		);	
	
	naverLogin.init();
	
	window.addEventListener('load', function () {
		naverLogin.getLoginStatus(function (status) {
			if (status) {
				var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
	    		
				console.log(naverLogin.user); 
	    		
	            if( email == undefined || email == null) {
					alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
					naverLogin.reprompt();
					return;
				}
			} else {
				console.log("callback 처리에 실패하였습니다.");
			}
		});
	});
</script>		

</body>
</html>