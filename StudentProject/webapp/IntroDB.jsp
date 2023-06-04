<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--JSP 파일에서 한글 인코딩 위해 꼭 있어야 함--%>
<%@ page import="kr.ac.kopo14.service.*" %>
<%@ page import="java.io.*, java.net.*" %>
<%--자바 클래스 임포트--%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        /*이미지 가운데 정렬 위해 블록으로 설정하고 마진 없앰*/
        body {
        	text-align: center;
        }
        img {
            display: block;
            margin: 0px auto;
        }
    </style>
</head>
<body>
	<h1 style="text-align: center;">JSP Data 실습</h1> <!--타이틀-->
    <img src="./성적2.jpg"> <!--서버에 저장된 이미지 가져옴-->
	
	<%
		StudentItemService studentItemService = new StudentItemServiceImpl();
		int cnt = studentItemService.getVisitCount();
		
		out.println("<br><br>현재 홈페이지 방문 조회수는 ["+ cnt +"]입니다<br>");
	%>
</body>
</html>