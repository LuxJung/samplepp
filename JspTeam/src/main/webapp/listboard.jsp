<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="main.*"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<style>
/* ol,li{margin: 0; padding: 0;} */
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>글목록</h1>

<c:choose>
	<c:when test="${empty articlesList }">
		<p>리스트가 없다능</p>
		<c:redirect url="/board"></c:redirect>
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
		<li >
			<span style="width: 150px; display: inline-block;">${articles.nickname}</span>
			<span style="width: 200px; display: inline-block;">${articles.title}</span>
			<span style="width: 200px; display: inline-block;">${articles.deal_status}</span>
			<span style="width: 200px; display: inline-block;">${articles.upload}</span>
		</li>
	</c:forEach>
	</ol>
	</c:when>
</c:choose>
</body>
</html>