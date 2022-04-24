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
<script type="text/javascript">
	function ajaxToSend() {
		// 비밀번호 변경시 사용할 ajax
		$.ajax({
			type : "GET",
			url : "passwordCorrectOk.do", // 컨트롤러에서 대기중인 url
			data : $('#memberVOForm').serialize(), // 해당 폼의 정보들
			dataType : "text",
			success : function(result) {
				console.log(result)
				if (result == 1) { // 리턴값이 1일 때
					alert('비밀번호 변경에 성공했습니다. 다시 로그인해주세요.');
					location.href = '/main.do';
				} else if (result == 0) { // 리턴값이 0일 때 
					alert('오류가 발생했습니다. 다시 비밀번호를 수정해주세요.');
					$("#password").val = '';
					$("#passwordCheck").val = '';
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // java에서 에러가 나는 경우 탐.
				alert("오류발생")
			}
		});
	}
	
	$(function() {
		$("#passwordCheck").keyup(function() { // 두번째 비밀번호 입력칸 입력 시
			var pw = $('#password').val();
			var pw2 = $('#passwordCheck').val();
			if (pw != '' || pw2 != '') {	// 미입력인지 체크
				if (pw == pw2) {	// 같다면
					$('#pwcheckval').html('일치').css('color', 'white');
				} else {
					$('#pwcheckval').html('미일치').css('color', 'yellow');
				}
			}
		});

		$("#passwordCheck").focus(function() {	// 두번째 비밀번호 입력칸 이동시
			if ($("#password").val() == '') {	// 첫번째 비밀번호 입력칸이 비었을 때 
				alert('비밀번호 입력칸을 먼저 입력해주세요.');
				$("#password").focus();			// 첫번째 비밀번호 입력칸으로 이동
			}
		});
	});
	
	// 로그아웃
	function logoutSubmit() {
		var logout = document.logout;
		logout.submit();
	}
	// 비밀번호 글자 제한
	function formCheck() {
		var regPass = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,15}$/;
		var value = $("#password").val();
		if (!regPass.test(value)) {
			alert('영문, 숫자, 특수기호 조합으로 8-15자리로 입력해주세요.');
			$("#password").focus();
			return false;
		}
	}
</script>

<style>
#banner1 {
	padding: 100px 0;
	top: 20px;
}

#content1 {
	text-align: left;
}

#member_position {
	padding-left: 25%;
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
		<div id="content1">
			<div id="member_position">
				<div class="mb-4">
					<form action="memberInfo/passwordCorrectOk.do" method="post"
						name="memberVOForm" id="memberVOForm">
						<input type="hidden" name="mb_ID" value="${mvo.mb_ID }">
						<sec:csrfInput />
						<div style="width: 50%;">
							<div class="title">비밀번호 수정</div>
							<br>
							<div class="mb-4 row">
								<label for="password" class="col-sm-3 col-form-label">비밀번호</label>
								<div class="col-sm-6">
									<input type="password" class="form-control" id="password"
										name="newPassword" placeholder="영어,숫자,특수문자 8~15글자" required
										maxlength="15">
								</div>
								<div class="col-sm-3 col-form-label" id="pwcheckval"></div>
							</div>

							<div class="mb-4 row">
								<label for="password" class="col-sm-3 col-form-label"
									id="pwcheck">비밀번호확인 </label>
								<div class="col-sm-6">
									<input type="password" class="form-control" id="passwordCheck"
										placeholder="비밀번호확인" required maxlength="15">
								</div>
							</div>
							<div style="text-align: right;">
								<input type="button" value="수정하기" onclick="ajaxToSend();">
							</div>
						</div>
					</form>
				</div>
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