<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- JSTL 사용 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<%-- css --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/main.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/swiper.min.css">

<script type="text/javascript">
	function certification() { // 인증안된 회원이 글쓰기 버튼을 눌렀을때
		alert("메일인증이 필요합니다.");
		location.href = "/board/notice.do";
	}

	function loginSubmit() { // 비회원이 글쓰기를 눌렀을때
		alert("로그인 필요합니다.");
		location.href = "/board/login.do";
	}

	// 글쓰기 버튼 클릭시 수행
	function noticeInsert() {
		document.getElementById("sendForm").submit();
	}

	// 네비게이션 첫번째 선택시 두번째 옵션 변경
	function change(val) {
		if (val.value == 'fst') {
			document.getElementById("selectfst").style.display = 'inline';
			document.getElementById("selectsnd").style.display = 'none';
		} else if (val.value == 'snd') {
			document.getElementById("selectfst").style.display = 'none';
			document.getElementById("selectsnd").style.display = 'inline';
		}
	}
	
	// 검색시 인수값으로 계속 넘겨주기 위한 스크립트
	function noticeSearch(){
		var selectOption = document.getElementById("searchType");
		selectOption = selectOption.options[selectOption.selectedIndex].value;
		document.getElementById("searchResult").value = selectOption;
		document.getElementById("searchAction").submit();
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

table td {
	margin: 0 auto;
}

table {
	text-align: center;
	table-layout: fixed;
}

.th-1 {
	width: 40px;
}

.th-2 {
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

.th-7 {
	width: 30px;
}

#title {
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
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
	<!-- 네비게이션 -->
	<div class="col-sm-8"></div>
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
			style="font-size: 50px; padding-left: 12%; padding-top: 5%; font-weight: bold;">공지사항</p>
	</div>
	<!-- 검색 기능 -->
	<div style="padding-right: 10%; padding-bottom: 3%;">
		<form action="/selectSearchNotice.do" method="get" id="searchAction">
			<sec:csrfInput />
			<div class="col-sm-1" style="float: right;">
				<input type="button" value="검색" onclick="noticeSearch();">
			</div>

			<div class="col-sm-2" style="float: right;">
				<input type="text" name="searchText"/>
			</div>
			<!-- 선택시 값, 아니면 공백 -->
			<div class="col-sm-1.8" style="float: right;">
				<select id="searchType" style="float: left;">
					<option value="all" selected>전체</option>
					<option value="title" ${searchType eq 'title' ? 'selected' : '' }>제목</option>
					<option value="content"
						${searchType eq 'content' ? 'selected' : '' }>내용</option>
				</select>
				<input type="hidden" name="searchType" id="searchResult" />
			</div>
		</form>
	</div>
	<!-- 공지사항 리스트 -->
	<section
		style="padding-right: 10%; padding-left: 10%; padding-bottom: 3%; margin: 0 auto;">
		${pv.pageInfo} <br>
		<table class="table table-hover table-dark">
			<tr>
				<th class="th-1" scope="col">글번호</th>
				<th class="th-2" scope="col">제목</th>
				<!-- <th class="th-3" scope="col">내용</th> -->
				<th class="th-4" scope="col">닉네임</th>
				<th class="th-5" scope="col">작성일</th>
				<th class="th-6" scope="col">조회수</th>
				<th class="th-7" scope="col">파일</th>
			</tr>
			<tr>
				<c:if test="${pv.totalCount==0 }">
					<td colspan="6">등록된 글이 없습니다.</td>
				</c:if>
			</tr>
			<c:if test="${pv.totalCount>0 }">
				<c:if test="${not empty pv.list }">
					<!-- 페이지 사이즈마다 맞는 번호를 찍어주기 위해 -->
					<c:set var="no"
						value="${pv.totalCount - (pv.currentPage-1)*pv.pageSize}" />
					<c:forEach var="vo" items="${pv.list }" varStatus="num">
						<tr>
							<!-- 최신글이 제일 마지막 번호 찍기 -->
							<td style="vertical-align: middle;">${no }<c:set var="no"
									value="${no-1}" />
							</td>
							<td style="padding-bottom: 40px;" id="title">
								<form
									action='<c:url value='${pageContext.request.contextPath }/board/noticeView.do'/>'
									method="post" id="nView${num.index }">
									<sec:csrfInput />
									<input type="hidden" name="nt_idx" value="${vo.nt_idx }" /> <input
										type="hidden" name="mode" value="1" />
								</form> <%--오늘 저장한 글이면 new  --%> <jsp:useBean id="today"
									scope="request" class="java.util.Date"></jsp:useBean> <fmt:formatDate
									value="${today }" pattern="yyyyMMdd" var="day" /> <fmt:formatDate
									value="${vo.nt_modiDate }" pattern="yyyyMMdd" var="modi" /> <c:if
									test="${day==modi }">
									<span style="color: red;">New</span>
								</c:if> <c:set var="content" value="${vo.nt_content }" /> <c:set
									var="title" value="${vo.nt_title }" /> 
									<!-- 제목이 20자 이상이면, 20자 이후 ...으로 표기  -->
								<c:choose>
									<c:when test="${fn:length(title) >= 20 }">
										<a style="cursor: pointer;"
											onclick="document.getElementById('nView${num.index }').submit()"><c:out
												value="${fn:substring(title,0,20) }" />...&nbsp;</a>
										<!-- 내용에 <img 라는 단어가 있으면 사진이미지 표시 -->
										<c:if test="${fn:contains(content,'<img')}">
											<img
												style="width: 25px; height: 25px; vertical-align: middle;"
												src="${pageContext.request.contextPath }/resources/images/image.png"
												alt="" />
										</c:if>
									</c:when>
									<c:otherwise>
										<a style="cursor: pointer;"
											onclick="document.getElementById('nView${num.index }').submit()"><c:out
												value="${title}" />&nbsp;</a>
										<c:if test="${fn:contains(content,'<img')}">
											<img
												style="width: 25px; height: 25px; vertical-align: middle;"
												src="${pageContext.request.contextPath }/resources/images/image.png"
												alt="" />
										</c:if>
									</c:otherwise>
								</c:choose>
							</td>
							<td style="vertical-align: middle;">${vo.mb_nick }</td>
							<td style="vertical-align: middle;"><fmt:formatDate
									value="${vo.nt_modiDate }" pattern="yy-MM-dd" /></td>
							<td style="vertical-align: middle;">${vo.nt_hit }</td>
							<td style="vertical-align: middle;">
								<%-- 첨부파일 표시 --%> <c:if test="${not empty vo.fileList }">
									<img style="width: 25px; height: 25px; vertical-align: middle;"
										src="${pageContext.request.contextPath }/resources/images/fileImage.png"
										alt="" />
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</c:if>
		</table>
		<!-- 페이징 글개수가 없으면 나오지않고 -->
		<c:if test="${pv.totalCount==0 }">
           		<div style="border: none; text-align: center;"></div>
      		</c:if>
         	<c:if test="${pv.totalCount!=0 }">
				<c:if test="${pv.searchType==null }">
					<div style="border: none;text-align: center;">
						${pv.pageList}
					</div>
				</c:if>
				<c:if test="${pv.searchType!=null }">
					<div style="border: none;text-align: center;">
						${pv.pageList2}
					</div>
				</c:if>
			</c:if>
		<c:set value="${sessionScope.mvo.gr_role}" var="role" />
		<c:if test="${role eq 'ROLE_ADMIN' }">
			<button type="button" class="btn btn-outline-secondary"
				style="float: right;" onclick="noticeInsert()">글쓰기</button>
		</c:if>
		<br>
	</section>
	<br>
	<form action="/board/noticeInsert.do" id="sendForm" method="post">
		<sec:csrfInput />
	</form>

	<!-- Footer -->
	<%@ include file="../headerFooter/footer.jsp"%>

	<!-- Scripts -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/common.js"></script>
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