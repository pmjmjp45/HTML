<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--JSP 파일에서 한글 인코딩 위해 꼭 있어야 함--%>
<%@ page import="kr.ac.kopo14.dao2.*, kr.ac.kopo14.domain.*" %>
<%--자바 클래스 임포트--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>데이터 입력</h1>
	<%
		
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		
		boolean allSetData = studentItemDao.allData();
		
		if (allSetData == true) {
			out.println("<h2>1000명 데이터 입력 성공</h2>"); //성공 출력문
		} else {
			out.println("<h2>데이터 입력 실패</h2>"); //실패 출력문
		}
		
	%>
</body>
</html>