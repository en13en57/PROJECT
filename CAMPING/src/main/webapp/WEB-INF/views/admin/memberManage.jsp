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
	// 로그아웃시
	function logoutSubmit() {
		var logout = document.logout;
		logout.submit();
	}
	
	// 리스트된 정보중 클릭 해당 정보 번호 가져오기
	function selectInfo(index){
		var infoIdx = document.getElementById('mb_idx');
		infoIdx.value = document.getElementById('idx'+index).innerHTML;
		if(infoIdx != null){
			infoSubmit();							
		}
	}
	
	// 폼액션 실행 전송하기
	function infoSubmit(){
		document.getElementById('infoForm').submit();
	}
</script>

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
		<div class="col-sm-8">
			<img src="">
		</div>
		<br> <br>
		<div>
			<p style="font-size: 50px; padding-left: 12%; padding-top: 5%; font-weight: bold;">회원관리</p>
			</div>
			<form action="/selectSearchMember.do" method="post">
				<sec:csrfInput/>
			<div style="padding-right: 8%; padding-bottom: 3%;">
			<div class="col-sm-1" style="float: right;">
				<input type="submit" value="검색" >
			</div>

			<div class="col-sm-2" style="float: right;">
				<input type="text" name="searchText" value="${searchtext }"/> 
			</div>
			<!-- 옵션 선택에 따라 검색 옵션 변경 -->
			<div class="col-sm-1.8" style="float: right;">
				<select name="searchType" id="searchType" style="float: left;">
					<option value="all" selected>전체</option>
					<option value="id" ${searchType eq 'id' ? 'selected' : '' }>아이디</option>
					<option value="name" ${searchType eq 'name' ? 'selected' : '' }>이름</option>
					<option value="nick" ${searchType eq 'nick' ? 'selected' : '' }>닉네임</option>
					<option value="role" ${searchType eq 'role' ? 'selected' : '' }>권한</option>
				</select>
			</div>
		</div>
		</form>
		<div style="padding-left: 160px;">
		전체 : ${pv.totalCount} 개 
		</div>
		<div style="padding-left: 12%;">
			<form id="infoForm" action="/admin/memberManageInfo.do">
			<div style="width:90%; height:200px; overflow:auto">
				<table style="width: 100%; font-size: 17px;" id="infoTable">
					<tr>
						<th> No </th>
						<th> 아이디 </th>
						<th> 이름 </th>
						<th> 닉네임 </th>
						<th> 권한 </th>
					</tr>
					<tr></tr>
					<tr>
						<c:if test="${pv.totalCount==0 }">
							<td colspan="6">등록된 사용자가 없습니다.</td>
						</c:if>
					</tr>
					<c:if test="${pv.totalCount > 0 }">
						<c:if test="${not empty pv.list }">
							<c:forEach var="vo" items="${pv.list }" varStatus="num">
								<tr style="cursor:pointer;" id="info${num.index }" onclick="selectInfo('${num.index}')">
									<td id="idx${num.index }">${vo.mb_idx }</td>
									<td>${vo.mb_ID }</td>
									<td>${vo.mb_name }</td>
									<td>${vo.mb_nick }</td>
									<td>${vo.gr_role }</td>
								</tr>
							</c:forEach>
						</c:if>
					</c:if>
				</table>
				</div>
				<input type="hidden" id="mb_idx" name="mb_idx">
			</form>
		</div>
		<br>
		<form method="post">
			<sec:csrfInput/>
			<div style="padding-left: 12%;">
				<!-- 회원 선택시 띄워주는 정보 -->
				<table class="table table-bordered" style="width: 90%; color: white; font-size: 17px;">
					<tr>
						<th colspan="5" style="text-align: left; padding-left: 2%; font-size: 20px; font-weight: bold;" >정보보기</th>
					</tr>
					<tr>
						<td style="width: 100px; text-align: center; background-color:#2D2E36; ">아이디</td>
						<td style="width: 300px; background-color:#1C1D26;">
							<c:out value="${mv.mb_ID }"/>
							<input type="hidden" name="mb_ID" value="${mv.mb_ID }">
						</td>
						
						<td style="width: 100px; text-align: center; background-color:#2D2E36;">비밀번호</td>
						<td style="width: 300px; background-color:#1C1D26;"> 
							<button class="btn btn-secondary" formaction="/resetPasswordOk.do">임시번호 발급</button>
						
						</td>
					</tr>
					<tr>
						<td style="width: 100px; text-align: center; background-color:#2D2E36; ">이름</td>
						<td style="width: 300px; background-color:#1C1D26;"><c:out value="${mv.mb_name }"/></td>
						<td style="width: 100px; text-align: center; background-color:#2D2E36; ">닉네임</td>
						<td style="width: 300px; background-color:#1C1D26;"><c:out value="${mv.mb_nick }"/></td>
					</tr>
					<tr>
						<td style="width: 100px; text-align: center; background-color:#2D2E36; ">이메일</td>
						<td style="width: 300px; background-color:#1C1D26;">
							<c:out value="${mv.mb_email }"/>
							<input type="hidden" name="mb_email" value="${mv.mb_email }">
						</td>
						
						<td style="width: 100px; text-align: center; background-color:#2D2E36; ">전화번호</td>
						<td style="width: 300px; background-color:#1C1D26;"><c:out value="${mv.mb_tel }"/></td>
					</tr>
					<tr>
						<td style="width: 100px; text-align: center; background-color:#2D2E36; ">생일</td>
						<td style="width: 300px; background-color:#1C1D26;"><c:out value="${mv.mb_birth }"/></td>
						<td style="width: 100px; text-align: center; background-color:#2D2E36; ">권한</td>
						<td style="width: 300px; background-color:#1C1D26;"><c:out value="${mv.gr_role }"/></td>
					</tr>
					<tr>
						<td style="width: 100px; text-align: center; background-color:#2D2E36; ">주소</td>
						<td style="width: 300px; background-color:#1C1D26;" colspan="1"><c:out value="${mv.mb_address1 }"/><br><c:out value="${mv.mb_address2 }"/></td>
					</tr>
				</table>
				<br>
			</div>
		</form>
	</div>

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