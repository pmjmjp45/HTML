<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo14.dao2.*, kr.ac.kopo14.domain.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>테이블 생성</h1>
	<%
		
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		
		boolean create = studentItemDao.createTable();
		
		if (create == true) {
			out.println("<h2>테이블 생성 성공</h2>"); //성공 출력문
		} else {
			out.println("<h2>테이블 생성 실패</h2>"); //실패 출력문
		}
		
	%>
	

</body>
</html>