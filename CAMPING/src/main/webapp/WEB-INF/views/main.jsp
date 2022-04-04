<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<style>
.swiper-container {
	width: 90%;
	height: 200px;
	margin: 20px auto;
}

#dd {
font-size: 13px;
color : yellow;
font-weight: bold;
}

.swiper-slide {
	text-align: center;
	font-size: 18px;
	width: 60%;
	/* Center slide text vertically */
	display: -webkit-box;
	display: -ms-flexbox;
	display: -webkit-flex;
	display: flex;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	-webkit-justify-content: center;
	justify-content: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	-webkit-align-items: center;
	align-items: center;
}

.swiper-slide:nth-child(2n) {
	width: 40%;
}

.swiper-slide:nth-child(3n) {
	width: 20%;
}

.swiper-slide-text {
	text-align: right;
	position: absolute;
	transform: translate(-50%, -50%);
	top: 100%;
	left: 30%;
}




</style>

<noscript>
	<link rel="stylesheet"
		href="${pageContext.request.contextPath }/resources/assets/css/noscript.css" />
</noscript>
</head>
<body class="is-preload landing">

	<!-- header -->
	<%@ include file="headerFooter/header.jsp" %>

	<!-- Banner -->
	<section id="banner">
		<div class="content">
			<header class="hightitle">
				<h2>캠핑은 NG캠핑!</h2>
				<p>
					여러분의 캠핑생활을 도와드립니다!<br> 스크롤을 내려 캠핑정보를 확인하세요!
				<p style="padding-top: 5%;">
					사진을 클릭 또는 드래그를하여 <br> 캠핑장정보를 확인하세요
				</p>
			</header>

			<!-- Swiper -->
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<img width=100%
							src="${pageContext.request.contextPath }/resources/images/Camp1.jpg">
						<div class="swiper-slide-text">
							<p id="dd">우리두리캠핑장</p>
						</div>
					</div>

					<div class="swiper-slide">
						<img width=100%
							src="${pageContext.request.contextPath }/resources/images/Camp2.jpg">
						<div class="swiper-slide-text">
							<p id="dd">땡땡이글램핑</p>
						</div>
					</div>

					<div class="swiper-slide">
						<img width=100%
							src="${pageContext.request.contextPath }/resources/images/Camp3.jpg">
						<div class="swiper-slide-text">
							<p id="dd">수정 오토캠핑장</p>
						</div>
					</div>

					<div class="swiper-slide">
						<img width=100%
							src="${pageContext.request.contextPath }/resources/images/Camp4.jpg">
						<div class="swiper-slide-text">
							<p id="dd">왕터 리조트</p>
						</div>
					</div>

					<div class="swiper-slide">
						<img width=100%
							src="${pageContext.request.contextPath }/resources/images/Camp5.jpg">
						<div class="swiper-slide-text">
							<p id="dd">칠포 그린로즈 야영장</p>
						</div>
					</div>

					<div class="swiper-slide">
						<img width=100%
							src="${pageContext.request.contextPath }/resources/images/Camp6.jpg">
						<div class="swiper-slide-text">
							<p id="dd">달빛 담은 캠핑장</p>
						</div>
					</div>

					<div class="swiper-slide">
						<img width=100%
							src="${pageContext.request.contextPath }/resources/images/Camp7.jpg">
						<div class="swiper-slide-text">
							<p id="dd">독립기념관 캠핑장</p>
						</div>
					</div>

					<div class="swiper-slide">
						<img width=100%
							src="${pageContext.request.contextPath }/resources/images/Camp8.jpg">
						<div class="swiper-slide-text">
							<p id="dd">강진 사포해변공원</p>
						</div>
					</div>

					<div class="swiper-slide">
						<img width=100%
							src="${pageContext.request.contextPath }/resources/images/Camp9.jpg">
						<div class="swiper-slide-text">
							<p id="dd">스카이운학 캠핑장</p>
						</div>
					</div>

					<div class="swiper-slide">
						<img width=100%
							src="${pageContext.request.contextPath }/resources/images/Camp10.jpg">
						<div class="swiper-slide-text">
							<p id="dd">다둥이네 캠핑장</p>
						</div>
					</div>

					<p>
				</div>

				<!-- Add Pagination -->
				<div class="swiper-pagination"></div>
			</div>
			<script
				src="${pageContext.request.contextPath }/resources/assets/js/swiper.min.js"></script>
			<script>
				var swiper = new Swiper('.swiper-container', {
					pagination : '.swiper-pagination',
					slidesPerView : 4,
					centeredSlides : true,
					paginationClickable : true,
					spaceBetween : 30,

				});
			</script>

			<!-- Add Pagination -->
			<div class="swiper-pagination"></div>
		</div>
	</section>


	<!-- One -->
	<section id="one" class="spotlight style1 bottom">
		<span class="image fit main"><img
			src="${pageContext.request.contextPath }/resources/assets/css/images/pic02.jpg"
			alt="" /></span>
		<div class="content">
			<div class="container">
				<div class="row">
					<div class="col-4 col-12-medium">
						<header>
							<h2>저희 NG캠핑장은</h2>
							<p>
								가족 또는 연인, 친구들과 함께!<br> 혹은 캠핑을 좋아하는 캠핑족들을 위해 <br> 제작된
								페이지입니다.
							</p>
						</header>
					</div>
					<div class="col-4 col-12-medium">
						<p>
							평소 캠핑에 관심이 많은 당신! 혹은 캠핑을 <br> 하고 싶은 당신! 막상 하고싶은데 캠핑장이 <br>
							어디에 있는지 지금당장 가도 운영을 하는지 <br> 궁금하시죠? 그런분들을 위해 준비했습니다. <br>
							바로 저의 NG캠핑에 모든것이 다 있습니다
						</p>
					</div>
					<div class="col-4 col-12-medium">
						<p>
							캠핑 초보자에서부터 배테랑까지 다양한 <br> 캠핑족들을 위해 캠핑장 정보를 공유합니다.<br>
							뿐만아니라 여러분들이 직접 후기를 적어 <br> 가장 좋았던 캠핑장을 골라 추천까지!<br>
							여러분들의 재미있는 캠핑을 추구합니다.
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Two -->
	<section id="two" class="spotlight style1 left">
		<span class="image fit main"><img
			src="http://san.chosun.com/site/data/img_dir/2021/06/23/2021062301705_0.jpg"
			alt="" /></span>
		<div class="content">
			<header>
				<h2>
					일반 야영장을 <br> 찾으시나요?
				</h2>
				<p>
					여러분의 위치에서부터 전국에 있는 <br> 일반 야영장을 찾아드립니다.
				</p>
			</header>
			<p>
				사람들이 거의 찾지 않는 지역에서 낭만을<br> 즐기고 싶은 당신! 그런당신을 위해 준비했습니다.
			</p>
			<ul class="actions">
				<li><a href="#" class="button">더보기</a></li>
			</ul>
		</div>
	</section>

	<!-- Three -->
	<section id="three" class="spotlight style2 right">
		<span class="image fit main bottom"><img
			src="https://menu.mt.co.kr/moneyweek/thumb/2020/11/20/06/2020112014268082492_1.jpg"
			alt="" /></span>
		<div class="content">
			<header>
				<h2>
					자동차야영장을<br>찾으시나요?
				</h2>
				<p>
					여러분의 위치에서부터 전국에 있는<br>자동차 야영장을 찾아드립니다.
				</p>
			</header>
			<p>
				차박캠핑을 좋아하는 당신, 당신을위해 <br> 자동차 야영장을 추천합니다!
			</p>
			<ul class="actions">
				<li><a href="#" class="button">더보기</a></li>
			</ul>
		</div>
	</section>


	<section id="four" class="spotlight style3 left">
		<span class="image fit main"><img
			src="https://i2.wp.com/kingshope.kr/wp-content/uploads/2021/07/20210715_091542.png?fit=1024%2C617&ssl=1"
			alt="" /></span>
		<div class="content">
			<header>
				<h2>
					카라반을 <br> 찾으시나요?
				</h2>
				<p>
					여러분의 위치에서부터 전국에 있는 <br> 카라반을 찾아드립니다.
				</p>
			</header>
			<p>
				차박과는 다른 느낌을 내고싶다고요? <br>그렇다면 카라반을 추천합니다!
			</p>
			<ul class="actions">
				<li><a href="#" class="button">더보기</a></li>
			</ul>
		</div>
	</section>


	<section id="five" class="spotlight style4 right">
		<span class="image fit main bottom"><img
			src="https://www.5gcamp.com/files/camping/2018/10/14/e63b570aafb5e6bb859e699563b94367192926.jpg"
			alt="" /></span>
		<div class="content">
			<header>
				<h2>
					글램핑을 <br> 찾으시나요?
				</h2>
				<p>
					여러분의 위치에서부터 전국에 있는 <br> 글램핑을 찾아드립니다.
				</p>
			</header>
			<p>
				가족 또는 연인, 친구들과 함께 재미있는 <br>캠핑 분위기를 즐기고싶다면 <br>글램핑을 추천합니다!
			</p>
			<ul class="actions">
				<li><a href="#" class="button">더보기</a></li>
			</ul>
		</div>
	</section>




	<!-- Four -->
	<section id="six" class="wrapper style1 special fade-up">
		<div class="container">
			<header class="major">
				<h2>현재 저희 NG캠핑의 캠핑장 갯수입니다.</h2>
				<p>저희 NG캠핑은 총 0개의 캠핑장의 정보를 가지고 있습니다.</p>
			</header>
			<div class="box alt">
				<div class="row gtr-uniform">
					<section class="col-4 col-6-medium col-12-xsmall">
						<span class="icon solid alt major"> <span
							class="icon solid alt major fas fa-mountain"></span>
						</span>
						<h3>000개</h3>
						<h3>일반야영장</h3>
						<p>일반야영장 테마의 캠핑장 갯수입니다.</p>
					</section>

					<section class="col-4 col-6-medium col-12-xsmall">
						<span class="icon solid alt major fas fa-car"></span>
						<h3>000개</h3>
						<h3>지동차야영장</h3>
						<p>자동차야영장 테마의 캠핑장 갯수입니다.</p>
					</section>

					<section class="col-4 col-6-medium col-12-xsmall">
						<span class="icon solid alt major fas fa-campground"></span>
						<h3>000개</h3>
						<h3>글램핑/카라반</h3>
						<p>글램핑/카라반 테마의 캠핑장 갯수입니다.</p>
					</section>
					<section>
						<!-- 	<br> <br> <a href="#seven" class="goto-next scrolly">Next</a> -->
					</section>
				</div>
			</div>
		</div>
	</section>

	<!-- 게시판 및 공지사항 -->
	<section id="seven" style="background-color: #E44C65">
		<div class="container">
			<div class="box alt">
				<div class="row gtr-uniform">
					<section class="col-4 col-12-xsmall" style="top: 20px">
						<table>
							<tr>
								<td>
									<h3 style="text-align: left">공지사항</h3>
								</td>
								<td>
									<form action="/board/notice.do" method="post" id="notice">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }"> 
										<a href="#"><i class="fa fa-plus fa-1" style="float: right" onclick="document.getElementById('notice').submit()"></i></a>
									</form>
								</td>
							</tr>
							<tr>
								<c:if test="${nv.totalCount==0 }">
									<td colspan="2">등록된 글이 없습니다.</td>
								</c:if>
							</tr>
							<c:if test="${not empty nv.list }">
								<c:forEach var="vo" items="${nv.list }">
									<tr>
										<td colspan="2" style="text-align: left"><i
											class="fa fa-angle-right" aria-hidden="true"></i><font
												color="white">${vo.nt_title }</font></td>
									</tr>
								</c:forEach>
							</c:if>
						</table>
						<br>
					</section>
					<section class="col-4 col-12-xsmall" style="top: 20px">
						<table>
							<tr>
								<td>
									<h3 style="text-align: left">QnA</h3>
								</td>
								<td>
									<form action="/board/QnA.do" method="post" id="QnA">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }"> 
										<a href="#"><i class="fa fa-plus fa-1" style="float: right" onclick="document.getElementById('QnA').submit()"></i></a>
									</form>
								</td>
							</tr>
							<tr>
								<c:if test="${qv.totalCount==0 }">
									<td colspan="2">등록된 글이 없습니다.</td>
								</c:if>
							</tr>
							<c:if test="${not empty qv.list }">
								<c:forEach var="vo" items="${qv.list }">
									<tr>
										<td colspan="2" style="text-align: left"><i
											class="fa fa-angle-right" aria-hidden="true"></i> <font
												color="white">${vo.qna_title }</font></td>
									</tr>
								</c:forEach>
							</c:if>
						</table>
						<br>
					</section>

					<section class="col-4 col-12-xsmall" style="top: 20px">
						<table>
							<tr>
								<td>
									<h3 style="text-align: left">캠핑후기</h3>
								</td>
								<td>
									<form action="/board/review.do" method="post" id="review">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }"> 
										<a href="#"><i class="fa fa-plus fa-1" style="float: right" onclick="document.getElementById('review').submit()"></i></a>
									</form>
								</td>
							</tr>
							<tr>
								<c:if test="${rv.totalCount==0 }">
									<td colspan="2">등록된 글이 없습니다.</td>
								</c:if>
							</tr>
							<c:if test="${not empty rv.list }">
								<c:forEach var="vo" items="${rv.list }">
									<tr>
										<td colspan="2" style="text-align: left"><i
											class="fa fa-angle-right" aria-hidden="true"></i> <font
												color="white">${vo.rv_title }</font></td>
									</tr>
								</c:forEach>
							</c:if>
						</table>
						<br>
					</section>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer -->
<%@ include file="headerFooter/footer.jsp" %>

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
	<div style="position: fixed; bottom: 10px; right: 10px; z-index: 100;">
		<a href="#banner" style="text-decoration: underline;"><img
			src="${pageContext.request.contextPath }/resources/assets/css/images/top.png"></a>
	</div>
</body>
</html>