<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- JSTL 사용 --%>
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
<%-- axicon --%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/axicon/axicon.min.css" />
<%-- css --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/main.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/swiper.min.css">

<script type="text/javascript">

// 폼의 값 유효성 검사하기 스크립트
	function formCheck() {
		var value = $("#replyContent").val();
		if (!value || value.trim().length == 0) {
			alert('답변을 반드시 입력해야 합니다.');
			$("#replyContent").val("");
			$("#replyContent").focus();
			return false;
		}
	}
	
	// 답변 기입시 현재 글로 돌아오기위한 ajax 
	function sendInsertParam() {
		$.ajax({
			type : "POST", /
			url : "answerInsertOk.do", // 컨트롤러에서 대기중인 URL 주소
			data : $('#answerInsert').serialize(),
			dataType : "text",

			success : function(idx) { // 비동기통신의 성공일경우 success콜백
				var jsonStr = JSON.parse(idx);
				console.log(jsonStr);
				document.sendData.p.value = jsonStr.p;
				document.sendData.s.value = jsonStr.s;
				document.sendData.b.value = jsonStr.b;
				document.sendData.qna_idx.value = jsonStr.qna_idx;
				document.sendData.submit();
			},
			error : function(XMLHttpRequest, textStatus, errorThㅋrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
			}
		});
	}

	// 수정시 현재 글로 돌아오기위한 ajax 
	function sendUpdateParam() {
		var csrf_token = "${_csrf.token}";
		$.ajax({
			type : "POST",
			url : "answerUpdateOk.do", // 컨트롤러에서 대기중인 URL 주소
			data : $('#answerUpdate2').serialize(),
			dataType : "text",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("X-CSRF-TOKEN", csrf_token);
			},
			success : function(idx) { // 비동기통신의 성공일경우 success콜백
				var jsonStr = JSON.parse(idx);
				console.log(jsonStr);
				document.sendData.p.value = jsonStr.p;
				document.sendData.s.value = jsonStr.s;
				document.sendData.b.value = jsonStr.b;
				document.sendData.qna_idx.value = jsonStr.qna_idx;
				document.sendData.submit();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백
			}
		});
	}

	// 버튼 클릭시 textarea 등장
	function update() {
		var move = document.getElementById("answerUpdate");
		if (move.style.display == 'none') {
			move.style.display = 'inline';
		} else {
			move.style.display = 'none';
		}
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
element.style {
	width: 500px;
	height: 100px;
	margin: 0 auto;
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
</style>

<noscript>
	<link rel="stylesheet"
		href="${pageContext.request.contextPath }/resources/assets/css/noscript.css" />
</noscript>
</head>

<body class="is-preload landing">

	<!-- header -->
	<%@ include file="../headerFooter/header.jsp"%>

	<!-- Banner -->
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
	<br>
	<br>
	<div>
		<p
			style="font-size: 50px; padding-left: 12%; padding-top: 5%; font-weight: bold;">QnA</p>
	</div>

	<section style="padding-right: 10%; padding-left: 10%; margin: 0 auto;">
		<form
			action='<c:url value='${pageContext.request.contextPath }/board/QnAUpdate.do'/>'
			method="post" id="ruView">
			<sec:csrfInput />
			<input type="hidden" name="p" value="${cv.currentPage }" /> <input
				type="hidden" name="s" value="${cv.pageSize }" /> <input
				type="hidden" name="b" value="${cv.blockSize }" /> <input
				type="hidden" name="qna_idx" value="${qv.qna_idx }" /> <input
				type="hidden" name="mb_idx" value="${mvo.mb_idx }" />
			<div style="text-align: right;">
				<c:choose>
					<c:when test="${mi == mvo.mb_idx }">
						<c:if test="${qv.qna_read == 0  }">
							<a href="#" onclick="document.getElementById('QnA').submit()">
								<input type="submit" class="btn btn-outline-secondary btn-sm"
								value="수정" />
							</a>
						</c:if>
						<c:if test="${qv.qna_read < 2}">
							<input type="submit" formaction="/board/QnADeleteOk.do"
								class="btn btn-outline-secondary btn-sm" value="삭제" />
						</c:if>
						<input type="button" onclick="location.href='/board/QnA.do'"
							class="btn btn-outline-secondary btn-sm" value="목록" />
					</c:when>
					<c:otherwise>
						<input type="button" onclick="location.href='/board/QnA.do'"
							class="btn btn-outline-secondary btn-sm" value="목록" />
					</c:otherwise>
				</c:choose>
			</div>
		</form>

		<br>
		<table class="table" style="border: 1px solid white;">
			<thead class="thead-dark">
				<tr>
					<th>
						<div
							style="text-align: left; font-size: 20px; font-weight: bold; padding-bottom: 1%; padding-left: 2%; padding-right: 2%;">
							${qv.qna_title }</div>
						<div class="row" style="padding-left: 2%">
							<div class="col-4" style="text-align: left; font-size: 15px;">닉네임
								: ${qv.mb_nick }</div>
							<div class="col-3" style="text-align: left; font-size: 15px;">
								등록일 :
								<fmt:formatDate value="${qv.qna_modiDate }"
									pattern="yyyy년 MM월 dd일 HH:mm:ss" />
							</div>
							<div class="col-4" style="text-align: right; font-size: 15px;">
								관리자
								<!-- 관리자가 읽으면 확인중 , 답변달면 답변완 표기 -->
								<c:choose>
									<c:when test="${qv.qna_read==0 }">
										<div>미확인</div>
									</c:when>
									<c:when test="${qv.qna_read==1 }">
										<div>확인중</div>
									</c:when>
									<c:when test="${qv.qna_read==2 }">
										<div>답변완</div>
									</c:when>
								</c:choose>
							</div>
						</div>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="color: white; padding-left: 3%;">${qv.qna_content }</td>
				</tr>
			</tbody>
		</table>

	</section>
	<br />
	<!-- 글 목록이 표시되어야 한다. -->
	<section style="padding-right: 10%; padding-left: 10%; margin: 0 auto;">
		<c:if test="${qv2.qna_ref==null }">
			<div style="border: 1px solid gray; text-align: center;">등록된
				답변이 없습니다.</div>
		</c:if>
		<c:if test="${qv2.qna_ref!=null }">
			<table class="table" style="border: 1px solid white;">
				<thead class="thead-dark">
					<tr>
						<th>
							<div class="row" style="padding-left: 2%">
								<div class="col-4" style="text-align: left; font-size: 15px;">닉네임
									: ${qv2.mb_nick }</div>
								<div class="col-3" style="text-align: left; font-size: 15px;">
									등록일 :
									<fmt:formatDate value="${qv2.qna_modiDate }"
										pattern="yyyy년 MM월 dd일 HH:mm:ss" />
								</div>
							</div>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="color: white; padding-left: 3%;">${qv2.qna_content }</td>
					</tr>
				</tbody>
			</table>
		</c:if>
	</section>

	<br />
	<c:if test="${role eq 'ROLE_ADMIN' }">
		<%-- 답변이 없으면 관리자 답변 이라는 글 표기 --%>
		<c:if test="${qv2.qna_read != 3 }">
			<div>
				<p style="font-size: 20px; text-align: center; font-weight: bold;">관리자
					답변</p>
			</div>
			<form
				action="${pageContext.request.contextPath}/board/answerInsertOk.do"
				method="post" id="answerInsert">
				<sec:csrfInput />
				<input type="hidden" name="mb_idx" value="${mvo.mb_idx }" /> <input
					type="hidden" name="qna_idx" value="${qv.qna_idx }" /> <input
					type="hidden" name="qna_title" value="답변" /> <input type="hidden"
					name="role" value="${mvo.gr_role }" />
				<section
					style="padding-right: 10%; padding-left: 10%; margin: 0 auto; padding-bottom: 2%">
					<textarea id="content" name="qna_content"
						style="height: 250px; color: black; background-color: white;"
						required="required">안녕하십니까, ${mvo.mb_nick } 입니다.</textarea>
				</section>
				<div style="text-align: center; padding-bottom: 3%">
					<input type="button" class="btn btn-outline-secondary btn-sm"
						style="margin: auto;" onclick="sendInsertParam();" value="답변달기">
				</div>
			</form>
		</c:if>
		<%-- 답변이 있다면 수정하기라는 글 표기 --%>
		<c:if test="${qv2.qna_read == 3 }">
			<div style="text-align: center; padding-bottom: 3%">
				<input type="button" id="updateBtn"
					class="btn btn-outline-secondary btn-sm" style="margin: auto;"
					onclick="update();" value="수정하기">
			</div>
			<div style="display: none;" id="answerUpdate">
				<form
					action="${pageContext.request.contextPath}/board/answerUpdateOk.do"
					method="post" id="answerUpdate2">
					<sec:csrfInput />
					<input type="hidden" name="mb_idx" value="${mvo.mb_idx }" /> <input
						type="hidden" name="qna_idx" value="${qv.qna_idx }" /> <input
						type="hidden" name="qna_title" value="답변" /> <input type="hidden"
						name="role" value="${mvo.gr_role }" />
					<section
						style="padding-right: 10%; padding-left: 10%; margin: 0 auto; padding-bottom: 2%">
						<textarea id="content" name="qna_content"
							style="height: 250px; color: black; background-color: white;"
							required="required">안녕하십니까, ${mvo.mb_nick } 입니다.</textarea>
					</section>
					<div style="text-align: center; padding-bottom: 3%">
						<input type="button" class="btn btn-outline-secondary btn-sm"
							style="margin: auto;" onclick="sendUpdateParam();" value="수정">
					</div>
				</form>
			</div>
		</c:if>
	</c:if>
	<%-- 실제적으로 갈 jsp --%>
	<form action="${pageContext.request.contextPath}/board/QnAView.do"
		method="post" id="sendData" name="sendData">
		<sec:csrfInput />
		<input type="hidden" name="p" value="${cv.currentPage }" /> <input
			type="hidden" name="s" value="${cv.pageSize }" /> <input
			type="hidden" name="b" value="${cv.blockSize }" /> <input
			type="hidden" name="qna_idx" value="${qv.qna_idx }" /> 
	</form>

	<!-- footer -->
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
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/assets/js/common.js"></script>
</body>
</html>