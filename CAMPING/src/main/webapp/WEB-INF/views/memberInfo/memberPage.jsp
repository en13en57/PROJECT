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
	// 닉네임 수정시 사용할 ajax
	function ajaxToSend() {
		$.ajax({
			type : "GET",
			url : "memberPageOk.do", // 컨트롤러에서 대기중인 url
			data : $('#memberVOForm').serialize(), // 해당 폼의 정보들
			dataType : "text",
			success : function(result) {
				console.log(result)
				// 컨트롤러의 리턴값이 1이면
				if (result == 1) {
					alert('넥네임이 수정되었습니다.. 다시 로그인해주세요.');
					location.href = '/main.do';
					// 리턴값이 0이면
				} else if (result == 0) {
					alert('오류가 발생했습니다. 닉네임을 다시 수정해주세요.');
					$("#nick").val = '';
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // java에서 에러가 나는 경우 탐.
				alert("오류발생")
			}
		});
	}

	// 로그아웃시
	function logoutSubmit() {
		var logout = document.logout;
		logout.submit();
	}

	// 닉네임 체크
	function FnNickcheck() {
		// 사용 문자 제한 한글, 영 소문자, 숫자만 2자부터 10자까지 $는 문자열의 끝
		var check = /^[가-힣a-zA-Z0-9]{2,10}$/;
		var value = $('#nick').val();
		if (value != null && check.test(value)) {
			$.ajax({
				type : "GET",
				url : "/nickCheck.do", // 컨트롤러에서 대기중인 URL 
				data : {
					"nick" : value
				// 닉네임을 보내서
				},
				dataType : "text",
				success : function(count1) {
					// 보니깐 count로 할거같던데
					if (count1 == 0) { // 있으면
						alert("닉네임 사용가능");
						idCheckYn = true; // 아이디 중복처리를 했다는걸 여기서 true값을 줌.
					} else if (count1 > 0) { // 0 이면 없음
						alert("닉네임 중복 또는 공백문제입니다.");
						idCheckYn = false; // 중복된걸 통과시킬순없음 X

					} else { // 이건 오류 (밑에도 타겠지만 값이 안넘오는 경우에 여기서 걸릴거임.)
						alert("기타 오류입니다.");
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					alert("가입 실패")
				}
			});
		} else {
			alert("닉네임은 2글자이상 10자 이하만 입력되며 공백 및 특수문자가 불가능합니다.");
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

	<section id="banner1">
		<div id="content1">
			<div id="member_position">
				<div class="mb-4">
					<form action="/memberInfo/memberPageOk.do" method="get"
						name="memberVOForm" id="memberVOForm">
						<input type="hidden" name="mb_ID" value="${mvo.mb_ID}">
						<div style="width: 70%;">
							<div class="title" style="font-size: 25px;">회원정보</div>
							<br>
							<table class="table table-dark"
								style="color: white; border: 1px solid white; border-radius: 10px;">
								<tr>
									<th colspan="3"
										style="color: white; background-color: black; text-align: left;">${mvo.mb_name }님의
										정보입니다.</th>
								</tr>
								<tr>
									<td class="td-1" style="">아이디</td>
									<td class="td-2" colspan="2" style="text-align: left;">${mvo.mb_ID }</td>
								</tr>
								<tr>
									<td class="td-1">이름</td>
									<td class="td-2" colspan="2" style="text-align: left;">${mvo.mb_name }</td>
								</tr>

								<tr>
									<td class="td-1">닉네임</td>
									<td class="td-2"><input type="text" class="form-control"
										id="nick" name="mb_nick" style="width: 250px;" required
										maxlength="10" value="${mvo.mb_nick }"
										style="text-align: left;"></td>
									<td class="td-2" style="text-align: center;"><input
										type="button" id="nickcheck" value="중복확인"
										onclick="FnNickcheck();" /></td>
								</tr>

								<tr>
									<td class="td-1">이메일</td>
									<td class="td-2" colspan="2" style="text-align: left;">${mvo.mb_email }</td>
								</tr>

								<tr>
									<td class="td-1" style="vertical-align: middle;">주소</td>
									<td class="td-3" colspan="2" style="text-align: left;">${mvo.mb_zipcode }
										${mvo.mb_address1 }${mvo.mb_address2 }</td>
								</tr>
							</table>
							<div style="float: right;">

								<input type="button" id="pwdcorrect" value="비밀번호변경"
									class="btn btn-primary"
									onclick="location.href='/memberInfo/passwordCorrect.do'"
									style="color: white;"> <input type="button"
									id="memcorrect" value="수정하기" class="btn btn-success"
									onclick="ajaxToSend();"> <input type="button"
									id="memdelete" value="탈퇴하기" class="btn btn-danger"
									onclick="location.href='/memberInfo/memberDelete.do'"
									style="color: white;">
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