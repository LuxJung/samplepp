<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>기본정보</h2>
	<form name="articleForm" method="post"
		action="${contextPath}/board/addArticle.do"
		enctype="multipart/form-data">
		<ul>
			<li>
				<div class="conttl">상품이미지</div>
				<div class="clb">
					<ul>
						<li>이미지 등록 <input type="file"
							accept="image/jpg, image/jpeg, image/png" multiple=""></li>
					</ul>
				</div>
			</li>
			<li style="clear: boath;">
				<div class="conttl">제목</div>
				<div class="clb">
					<input type="text" placeholder="상품 제목을 입력해주세요." value="">
				</div>
			</li>
			<li style="clear: boath;">
				<div class="conttl">가격</div>
				<div class="clb">
					<input type="text" placeholder="숫자만 입력해주세요." value="">원
				</div>
			</li>
			<li style="clear: boath;">
				<div class="conttl">내용</div>
				<div class="clb">
					<input type="text"
						placeholder="여러 장의 상품 사진과 구입 연도, 브랜드, 사용감, 하자 유무 등 구매자에게 필요한 정보를 꼭 포함해 주세요. (10자 이상)
"
						value="">
				</div>
			</li>
		</ul>
		<input type="submit" value="글쓰기" /> 
		<input type=button value="목록보기"
			onClick="backToList(this.form)" />
	</form>
</body>
</html>