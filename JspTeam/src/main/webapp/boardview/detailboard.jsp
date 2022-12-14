<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="board.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">

<head>
<meta name="viewport" charset="UTF-8"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">


<link rel="stylesheet" type="text/css"	href="../resource/css/bootstrap.css">
<link rel="stylesheet" type="text/css"	href="../resource/css/override.css">

<script type="text/javascript"	src="../resource/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../resource/js/jquery-3.6.0.js"></script>

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

.btn_box_mdfy {
	display: none;
}

.hiddenVlue {
	display: none;
}

.imgContainer {
	padding-left: 10px;
	width: 400px;
	height: 300px;
	overflow: hidden;
	width: 400px;
}

.imgContainer img {
	max-width: 100%;
	height: auto;
	display: block;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
	
		$('#preview').css('display', 'none');
	});
	function modify() {
		$('.btn_box_mdfy').css("display", "block");
		$('.btn_box').css("display", "none");
	}

	function remove_aticle(url, num_aticle) {
		var form = document.createElement("form");
		//var num = $('#num').val();
		var url = "${contextPath}/board/deleteArticles.do";
		
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
	
	
	
	function backToList() {
		$(location).attr("href", "../board/listArticles.do");
	}

	function resolve() {
		$.ajax({
			type : "post",
			dataType : "text",
			async : true,
			url : "${contextPath}/board/resolve.do",
			data : {
				'deal_status' : 1,
				'num_aticle' : $('#num').val(),
				'nickname' : $('#id').val()
			},
			success : function(data, textStatus) {
				$('#message').append(data);
			},
			error : function(data, textStatus) {
				alert("??????.");
			},
			complete : function(data, textStatus) {
				alert("????????????");
				$('#deal_status').attr("value", "?????????");
				$('#resov').attr("value", "?????????").attr(disable);
			}
		});
	}
	function resolvechk() {
		$.ajax({
			type : "post",
			dataType : "text",
			async : true,
			url : "${contextPath}/board/resolve.do",
			data : {
				'num_aticle' : $('#num').val(),
				'nickname' : $('#id').val()
			},
			success : function(data, textStatus) {
				$('#message').append(data);
			},
			error : function(data, textStatus) {
				alert("??????.");
			},
			complete : function(data, textStatus) {
				alert("????????????");
				$('#deal_status').attr("value", "????????????");
				$('#resovres').attr("value", "????????????").attr(disable);
			}
		});
	}
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('.preview').attr('src', e.target.result);
				$('.preview').css('display', 'block');
				var img = $('.preview').attr('src');
				var decod=img.val($.base64.btoa(this.value));

				$('#fileValue').text(img);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	function modifyArticle() {
		$('#v1').addClass('hiddenVlue');
		$('#v2').removeClass('hiddenVlue');
	}
	
	function newArticle() {
		var loginUser =  '<%=(String)session.getAttribute("sessionID")%>';
		console.log(loginUser);
		
		if(loginUser=="null"){
			alert("???????????? ????????? ????????? ?????????.");
			$(location).attr("href", "../login/loginForm_.jsp");
		}else{
			$(location).attr("href", "../boardview/addboard.jsp");
		}
	}
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<!-- ?????? -->
	<%-- <%@ include file="../include/login_nav.jsp" %> --%>

	<nav class="py-2 bg-light border-bottom ">
		<div class="container d-flex flex-wrap">
			<ul class="nav me-auto">
				<!--?????? ??? ????????? ??????....-->
				<li class="nav-item"><a href="${contextPath}/board/listArticles.do"
					class="nav-link link-dark px-2 active" aria-current="page">Home</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">Features</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">Pricing</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">About</a></li>
			</ul>
			<ul class="nav">
				<%
				if (session.getAttribute("sessionID") != null || session.getAttribute("kakaosessionID") != null) {
				%>
				<!--???????????? ????????? ?????? display ??????-->
				<li class="nav-item login_true "><a href="">
						<!--??????????????? ??????--> <!--????????? ?????? ????????? ?????????--> <img
						src="../resource/users/${userInfo.profile_img }" alt="mdo"
						width="40" height="40" class="rounded-circle">
				</a></li>
				<li class="nav-item login_true "><a
					href="${contextPath}/userController/logout.do"
					onclick="kakaoLogout()" class="nav-link link-dark px-2">Logout</a>
				</li>

				<%
				} else if (session.getAttribute("sessionID") == null || session.getAttribute("kakaosessionID") == null) {
				%>
				<!--???????????? ????????? ?????? display ??????-->

				<!--???????????? ????????? ?????? display ??????-->
				<li class="nav-item login_true">
					<!--????????? ????????? ??????--> <a href="../login/loginForm_.jsp"
					class="nav-link link-dark px-2">Login</a>
				</li>

				<li class="nav-item login_true">
					<!--???????????? ????????? ??????--> <a href="../join/joinForm_2.jsp"
					class="nav-link link-dark px-2">Sign up</a>
				</li>
				<%
				}
				%>
			</ul>
		</div>
	</nav>
	<%@ include file="../include/head_title.jsp"%>

	<!-- read.do?????? ????????? ?????? ??????-->
	<c:set var="name" value="${name }"></c:set>
	<c:set var="deal" value="${article.deal_status }" />
	<c:set var="nickname" value="${article.nickname }"></c:set>
	<c:set var="num_aticle" value="${article.num_aticle }"></c:set>
<%-- 	<span id="num">${num_aticle} </span><span id="loguser">${userInfo.id} </span>
 --%>	<main class="container">
		<section id="v1">
			<div class="px-4 my-3 text-center " style="height: 50px;">
				<h1 class="display-5 fw-bold">?????? ????????????</h1>
			</div>
			<hr class="my-4">

<%-- ????????????${userInfo.id }/ ???????????????${ article.nickname }
 --%>
			<div class="container">
				<div class="row">
					<div class="col">
						<h4 class="font-monospace text-muted text-uppercase">?????? ?????????</h4>
						<input name="id" class="hiddenVlue" value="${userInfo.id }">
						<div class="bd-example-snippet bd-code-snippet">
							<div class="bd-example imgContainer">
								
								<!--???????????? ?????????-->
								<img src="../resource/imgs/${article.num_aticle}/${article.goods_img }" 
									class="bd-placeholder-img figure-img img-thumbnail preview"
									alt="preview" width="400" height="300">
							</div>
							<div class="highlight mb-3">
								<input class="form-control hiddenVlue" type="file"
									name="goods_img" onchange="readURL(this)">
							</div>
						</div>
					</div>
					<div class="col">
						<div class="row">
							<div class="input-group mb-3 mt-4">
								<span class="input-group-text" id="basic-addon1"> ??? ??? </span> <input
									name="title" type="text" class="form-control" disabled id="tit"
									placeholder="?????? ????????? ??????????????????." aria-label="Username"
									aria-describedby="basic-addon1" value="${article.title}">
							</div>
						</div>
						<div class="row">
							<div class="input-group mb-3 mt-4">
								<span class="input-group-text" id="basic-addon1"> ??? ??? </span> <input
									type="text" class="form-control" placeholder="????????? ??????????????????."
									id="test" aria-label="Username" aria-describedby="basic-addon1"
									onchange="getNumber(this);" onkeyup="getNumber(this);" disabled
									name="price" value="${article.price}"> <span
									class="input-group-text">???</span>
							</div>
						</div>
						<div class="row">
							<div class="input-group mb-3 mt-4 col">
								<span class="input-group-text" id="basic-addon1">?????????</span> <input
									name="title" type="text" class="form-control" disabled
									placeholder="?????? ????????? ??????????????????." aria-label="Username"
									aria-describedby="basic-addon1" value="${article.nickname}">
							</div>
							<div class="input-group mb-3 mt-4 col">
								<span class="input-group-text" id="basic-addon1">?????????</span> <input
									name="title" type="text" class="form-control" disabled
									placeholder="?????? ????????? ??????????????????." aria-label="Username"
									aria-describedby="basic-addon1" value="${article.upload}">
							</div>
						</div>
						<div class="row">
							<div class="input-group mb-3 mt-4 col">
								<span class="input-group-text" id="basic-addon1">????????????</span> <input
									name="title" type="text" class="form-control" id="deal_status"
									placeholder="?????? ????????? ??????????????????." aria-label="Username" disabled
									aria-describedby="basic-addon1" value="${article.deal_status}">
							</div>
							<div class="input-group mb-3 mt-4 col">
								<div
									class="col d-grid gap-2 d-sm-flex justify-content-sm-center">

									<c:if test="${article.nickname != userInfo.id}">
										<c:choose>
											<c:when test="${article.deal_status == '?????????'}">
												<input
													class="btn btn-success btn-md form-control px-4 gap-3"
													type="button" id="resov" value="????????????" onClick="resolve()" />
											</c:when>
											<c:otherwise>
												<input
													class="btn btn-success btn-md form-control px-4 gap-3"
													type="button" value="????????????" disabled />
											</c:otherwise>
										</c:choose>
									</c:if>
									<c:if test="${article.nickname == userInfo.id}">
										<c:choose>
											<c:when test="${article.deal_status == '?????????'}">
												<input
													class="btn btn-success btn-md form-control px-4 gap-3"
													type="button" id="resov" value="????????????" disabled />
											</c:when>
											<c:when test="${article.deal_status == '?????????'}">
												<input
													class="btn btn-success btn-md form-control px-4 gap-3"
													type="button" id="resov" value="????????????" onClick="resolve()" />
											</c:when>
											<c:otherwise>
												<input
													class="btn btn-success btn-md form-control px-4 gap-3"
													type="button" value="????????????" disabled />
											</c:otherwise>
										</c:choose>
									</c:if>

								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="input-group pt-2">
					<span class="input-group-text"> ??? ??? </span>
					<textarea class="form-control" aria-label="With textarea"
						style="resize: none; height: 150px;" name="content" id="con" disabled
						placeholder="?????? ?????? ?????? ????????? ?????? ??????, ?????????, ?????????, ?????? ?????? ??? ??????????????? ????????? ????????? ??? ????????? ?????????. (10??? ??????)">${article.contents}</textarea>
				</div>
				<div class="row mx-auto pt-5">
					<div class="d-grid gap-2 d-sm-flex justify-content-sm-end">
						<c:choose>
							<c:when test="${article.nickname != userInfo.id }">
								<input type="button" value="????????????"
									class="btn btn-success btn-lg px-4 gap-3" 
									onclick="newArticle();"/>
								<input type="button" value="????????????"
									class="btn btn-outline-secondary btn-lg px-4"
									onClick="backToList()" />
							</c:when>
							<c:otherwise>
								<input type="button" value="????????????"
									class="btn btn-success btn-lg px-4 gap-3" onclick="newArticle();"/>
								<input type="button" value="????????????"
									class="btn btn-success btn-lg px-4 gap-3" onClick="modifyArticle();"/>
								<input type="button" value="????????????"
									class="btn btn-outline-secondary btn-lg px-4"
									onClick="backToList()" />
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</section>
		<section id="v2" class="hiddenVlue">
			<div class="px-4 py-5 my-5 text-center ">
				<img class="d-block mx-auto mb-5"
					src="../resource/banner/logo_green.png"
					alt="${contextPath}/board/listboard.do" width="150" height="150">
				<h1 class="display-5 fw-bold">????????????</h1>
			</div>

			<hr class="my-4">
			<%-- <c:out value="${userInfo.id }"></c:out>
			${userInfo.id } --%>

			<div class="my-3 p-3 bg-body rounded shadow-sm">
				<form name="articleForm" method="post" enctype="multipart/form-data"
					action="${contextPath}/board/modifyArticles.do">
					<input name="num_aticle" class="hiddenVlue" value="${article.num_aticle}">

					<h4 class="font-monospace text-muted text-uppercase">?????? ?????????</h4>
					<input name="id" style="visibility: hidden;"
						value="${userInfo.id }">
					<div class="bd-example-snippet bd-code-snippet">
						<div class="bd-example">
							<!--?????? ?????????-->
							<img src="../resource/imgs/${article.num_aticle}/${article.goods_img }"
								class="bd-placeholder-img img-thumbnail preview"
								alt="preview" width="400" height="300">
						</div>
						<div class="col mx-auto pt-3">
							<div class="d-grid d-sm-flex justify-content-start">
								<input type="submit" class="btn btn-success mb-3 btn-sm gap-3"
									value="????????? ??????" />
									<span id="fileValue" ></span>
							</div>
						</div>
						<div class="highlight mb-3">
							<input class="form-control" type="file" name="goods_img"
								onchange="readURL(this)">
						</div>
					</div>
					<div class="d-flex text-muted pt-3">
						<div class="input-group mb-3">
							<span class="input-group-text" id="basic-addon1"> ??? ??? </span> <input
								name="title" type="text" class="form-control" id="tit"
								placeholder="?????? ????????? ??????????????????." aria-label="Username"
								aria-describedby="basic-addon1" value="${article.title}">
						</div>
					</div>
					<div class="d-flex text-muted pt-3">
						<div class="input-group mb-3">
							<span class="input-group-text" id="basic-addon1"> ??? ??? </span> <input
								type="text" class="form-control" placeholder="????????? ??????????????????."
								id="test" aria-label="Username" aria-describedby="basic-addon1"
								onchange="getNumber(this);" onkeyup="getNumber(this);"
								name="price" value="${article.price}"> <span
								class="input-group-text">???</span>
						</div>
					</div>
					<div class="input-group pt-3">
						<span class="input-group-text"> ??? ??? </span>
						<textarea class="form-control" aria-label="With textarea"
							style="resize: none; height: 150px;" name="content" id="con"
							placeholder="?????? ?????? ?????? ????????? ?????? ??????, ?????????, ?????????, ?????? ?????? ??? ??????????????? ????????? ????????? ??? ????????? ?????????. (10??? ??????)">${article.contents}</textarea>
					</div>


					<div class="col-lg-6 mx-auto pt-3">
						<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
							<input type="submit" class="btn btn-success btn-lg px-4 gap-3" value="????????????" 
							onClick="modify_aticle('${contextPath}/board/modifyArticles.do','${article.num_aticle}')"/> 
							<input type="button" class="btn btn-outline-secondary btn-lg px-4" value="????????????"
							onClick="remove_aticle('${contextPath}/board/deleteArticles.do','${article.num_aticle}')" />
							<input type="button" class="btn btn-outline-secondary btn-lg px-4" value="????????????"
							onClick="backToList();" />
						</div>
					</div>
				</form>
			</div>
			<hr class="my-4">
		</section>
	</main>
</body>
</html>
