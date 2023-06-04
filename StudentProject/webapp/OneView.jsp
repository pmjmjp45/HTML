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
	<%
		String name2 = request.getParameter("name"); // name에 저장된 인자를 저장
		out.println("<h1>[" + name2 + "]테이블 조회</h1>");
	%>

	 <table> <!--테이블 태그-->
        <tr> <!--한 줄 추가-->
            <th>이름</th> <!--테이블 헤더(굵은 글씨, 중앙 정렬)-->
            <th>학번</th>
            <th>국어</th>
            <th>영어</th>
            <th>수학</th>
            <th>총점</th>
            <th>평균</th>
            <th>등수</th>
        </tr>
	<%
		
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		
		StudentItem oneView = studentItemDao.selectOne(name2);
		
		out.println("<tr><td>" + oneView.getName() + "</td>");
		out.println("<td>" + oneView.getStudentid() + "</td>");
		out.println("<td>" + oneView.getKor() + "</td>");
		out.println("<td>" + oneView.getEng() + "</td>");
		out.println("<td>" + oneView.getMat() + "</td>");
		out.println("<td>" + oneView.getTotal() + "</td>");
		out.println("<td>" + oneView.getAvg() + "</td>");
		out.println("<td>" + oneView.getRanking() + "</td></tr>");
	
	%>
	</table>
</body>
</html>