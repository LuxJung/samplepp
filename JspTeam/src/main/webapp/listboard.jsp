<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="main.*"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<style>
a{text-decoration: none; }
a:hover{font-style: italic;}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>글목록</h1>
<div style="border:1px solid #000000;">
<c:choose>
	<c:when test="${empty articlesList }">
		<p>리스트가 없다능</p>
		<c:redirect url="/board/listArticles.do"></c:redirect>
	</c:when>
	<c:when test="${!empty articlesList }">
	<ol>	
	<li style="list-style: none;" value="0">
			<span style="width: 150px; display: inline-block;">닉넴</span>
			<span style="width: 200px; display: inline-block;">제목</span>
			<span style="width: 200px; display: inline-block;">상태</span>
			<span style="width: 200px; display: inline-block;">날짜</span>
		</li>
	<c:forEach var="articles" items="${articlesList }">
		
		<li>
			<a href="${contextPath}/board/readArticle.do?num_aticle=${articles.num_aticle}">
			<span style="width: 150px; display: hidden;">${articles.num_aticle}</span>
			<span style="width: 150px; display: inline-block;">${articles.nickname}</span>
			<span style="width: 200px; display: inline-block;">${articles.title}</span>
			<span style="width: 200px; display: inline-block;">${articles.deal_status}</span>
			<span style="width: 200px; display: inline-block;">${articles.upload}</span>
			</a>
		</li>
		
	</c:forEach>
	</ol>
	</c:when>
</c:choose>
</div>
<a href="${contextPath}/board/addArticle.do">글쓰기</a>
</body>
</html>