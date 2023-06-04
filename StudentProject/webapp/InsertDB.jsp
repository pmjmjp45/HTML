<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--JSP 파일에서 한글 인코딩 위해 꼭 있어야 함--%>
<% request.setCharacterEncoding("utf-8");%>
<%--값을 받는 파일의 인코딩--%>
<%@ page import="kr.ac.kopo14.dao2.*, kr.ac.kopo14.domain.*" %>
<%--자바 클래스 임포트--%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        /*테이블 스타일
        너비, 이중테두리 방지, 테두리선, 정렬 방식*/
        table{
        width: 750px;
        border-collapse: collapse;
        }
        table th, td{
            border: solid 1px;
            text-align: center;
        }
    </style>
</head>
<body>
	<h1>성적 입력 추가</h1>
	<table>
	<%
		String nameInsert = request.getParameter("name"); // name에 저장된 인자를 저장
		int korInsert = Integer.parseInt(request.getParameter("kor")); // kor인자 저장
        int engInsert = Integer.parseInt(request.getParameter("eng")); // eng인자 저장
        int mathInsert = Integer.parseInt(request.getParameter("math")); // math인자 저장
        
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		
		StudentItem insertOne = studentItemDao.insertNewData(nameInsert, korInsert, engInsert, mathInsert);
		
		out.println("<tr><td>이름</td><td>" + insertOne.getName() + "</td></tr>");
		out.println("<tr><td>학번</td><td>" + insertOne.getStudentid() + "</td></tr>");
		out.println("<tr><td>국어</td><td>" + insertOne.getKor() + "</td></tr>");
		out.println("<tr><td>영어</td><td>" + insertOne.getEng() + "</td></tr>");
		out.println("<tr><td>수학</td><td>" + insertOne.getMat() + "</td></tr>");
	%>
    </table>
</body>
</html>