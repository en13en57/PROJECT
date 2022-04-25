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
	function formCheck2(idx) {
		var value = $("#rereplyContent2" + idx).val();
		if (value == null || value.trim().length == 0) {
			alert('답변을 반드시 입력해야 합니다.');
			$("#rereplyContent2" + idx).val("");
			$("#rereplyContent2" + idx).focus();
			return false;
		}
	}
	// 댓글 달고 본 글로 돌아오기위한 ajax
	function sendInsertParam() {
		$.ajax({
			type : "POST",
			url : "replyInsertOk.do",
			data : $('#rView2').serialize(),
			dataType : "text",

			success : function(idx) {
				var jsonStr = JSON.parse(idx);
				console.log(jsonStr);
				document.sendData.p.value = jsonStr.p;
				document.sendData.s.value = jsonStr.s;
				document.sendData.b.value = jsonStr.b;
				document.sendData.rv_idx.value = jsonStr.rv_idx;

				document.sendData.submit();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
			}
		});
	}
	// 대댓글 달고 본 글로 돌아오기위한 ajax
	function sendReplyParam(index) {
		$.ajax({
			type : "POST",
			url : "rereply.do",
			data : $('#rView3' + index).serialize(),
			dataType : "text",

			success : function(res) {
				var jsonStr = JSON.parse(res);
				console.log(jsonStr);
				document.sendData.p.value = jsonStr.p;
				document.sendData.s.value = jsonStr.s;
				document.sendData.b.value = jsonStr.b;
				document.sendData.rv_idx.value = jsonStr.rv_idx;
				document.sendData.submit();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
			}
		});
	}
	// 댓글 수정후 본 글로 돌아오기위한 ajax
	function updateParam(index) {
		var value = $("#rereplyContent2" + index).val();
		if (value == null || value.trim().length == 0) {
			alert('답변을 반드시 입력해야 합니다.');
			$("#rereplyContent2" + index).val("");
			$("#rereplyContent2" + index).focus();
			return false;
		} else {

			$.ajax({
				type : "POST",
				url : "replyUpdateOk.do",
				data : $('#updateRe' + index).serialize(),
				dataType : "text",

				success : function(res) {
					var jsonStr = JSON.parse(res);
					console.log(jsonStr);
					document.sendData.p.value = jsonStr.p;
					document.sendData.s.value = jsonStr.s;
					document.sendData.b.value = jsonStr.b;
					document.sendData.rv_idx.value = jsonStr.rv_idx;
					document.sendData.submit();
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
				}
			});
		}
	}
	// 댓글 삭제 이후 본 글로 돌아오기위한 ajax
	function deleteParam(index) {
		$.ajax({
			type : "POST",
			url : "replyDeleteOk.do",
			data : $('#deleteRe' + index).serialize(),
			dataType : "text",

			success : function(res) {
				var jsonStr = JSON.parse(res);
				console.log(jsonStr);
				document.sendData.p.value = jsonStr.p;
				document.sendData.s.value = jsonStr.s;
				document.sendData.b.value = jsonStr.b;
				document.sendData.rv_idx.value = jsonStr.rv_idx;
				document.sendData.submit();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백
			}
		});
	}
	// 댓글에 있는 수정 클릭시 댓글 달 수 있는 텍스트 에어리어가 열리는 스크립트
	function moveForm(idx) {
		var move = document.getElementById("updateAction" + idx);
		if (move.style.display == 'none') {
			move.style.display = 'inline';
		} else {
			move.style.display = 'none';
		}
	}
	// 댓글에 있는 대댓글 클릭시 대댓글 달 수 있는 텍스트 에어리어가 열리는 스크립트
	function move(idx) {
		var move = document.getElementById("rereply" + idx);
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
	<div id="page-wrapper">

		<!-- header -->
		<%@ include file="../headerFooter/header.jsp"%>

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
				style="font-size: 50px; padding-left: 12%; padding-top: 5%; font-weight: bold;">캠핑후기</p>
		</div>
	</div>
	<!-- 후기 -->
	<section style="padding-right: 10%; padding-left: 10%; margin: 0 auto;">
		<form
			action='<c:url value='${pageContext.request.contextPath }/board/reviewUpdate.do'/>'
			method="post" id="ruView">
			<sec:csrfInput />
			<input type="hidden" name="p" value="${cv.currentPage }" /> <input
				type="hidden" name="s" value="${cv.pageSize }" /> <input
				type="hidden" name="b" value="${cv.blockSize }" /> <input
				type="hidden" name="rv_idx" value="${rv.rv_idx }" /> <input
				type="hidden" name="mode" value="0" />
			<!-- 본인이 쓴 글이면 수정 삭제 버튼 표시 -->
			<c:choose>
				<c:when test="${mi==mvo.mb_idx }">
					<div style="text-align: right;">
						<a href="#" onclick="document.getElementById('ruView').submit()">
							<input type="submit" class="btn btn-outline-secondary btn-sm"
							value="수정" />
						</a> <input type="submit" formaction="/board/reviewDeleteOk.do"
							class="btn btn-outline-secondary btn-sm" value="삭제" /> <input
							type="button" onclick="location.href='/board/review.do'"
							class="btn btn-outline-secondary btn-sm" value="목록" />
					</div>
				</c:when>
				<c:otherwise>
					<div style="text-align: right;">
						<input type="button" onclick="location.href='/board/review.do'"
							class="btn btn-outline-secondary btn-sm" value="목록" />
					</div>
				</c:otherwise>
			</c:choose>
		</form>
		<!-- 글이 삭제표시가 되어있다면 -->
		<c:if test="${rv.del==1}">
			<div onclick="return false;"
				style="background-color: gray; height: 80px; color: red; padding-left: 2%; margin-bottom: 5px;">삭제된
				후기입니다.</div>
		</c:if>
		<c:if test="${rv.del==0}">
			<br>
			<table class="table" style="border: 1px solid white;">
				<thead class="thead-dark">
					<tr>
						<th>
							<div
								style="text-align: left; font-size: 20px; font-weight: bold; padding-bottom: 1%; padding-left: 2%; padding-right: 2%;">
								${rv.rv_title }</div>
							<div class="row" style="padding-left: 2%">
								<div class="col-4" style="text-align: left; font-size: 15px;">닉네임
									: ${rv.mb_nick }</div>
								<div class="col-3" style="text-align: left; font-size: 15px;">
									등록일 :
									<fmt:formatDate value="${rv.rv_modiDate }"
										pattern="yyyy년 MM월 dd일 HH:mm:ss" />
								</div>
								<div class="col-4" style="text-align: right; font-size: 15px;">조회수
									: ${rv.rv_hit }</div>
							</div>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="color: white; padding-left: 3%;">${rv.rv_content }</td>
					</tr>
				</tbody>
			</table>
		</c:if>
	</section>
	<br />
	<!-- 리뷰 댓글 표시 -->
	<section style="padding-right: 10%; padding-left: 10%; margin: 0 auto;">
		<c:if test="${empty cm.list }">
			<div style="border: 1px solid gray; text-align: center;">등록된
				댓글이 없습니다.</div>
		</c:if>
		<c:if test="${not empty cm.list }">
			<c:forEach var="vo" items="${cm.list }" varStatus="vs">
				<c:if test="${vo.co_lev < 10}">
					<div style="margin-left:${vo.co_lev*50}px;">
						<!-- 삭제표시가 되어 있으면 삭제표시된 글이라고 표시한다. -->
						<c:if test="${vo.del2==1 }">
							<div onclick="return false;"
								style="background-color: gray; color: red; padding-left: 2%; margin-bottom: 5px;">삭제된
								댓글입니다.</div>
						</c:if>
						<!-- 삭제표시가 되어 있지 않으면 보여준다. -->
						<c:if test="${vo.del2==0 }">
							<c:out value="${vo.mb_nick }" />&nbsp;&nbsp;&nbsp;&nbsp; 
							<fmt:formatDate value="${vo.co_regDate }"
								pattern="yyyy년 MM월 dd일 HH:mm:ss" />
							<!-- 삭제표시를 달아보자 -->
							<div class="content">
								<div
									style="border: 1px solid white; size: 50px; padding-right: 2%; padding-left: 2%; margin: 0 auto;">
									<!-- 여기에 글의 내용을 출력한다. -->
									<c:set var="content" value="${vo.co_content }" />
									<!-- 태그 무시 -->
									<c:set var="content" value="${fn:replace(content,'<','&lt;') }" />
									<!-- \n을 <br>로 변경 -->
									<c:set var="content"
										value="${fn:replace(content, newLine, br ) }" />
									${content }

									<div style="text-align: right;">
										<input type="button" id="updateBtn${vs.index }"
											class="btn btn-outline-success btn-sm "
											onclick="moveForm('${vs.index }');" value="수정">
									</div>
									<div style="text-align: right; display: none;"
										id="updateAction${vs.index }">
										<input type="button" class="btn btn-outline-success btn-sm "
											onclick="updateParam('${vs.index}');" value="수정"> <input
											type="button" class="btn btn-outline-danger btn-sm "
											onclick="deleteParam('${vs.index }');" value="삭제" />
										<form
											action="${pageContext.request.contextPath}/board/replyUpdateOk.do"
											method="post" id="updateRe${vs.index}">
											<sec:csrfInput />
											<input type="hidden" name="p" value="${cv.currentPage }" />
											<input type="hidden" name="s" value="${cv.pageSize }" /> <input
												type="hidden" name="b" value="${cv.blockSize }" /> <input
												type="hidden" name="rv_idx" value="${vo.rv_idx }" /> <input
												type="hidden" name="co_idx" value="${vo.co_idx }" /> <input
												type="hidden" name="co_ref" value="${vo.co_ref }" /> <input
												type="hidden" name="co_seq" value="${vo.co_seq }" /> <input
												type="hidden" name="co_lev" value="${vo.co_lev }" />
											<textarea name="co_content" id="rereplyContent2${vs.index }"
												required></textarea>
										</form>
										<form
											action="${pageContext.request.contextPath}/board/replyDeleteOk.do"
											method="post" id="deleteRe${vs.index}">
											<sec:csrfInput />
											<input type="hidden" name="p" value="${cv.currentPage }" />
											<input type="hidden" name="s" value="${cv.pageSize }" /> <input
												type="hidden" name="b" value="${cv.blockSize }" /> <input
												type="hidden" name="rv_idx" value="${vo.rv_idx }" /> <input
												type="hidden" name="co_idx" value="${vo.co_idx }" /> <input
												type="hidden" name="co_ref" value="${vo.co_ref }" /> <input
												type="hidden" name="co_seq" value="${vo.co_seq }" /> <input
												type="hidden" name="co_lev" value="${vo.co_lev }" />
										</form>
									</div>
									<br />
								</div>
							</div>
							<div style="text-align: right;">
								<span style="cursor: pointer;" onclick="move('${vs.index }');">ㄴ대댓글</span>
							</div>
							<div style="display: none;" id="rereply${vs.index }">
								<form
									action="${pageContext.request.contextPath}/board/rereply.do"
									method="post" id="rView3${vs.index}">
									<sec:csrfInput />
									<input type="hidden" name="p" value="${cv.currentPage }" /> <input
										type="hidden" name="s" value="${cv.pageSize }" /> <input
										type="hidden" name="b" value="${cv.blockSize }" /> <input
										type="hidden" name="rv_idx" value="${vo.rv_idx }" /> <input
										type="hidden" name="co_idx" value="${vo.co_idx }" /> <input
										type="hidden" name="co_ref" value="${vo.co_ref }" /> <input
										type="hidden" name="co_seq" value="${vo.co_seq }" /> <input
										type="hidden" name="co_lev" value="${vo.co_lev }" /> <input
										type="hidden" name="mb_idx" value="${mvo.mb_idx }" />
									<textarea name="co_content" id="rereplyContent" required></textarea>
									<div style="text-align: right;">
										<input class="btn-outline-success btn-sm" type="button"
											value="대댓글" onclick="sendReplyParam('${vs.index }');" />
									</div>
								</form>
							</div>
						</c:if>
					</div>
				</c:if>
			</c:forEach>
		</c:if>
	</section>
	<br />
	<div>
		<p style="font-size: 20px; text-align: center; font-weight: bold;">댓글작성</p>
	</div>
	<form
		action="${pageContext.request.contextPath}/board//replyInsertOk.do"
		method="post" id="rView2">
		<sec:csrfInput />
		<input type="hidden" name="p" value="${cv.currentPage }" /> <input
			type="hidden" name="s" value="${cv.pageSize }" /> <input
			type="hidden" name="b" value="${cv.blockSize }" /> <input
			type="hidden" name="rv_idx" value="${rv.rv_idx }" /> <input
			type="hidden" name="mb_idx" value="${mvo.mb_idx }" />
		<section
			style="padding-right: 10%; padding-left: 10%; margin: 0 auto; padding-bottom: 2%">
			<textarea id="replyContent" name="co_content"
				style="background-color: white; color: black;"></textarea>
		</section>
		<div style="text-align: center; padding-bottom: 3%">
			<input type="button" onclick="sendInsertParam();"
				class="btn btn-outline-secondary btn-sm" style="margin: auto;"
				value="댓글달기">
		</div>
	</form>

	<%-- 실제적으로 갈 jsp --%>
	<form action="${pageContext.request.contextPath}/board/reviewView.do"
		method="post" id="sendData" name="sendData">
		<sec:csrfInput />
		<input type="hidden" name="p" value="${cv.currentPage }" /> <input
			type="hidden" name="s" value="${cv.pageSize }" /> <input
			type="hidden" name="b" value="${cv.blockSize }" /> <input
			type="hidden" name="rv_idx" value="${rv.rv_idx }" />
	</form>

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
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/assets/js/common.js"></script>
</body>
</html>