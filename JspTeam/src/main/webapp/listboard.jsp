<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="main.*"%>
<%@ page import="java.io.PrintWriter" %>
<!-- BbsDAO 함수를 사용하기때문에 가져오기 -->
<!-- DAO쪽을 사용하면 당연히 javaBeans도 사용되니 들고온다.-->
<!-- ArrayList같은 경우는 게시판의 목록을 가져오기위해 필요한 것 -->
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>리스트</h1>
<%--  <%
	//게시글을 담을 인스턴스
	   BoardDAO boardDAO = new BoardDAO();
	//list 생성 그 값은 현재의 페이지에서 가져온 리스트 게시글목록
	  List<BoardVO> boardList = boardDAO.listBoard();
	
	   //가져온 목록을 하나씩 출력하도록 선언한다..
	for(int i = 0; i < boardList.size(); i++){
	%>
	<span><%=boardList.get(i).getName() %>: </span>
	<span>[<%=boardList.get(i).getTitle() %>]</span>
	<span><%=boardList.get(i).getContents() %></span><br>
	
	<% 
	}
%> --%>

<c:forEach var="boards" items="${boardsList }">
	<li>
		<a href="#"><strong>이름:${boards.name}</strong></a>
		<a href="#"><strong>제목:${boards.title}</strong></a>
		<a href="#"><strong>내용:${boards.contents}</strong></a>
	</li>
</c:forEach>
</body>
</html>