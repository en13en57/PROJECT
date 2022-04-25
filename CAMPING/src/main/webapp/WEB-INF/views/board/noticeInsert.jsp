<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- JSTL 사용 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/assets/css/images/logo.png" />
<title>NG캠핑</title>
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<%-- 부트스트랩 SDK 끝 --%>
<%-- jQuery SDK --%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<%-- summernote --%>
<script
	src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
<%-- css --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/main.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/swiper.min.css">

<script type="text/javascript">
	// 로그아웃 클릭시
	function logoutSubmit() {
		var logout = document.logout;
		logout.submit();
	}
	// 버튼 클릭시 이동할 폼액션
	function send() {
		document.getElementById("camp").submit();
	}

	// 폼의 값 유효성 검사하기 스크립트
	function formCheck() {
		var value = $("#title").val();
		if (!value || value.trim().length == 0) {
			alert('제목을 반드시 입력해야 합니다.');
			$("#title").val("");
			$("#title").focus();
			return false;
		}

		var value = $("#content").summernote('code');
		if (!value || value.trim() == "<p><br></p>") {
			alert('내용은 반드시 입력해야 합니다.');
			$("#content").val("");
			$("#content").focus();
			return false;
		}
		return true;
	}
	
	// 네비게이션 첫번째 변경시 두번째 옵션 변경
	function change(val) {
		if (val.value == 'fst') {
			document.getElementById("selectfst").style.display = 'inline';
			document.getElementById("selectsnd").style.display = 'none';
		} else if (val.value == 'snd') {
			document.getElementById("selectfst").style.display = 'none';
			document.getElementById("selectsnd").style.display = 'inline';
		}
	}
</script>

<style type="text/css">
.note-editor.note-frame .note-editing-area .note-editable, .note-editor.note-airframe .note-editing-area .note-editable
	{
	padding: 10px;
	background: white;
	overflow: auto;
	word-wrap: break-word;
}

b {
	font-weight: bold;
}
</style>

</head>
<body class="is-preload landing">
	<div id="page-wrapper">
		<!-- 인클루드시 서머노트가 망가져서 헤더 강제 사용 -->
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
								<li><a style="cursor: pointer;" onclick="send();">캠핑장
										찾기</a></li>
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

		<!-- Banner -->
		<!-- 네비게이션 -->
		<div class="col-sm-8">
			<img src="">
		</div>
		<div style="padding-top: 70px; padding-left: 10%">
			<div class="col-sm-2">
				<select name="chart" id="chart" style="float: left;"
					onchange="change(this)">
					<option value="fst">캠핑장</option>
					<option value="snd" selected>캠핑톡</option>
				</select>
			</div>
			<div id="selectfst" class="col-sm-2"
				style="float: left; display: none;">
				<select name="list" id="list" onchange="window.open(value,'_self');">
					<option selected disabled>-선택-</option>
					<option value="../camp/campsite.do">캠핑장 찾기</option>
				</select>
			</div>
			<div id="selectsnd" class="col-sm-2" style="float: left;">
				<select name="list" id="list" onchange="window.open(value,'_self');">
					<option selected disabled>-선택-</option>
					<option value="/board/review.do">캠핑후기</option>
					<option value="/board/notice.do">공지사항</option>
					<option value="/board/QnA.do">QnA</option>
				</select>
			</div>
		</div>
		<br> <br>
		<div>
			<p
				style="font-size: 50px; padding-left: 12%; padding-top: 5%; font-weight: bold;">공지사항</p>
		</div>
		<br>
		<section
			style="padding-right: 10%; padding-left: 10%; margin: 0 auto;">
			<form enctype="multipart/form-data" method="post"
				onsubmit="return formCheck();">
				<sec:csrfInput />
				<input type="hidden" name="mb_idx"
					value="${sessionScope.mvo.mb_idx }" /> <input type="hidden"
					name="mb_nick" value="${sessionScope.mvo.mb_nick }" />
				<div class="row">
					<div class="col-sm-7">
						<label for="ID" style="font-size: 20px; font-weight: bold;">제목</label>
						<input type="text" id="title" name="nt_title"
							style="background-color: white; color: black;"> <br>
					</div>
				</div>
				<textarea id="content" name="nt_content" class="summernote"></textarea>
				<div>첨부파일</div>
				<div>
					<span style="color: red; font-size: 9pt;">※ 이미지는 내용에 직접
						첨부하세요!!!</span>
					<div id="fileBox">
						<div id="fileItem" class="fileItem">
							<input type="file" name="uploadFile" multiple="multiple" />
						</div>
					</div>
					<br />
				</div>
				<c:if test="${role eq 'ROLE_ADMIN' }">
					<div style="padding-top: 1%; float: right;">
						<input value="목록" class="btn btn-dark btn-sm" type="button"
							style="margin-right: 2px;"
							onclick="location.href='/board/notice.do'"> <input
							type="submit" value="전송" class="btn btn-primary btn-sm"
							formaction="/board/noticeInsertOk.do">
					</div>
				</c:if>
			</form>
		</section>
		<br />
		
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

	<!-- 서머노트 -->
	<script>
		$(function() {
			$('.summernote')
					.summernote(
							{
								// 에디터 높이
								height : 150,
								// 에디터 한글 설정
								lang : "ko-KR",
								placeholder : "입력하여 주세요",
								disableDragAndDrop : true,
								// 에디터에 커서 이동 (input창의 autofocus라고 생각하시면 됩니다.)
								focus : true,
								toolbar : [
										// 글꼴 설정
										[ 'fontname', [ 'fontname' ] ],
										// 글자 크기 설정
										[ 'fontsize', [ 'fontsize' ] ],
										// 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
										[
												'style',
												[ 'bold', 'italic',
														'underline',
														'strikethrough',
														'clear' ] ],
										// 글자색
										[ 'color', [ 'forecolor', 'color' ] ],
										// 표만들기
										[ 'table', [ 'table' ] ],
										// 글머리 기호, 번호매기기, 문단정렬
										[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
										// 줄간격
										[ 'height', [ 'height' ] ],
										// 그림첨부, 링크만들기, 동영상첨부
										[ 'insert',
												[ 'picture', 'link', 'video' ] ],
										// 코드보기, 확대해서보기, 도움말
										[
												'view',
												[ 'codeview', 'fullscreen',
														'help' ] ] ],
								// 추가한 글꼴
								fontNames : [ 'Arial', 'Arial Black',
										'Comic Sans MS', 'Courier New',
										'맑은 고딕', '궁서', '굴림체', '굴림', '돋음체',
										'바탕체' ],
								// 추가한 폰트사이즈
								fontSizes : [ '8', '9', '10', '11', '12', '14',
										'16', '18', '20', '22', '24', '28',
										'30', '36', '50', '72' ],
								callbacks : {
									onImageUpload : function(files, editor,
											welEditable) {
										for (var i = files.length - 1; i >= 0; i--) {
											sendFile(files[i], this);
										}
									}
								}
							});
		});
		
		function sendFile(file, el) {
			var form_data = new FormData();
			var csrf_token = "${_csrf.token}";
			form_data.append('file', file);
			$.ajax({
				data : form_data,
				type : "POST",
				url : '/imageUpload.do',
				cache : false,
				contentType : false,
				enctype : 'multipart/form-data',
				processData : false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader("X-CSRF-TOKEN", csrf_token);
				},
				success : function(img_name) {
					$(el).summernote('editor.insertImage', img_name);
				},
				error : function(request, status, error) {
					alert('에러!!!');
					console.log("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			});
		}
	</script>
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
</body>
</html>
