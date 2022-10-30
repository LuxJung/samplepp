<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="board.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css"
	href="../resource/css/bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="../resource/css/override.css" />

<script type="text/javascript"
	src="../resource/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../resource/js/jquery-3.6.0.js"></script>

<!-- <script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?
										clientId=togeufhl9z&callback=initMap"></script> -->

<script type="text/javascript">
	$(document).ready(function() {
		$('#preview').css('visibility', 'hidden');
	});

	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
				$('#preview').css('visibility', 'visible');
				$('#default_img').css('display', 'none');
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	function backToList(obj) {
		obj.action = "${contextPath}/board/listArticles.do";
		obj.submit();
	}
</script>
<meta charset="UTF-8">
<title>글쓰기창</title>
</head>
<body>
	<%@ include file="../include/login_nav.jsp"%>
	<%@ include file="../include/head_title.jsp"%>
	<main class="container">
		<div class="px-4 py-5 my-5 text-center ">
			<img class="d-block mx-auto mb-5"
				src="../resource/banner/logo_green.png"
				alt="${contextPath}/board/listboard.do" width="150" height="150">
			<h1 class="display-5 fw-bold">상품등록</h1>
		</div>



		<hr class="my-4">


		<div class="my-3 p-3 bg-body rounded shadow-sm">
			<form name="articleForm" method="post" enctype="multipart/form-data"
				action="${contextPath}/board/createArticle.do">
				
					<h4 class="font-monospace text-muted text-uppercase">제품 이미지</h4>
				
				<div class="bd-example-snippet bd-code-snippet">
					<div class="bd-example">
						<!--디폴트 이미지-->
						<figure class="figure" id="default_img">
							<!--이미지를 선택하면 사라짐-->
							<img src="../resource/banner/default_img.png"
								class="figure-img img-fluid rounded" alt="...">
							<figcaption class="figure-caption">이미지를 등록해주세요</figcaption>
						</figure>
						<!--미리보기 이미지-->
						<img src="..." id="preview"	class="bd-placeholder-img img-thumbnail" alt="..." width="400"
							height="300">
					</div>
					<div class="highlight mb-3">
						
						<input class="form-control" type="file" id="formFileMultiple" >
						
					</div>
				</div>
				<div class="d-flex text-muted pt-3">
					<svg class="bd-placeholder-img flex-shrink-0 me-2 rounded"
						width="32" height="32" xmlns="http://www.w3.org/2000/svg"
						role="img" aria-label="Placeholder: 32x32"
						preserveAspectRatio="xMidYMid slice" focusable="false">
						<title>Placeholder</title><rect width="100%" height="100%"
							fill="#e83e8c"></rect>
						<text x="50%" y="50%" fill="#e83e8c" dy=".3em">32x32</text></svg>

					<p class="pb-3 mb-0 small lh-sm border-bottom">
						<strong class="d-block text-gray-dark">@username</strong> Some
						more representative placeholder content, related to this other
						user. Another status update, perhaps.
					</p>
				</div>
				<div class="d-flex text-muted pt-3">
					<svg class="bd-placeholder-img flex-shrink-0 me-2 rounded"
						width="32" height="32" xmlns="http://www.w3.org/2000/svg"
						role="img" aria-label="Placeholder: 32x32"
						preserveAspectRatio="xMidYMid slice" focusable="false">
						<title>Placeholder</title><rect width="100%" height="100%"
							fill="#6f42c1"></rect>
						<text x="50%" y="50%" fill="#6f42c1" dy=".3em">32x32</text></svg>

					<p class="pb-3 mb-0 small lh-sm border-bottom">
						<strong class="d-block text-gray-dark">@username</strong> This
						user also gets some representative placeholder content. Maybe they
						did something interesting, and you really want to highlight this
						in the recent updates.
					</p>
				</div>
				<small class="d-block text-end mt-3"> <a href="#">All
						updates</a>
				</small>

			</form>
		</div>
		<hr class="my-4">



		<form name="articleForm" method="post" enctype="multipart/form-data"
			action="${contextPath}/board/createArticle.do">
			<ul>
				<li>
					<div class="conttl">상품이미지</div>
					<div class="clb">
						<ul>
							<li><img src="..." id="preview" class="img-thumbnail"
								alt="..." width="200" height="200">이미지 등록 <input
								type="file" name="goods_img" onchange="readURL(this)" /> <img
								alt="img" id="preview" src="#" width="200" height="200"></li>
						</ul>
					</div>
				</li>
				<li style="clear: boath;">
					<div class="conttl">제목</div>
					<div class="clb">
						<input type="text" placeholder="상품 제목을 입력해주세요." name="title">
					</div>
				</li>
				<li style="clear: boath;">
					<div class="conttl">가격</div>
					<div class="clb">
						<input type="text" placeholder="숫자만 입력해주세요." name="price">원
					</div>
				</li>
				<li style="clear: boath;">
					<div class="conttl">내용</div>
					<div class="clb">
						<input type="text" name="content"
							placeholder="여러 장의 상품 사진과 구입 연도, 브랜드, 사용감, 하자 유무 등 구매자에게 필요한 정보를 꼭 포함해 주세요. (10자 이상)" />
					</div>
				</li>

			</ul>
			<div class="col-lg-6 mx-auto">

				<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">

					<input type="submit" class="btn btn-success btn-lg px-4 gap-3"
						value="제품등록" /> <input type="button"
						class="btn btn-outline-secondary btn-lg px-4" value="목록보기"
						onClick="backToList(this.form)" />

				</div>
			</div>
			<!-- <div id="map" style="width: 100%; height: 400px;"></div>
			<script>
				var map = new naver.maps.Map("map", {
					center : new naver.maps.LatLng(37.3595316, 127.1052133),
					zoom : 15,
					mapTypeControl : true
				});
				var infoWindow = new naver.maps.InfoWindow({
					anchorSkew : true
				});
				map.setCursor('pointer');
				function searchCoordinateToAddress(latlng) {
					infoWindow.close();
					naver.maps.Service
							.reverseGeocode(
									{
										coords : latlng,
										orders : [
												naver.maps.Service.OrderType.ADDR,
												naver.maps.Service.OrderType.ROAD_ADDR ]
												.join(',')
									},
									function(status, response) {
										if (status === naver.maps.Service.Status.ERROR) {
											return alert('Something Wrong!');
										}
										var items = response.v2.results, address = '', htmlAddresses = [];
										for (var i = 0, ii = items.length, item, addrType; i < ii; i++) {
											item = items[i];
											address = makeAddress(item) || '';
											addrType = item.name === 'roadaddr' ? '[도로명 주소]'
													: '[지번 주소]';
											htmlAddresses.push((i + 1) + '. '
													+ addrType + ' ' + address);
										}
										infoWindow
												.setContent([
														'<div style="padding:10px;min-width:200px;line-height:150%;">',
														'<h4 style="margin-top:5px;">검색 좌표</h4><br />',
														htmlAddresses
																.join('<br />'),
														'</div>' ].join('\n'));
										infoWindow.open(map, latlng);
									});
				}
				function searchAddressToCoordinate(address) {
					naver.maps.Service
							.geocode(
									{
										query : address
									},
									function(status, response) {
										if (status === naver.maps.Service.Status.ERROR) {
											return alert('Something Wrong!');
										}
										if (response.v2.meta.totalCount === 0) {
											return alert('totalCount'
													+ response.v2.meta.totalCount);
										}
										var htmlAddresses = [], item = response.v2.addresses[0], point = new naver.maps.Point(
												item.x, item.y);
										if (item.roadAddress) {
											htmlAddresses.push('[도로명 주소] '
													+ item.roadAddress);
										}
										if (item.jibunAddress) {
											htmlAddresses.push('[지번 주소] '
													+ item.jibunAddress);
										}
										if (item.englishAddress) {
											htmlAddresses.push('[영문명 주소] '
													+ item.englishAddress);
										}
										infoWindow
												.setContent([
														'<div style="padding:10px;min-width:200px;line-height:150%;">',
														'<h4 style="margin-top:5px;">검색 주소 : '
																+ address
																+ '</h4><br />',
														htmlAddresses
																.join('<br />'),
														'</div>' ].join('\n'));
										map.setCenter(point);
										infoWindow.open(map, point);
									});
				}
				function initGeocoder() {
					map.addListener('click', function(e) {
						searchCoordinateToAddress(e.coord);
					});
					$('#address').on('keydown', function(e) {
						var keyCode = e.which;
						if (keyCode === 13) { // Enter Key
							searchAddressToCoordinate($('#address').val());
						}
					});
					$('#submit').on('click', function(e) {
						e.preventDefault();
						searchAddressToCoordinate($('#address').val());
					});
					searchAddressToCoordinate('정자동 178-1');
				}
				function makeAddress(item) {
					if (!item) {
						return;
					}
					var name = item.name, region = item.region, land = item.land, isRoadAddress = name === 'roadaddr';
					var sido = '', sigugun = '', dongmyun = '', ri = '', rest = '';
					if (hasArea(region.area1)) {
						sido = region.area1.name;
					}
					if (hasArea(region.area2)) {
						sigugun = region.area2.name;
					}
					if (hasArea(region.area3)) {
						dongmyun = region.area3.name;
					}
					if (hasArea(region.area4)) {
						ri = region.area4.name;
					}
					if (land) {
						if (hasData(land.number1)) {
							if (hasData(land.type) && land.type === '2') {
								rest += '산';
							}
							rest += land.number1;
							if (hasData(land.number2)) {
								rest += ('-' + land.number2);
							}
						}
						if (isRoadAddress === true) {
							if (checkLastString(dongmyun, '면')) {
								ri = land.name;
							} else {
								dongmyun = land.name;
								ri = '';
							}
							if (hasAddition(land.addition0)) {
								rest += ' ' + land.addition0.value;
							}
						}
					}
					return [ sido, sigugun, dongmyun, ri, rest ].join(' ');
				}
				function hasArea(area) {
					return !!(area && area.name && area.name !== '');
				}
				function hasData(data) {
					return !!(data && data !== '');
				}
				function checkLastString(word, lastString) {
					return new RegExp(lastString + '$').test(word);
				}
				function hasAddition(addition) {
					return !!(addition && addition.value);
				}
				naver.maps.onJSContentLoaded = initGeocoder;
				var mapOptions = {
					center : new naver.maps.LatLng(37.3595704, 127.105399),
					zoom : 10
				};
				var map = new naver.maps.Map('map', mapOptions);
				var marker = new naver.maps.Marker({
					position : new naver.maps.LatLng(37.3595704, 127.105399),
					map : map
				});
				var point = new naver.map.Point(128, 256);
				point.toString(); // '(128,256)'
			</script>
 -->
		</form>
	</main>
</body>
</html>