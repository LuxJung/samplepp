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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<span style="width: 150px; display: inline-block;">${article.nickname}</span>
<span style="width: 200px; display: inline-block;">${article.title}</span>
<span style="width: 200px; display: inline-block;">${article.deal_status}</span>
<span style="width: 200px; display: inline-block;">${article.upload}</span>
<div>
<a href="${contextPath}/board/listArticles.do">목록보기</a>
<a href="${contextPath}/board/modifyArticles.do">수정하기</a>
</div>
</body>
</html>