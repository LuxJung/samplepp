<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
ul, li {
	list-style: none;
}

.conttl {
	float: left;
	width: 100px;
}

.clb {
	clear: boath;
}
</style>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">


<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=togeufhl9z&submodules=geocoder"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
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
	<h2>글쓰기</h2>
	<form name="articleForm" method="post" enctype="multipart/form-data"
		action="${contextPath}/board/createArticle.do">
		<ul>
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
						placeholder="여러 장의 상품 사진과 구입 연도, 브랜드, 사용감, 하자 유무 등 구매자에게 필요한 정보를 꼭 포함해 주세요. (10자 이상)"/>
				</div>
			</li>
			<li>
				<div class="conttl">상품이미지</div>
				<div class="clb">
					<ul>
						<li>이미지 등록 
							<input type="file" name="goods_img" onchange="readURL(this)" /> 
							<img alt="img" id="preview" src="#"	width="200" height="200">
						</li>
					</ul>
				</div>
			</li>
		</ul>
		<div id="map" style="width: 100%; height: 400px;"></div>
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
		<input type="submit" value="글쓰기" /> 
		<input type="button" value="목록보기" onClick="backToList(this.form)" />
	</form>
</body>
</html>