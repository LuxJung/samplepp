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
ul, li {	list-style: none;}
.conttl {	float: left;	width: 100px;}
.clb {	clear: boath;}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   function readURL(input) {
      if (input.files && input.files[0]) {
	      var reader = new FileReader();
	      reader.onload = function (e) {
	        $('#preview').attr('src', e.target.result);
          }
         reader.readAsDataURL(input.files[0]);
      }
  }  
  function backToList(obj){
    obj.action="${contextPath}/board/listArticles.do";
    obj.submit();
  }

</script>
<meta charset="UTF-8">
<title>글쓰기창</title>
</head>
<body>
	<h2>글쓰기</h2>
	<form name="articleForm" method="post"
		action="${contextPath}/board/createArticle.do"
		enctype="multipart/form-data">
		<ul>
			
			<li style="clear: boath;">
				<div class="conttl">제목</div>
				<div class="clb">
					<input type="text" placeholder="상품 제목을 입력해주세요." name="title"
						>
				</div>
			</li>
			<li style="clear: boath;">
				<div class="conttl">가격</div>
				<div class="clb">
					<input type="text" placeholder="숫자만 입력해주세요." name="price" >원
				</div>
			</li>
			<li style="clear: boath;">
				<div class="conttl">내용</div>
				<div class="clb">
					<input type="text"
						placeholder="여러 장의 상품 사진과 구입 연도, 브랜드, 사용감, 하자 유무 등 구매자에게 필요한 정보를 꼭 포함해 주세요. (10자 이상)
"
						name="content" >
				</div>
			</li>
			<li>
				<div class="conttl">상품이미지</div>
				<div class="clb">
					<ul>
						<li>이미지 등록 
						<input type="file" name="goods_img" onchange="readURL(this)" />
						<img alt="img" id ="preview" src="#" width="200" height="200">	
						</li>
					</ul>
				</div>
			</li>
		</ul>
		<input type="submit" value="글쓰기" />
		<input type="button" value="목록보기"
			onClick="backToList(this.form)" />
	</form>
</body>
</html>