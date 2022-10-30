<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="board.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" valu e="${pageContext.request.contextPath}" />
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">


<script type="text/javascript" 
src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=togeufhl9z&submodules=geocoder"></script>
<link rel="stylesheet" type="text/css" href="../resource/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="../resource/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../resource/js/bootstrap.min.js"></script>

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
.btn_box_mdfy{display: none;}
</style>

<script type="text/javascript">
	function modify() {
		$('.btn_box_mdfy').css( "display", "block" );
		$('.btn_box').css( "display", "none" );
	}
	
	function remove_aticle(url, num_aticle) {
		var form = document.createElement("form");
		//var url = "${contextPath}/board/deleteArticles.do";
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		var aricleNo = document.createElement("input");
		aricleNo.setAttribute("type", "hidden");
		aricleNo.setAttribute("name", "num_aticle");
		aricleNo.setAttribute("value", num_aticle);
		form.appendChild(aricleNo);
		document.body.appendChild(form);
		form.submit();
	}
	function backToList(obj){
	    obj.action="${contextPath}/board/listArticles.do";
	    obj.submit();
	  }
	
    function resolve(){
        $.ajax({
          type:"post",
          dataType:"text",
          async:true,  
          url:"${contextPath}/board/resolve.do",
          data: {'deal_status':1, 'num_aticle':$('#num').val(), 'nickname':$('#id').val()},
          success:function (data,textStatus){
             $('#message').append(data);
          },
          error:function(data,textStatus){
             alert("실패.");
          },
          complete:function(data,textStatus){
             alert("예약완료");
             $('#deal_status').attr("value","예약중");
             $('#resov').attr("value","예약중").attr(disable);
          }
       });	
    }	
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../include/login_nav.jsp" %>
	<%@ include file="../include/head_title.jsp" %>
	<form name="articleForm" method="post"
		action="${contextPath}/board/modifyArticles.do"
		enctype="multipart/form-data">
		<ul>
			<li style="display: none;">
				<input id="num" type="text" name="num_aticle" value="${article.num_aticle}">
			</li>
			<li style="clear: boath;">
				<div class="conttl">닉네임</div>
				<div class="clb">
					<input id="id" type="text" name="nickname" value="${article.nickname}">
				</div>
			</li>
			<li style="clear: boath;">
				<div class="conttl">제목</div>
				<div class="clb">
					<input type="text" placeholder="상품 제목을 입력해주세요." name="title"
						value="${article.title}">
				</div>
			</li>
			<li style="clear: boath;">
				<div class="conttl">가격</div>
				<div class="clb">
					<input type="text" placeholder="숫자만 입력해주세요." name="price"
						value="${article.price}">원
				</div>
			</li>
			<li style="clear: boath;">
				<div class="conttl">내용</div>
				<div class="clb">
					<input type="text"
						placeholder="여러 장의 상품 사진과 구입 연도, 브랜드, 사용감, 하자 유무 등 구매자에게 필요한 정보를 꼭 포함해 주세요. (10자 이상)
"
						value="${article.contents}" name="content">
				</div>
			</li>
			<li style="clear: boath;">
				<div class="conttl">판매상태</div>
				<div class="clb">
					<input type="text" id="deal_status" value="${article.deal_status}" name="deal_status">
				</div>
			</li>
			<li style="clear: boath;">
				<div class="conttl">등록일</div>
				<div class="clb">
					<input type="text"	value="${article.upload}" name="upload">
				</div>
			</li>
			<li>
				<div class="conttl">
					상품이미지 
					
				</div>
				<img alt="goods_img" width="500" height="500" src="../resource/imgs/${article.num_aticle}/${article.goods_img }">
				<div class="clb">
					<ul>
						<li>이미지 수정 
							<input type="file" name="goods_img"	onchange="readURL(this)" /> 
							<img alt="img" id="preview" src="#"	width="200" height="200">
						</li>
					</ul>
				</div>
			</li>
		</ul>
		<div id="message"></div>
		<div class="clb" id="map" style="width:50%;height:400px;"></div>

