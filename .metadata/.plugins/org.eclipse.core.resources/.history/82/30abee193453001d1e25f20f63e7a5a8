<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="board.*"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<span style="width: 150px; display: inline-block;">${article.nickname}</span>
<span style="width: 200px; display: inline-block;">${article.title}</span>
<span style="width: 200px; display: inline-block;">${article.deal_status}</span>
<span style="width: 200px; display: inline-block;">${article.upload}</span>
<div>
<p>${article.goods_img }</p>
<img alt="goods_img" src="${contextPath}/download.do?
goods_img=${article.goods_img }&num_aticle=${articles.num_aticle}" id="preview">
<!--더미 데이터 name 받았습니다. 앞으로는 세션값과 비교를 해야합니다.-->
<c:set var="name" value="${name }"></c:set>
<c:set var="nickname" value="${article.nickname }"></c:set>
<c:choose>
	<c:when test = "${nickname.equals(name)}">
		<a href="${contextPath}/board/listArticles.do">목록보기</a>
		<a href="${contextPath}/board/modifyArticles.do">수정하기</a>
		<a href="${contextPath}/board/deleteArticles.do">삭제하기</a>
	</c:when>
	<c:otherwise>
		<a href="${contextPath}/board/listArticles.do">목록보기</a>
	</c:otherwise>
</c:choose>

</div>
</body>
</html>