<script>
var map = new naver.maps.Map("map", {
    center: new naver.maps.LatLng(37.3595316, 127.1052133),
    zoom: 15,
    mapTypeControl: true
});
var infoWindow = new naver.maps.InfoWindow({
    anchorSkew: true
});
map.setCursor('pointer');
function searchCoordinateToAddress(latlng) {
    infoWindow.close();
    naver.maps.Service.reverseGeocode({
        coords: latlng,
        orders: [
            naver.maps.Service.OrderType.ADDR,
            naver.maps.Service.OrderType.ROAD_ADDR
        ].join(',')
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('Something Wrong!');
        }
        var items = response.v2.results,
            address = '',
            htmlAddresses = [];
        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
            item = items[i];
            address = makeAddress(item) || '';
            addrType = item.name === 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';
            htmlAddresses.push((i+1) +'. '+ addrType +' '+ address);
        }
        infoWindow.setContent([
            '<div style="padding:10px;min-width:200px;line-height:150%;">',
            '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
            htmlAddresses.join('<br />'),
            '</div>'
        ].join('\n'));
        infoWindow.open(map, latlng);
    });
}
function searchAddressToCoordinate(address) {
    naver.maps.Service.geocode({
        query: address
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('Something Wrong!');
        }
        if (response.v2.meta.totalCount === 0) {
            return alert('totalCount' + response.v2.meta.totalCount);
        }
        var htmlAddresses = [],
            item = response.v2.addresses[0],
            point = new naver.maps.Point(item.x, item.y);
        if (item.roadAddress) {
            htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
        }
        if (item.jibunAddress) {
            htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
        }
        if (item.englishAddress) {
            htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
        }
        infoWindow.setContent([
            '<div style="padding:10px;min-width:200px;line-height:150%;">',
            '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
            htmlAddresses.join('<br />'),
            '</div>'
        ].join('\n'));
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
    var name = item.name,
        region = item.region,
        land = item.land,
        isRoadAddress = name === 'roadaddr';
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
    return [sido, sigugun, dongmyun, ri, rest].join(' ');
}
function hasArea(area) {
    return !!(area && area.name && area.name !== '');
}
function hasData(data) {
    return !!(data && data !== '');
}
function checkLastString (word, lastString) {
    return new RegExp(lastString + '$').test(word);
}
function hasAddition (addition) {
    return !!(addition && addition.value);
}
naver.maps.onJSContentLoaded = initGeocoder;
var mapOptions = {
    center: new naver.maps.LatLng(37.3595704, 127.105399),
    zoom: 10
};
var map = new naver.maps.Map('map', mapOptions);
var marker = new naver.maps.Marker({
    position: new naver.maps.LatLng(37.3595704, 127.105399),
    map: map
});
var point = new naver.map.Point(128, 256);
point.toString(); // '(128,256)'
</script>
		<!-- read.do에서 디폴트 네임 지정-->
		<c:set var="name" value="${name }"></c:set>
		<c:set var="deal" value="${article.deal_status }" />
		<c:set var="nickname" value="${article.nickname }"></c:set>
		<c:choose>
			<c:when test="${nickname.equals(name)}">
			<div class="btn_box">
				<input type="button" value="목록보기" onClick="backToList(this.form)" />
				<input type="button" value="수정하기" onClick="modify()"/>
				<input type="button"
					onclick="remove_aticle('${contextPath}/board/deleteArticles.do','${article.num_aticle}')"
					value="삭제하기" />
				<%-- href="${contextPath}/board/deleteArticles.do?num_aticle=${article.num_aticle}" --%>
			</div>
			<div class="btn_box_mdfy">
				<input type="button" value="목록보기" onClick="backToList(this.form)" />
				<input type="submit" value="수정완료" />
				<%-- href="${contextPath}/board/deleteArticles.do?num_aticle=${article.num_aticle}" --%>
			</div>
			</c:when>
			<c:otherwise>
				<!--상품 에약쿼리 실행할 것 -->
				<input type="button" value="목록보기" onClick="backToList(this.form)" />			
				   
				<input type="button" id="resov" value="예약하기" onClick="resolve()" />
				
			</c:otherwise>
		</c:choose>
		
		<p> ${name }</p>
		<p> ${nickname }</p>
</form>

</body>
</html>