<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--JSP 파일에서 한글 인코딩 위해 꼭 있어야 함--%>
<% request.setCharacterEncoding("utf-8");%>
<%--값을 받는 파일의 인코딩--%>
<%@ page import="kr.ac.kopo14.dao2.*, kr.ac.kopo14.domain.*" %>
<%@ page import="java.util.*" %>
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
        table .target{
            background-color: yellow;
        }
    </style>
</head>
<body>
	<h1>레코드 수정</h1>
    <table> <!--테이블 태그-->
       <tr> <!--한 줄 추가-->
           <th>이름</th> <!--테이블 헤더(굵은 글씨, 중앙 정렬)-->
           <th>학번</th>
           <th>국어</th>
           <th>영어</th>
           <th>수학</th>
       </tr>
	<%
		String name = request.getParameter("name"); // name에 저장된 인자를 저장
		int id = Integer.parseInt(request.getParameter("id")); // id에 저장된 인자를 저장
		int kor = Integer.parseInt(request.getParameter("kor")); // kor에 저장된 인자를 저장
		int eng = Integer.parseInt(request.getParameter("eng")); // eng에 저장된 인자를 저장
		int mat = Integer.parseInt(request.getParameter("math")); // mat에 저장된 인자를 저장
		
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		
		List<StudentItem> updateOne = studentItemDao.updateData(name, id, kor, eng, mat);
		
		for (int i = 0; i < updateOne.size(); i++) { 
		
	        if (updateOne.get(i).getStudentid() == id) { // 리절트셋에 값이 있다면
	            //출력(테이블 한 줄씩 추가)
	            out.println("<tr class='target'><td>" + updateOne.get(i).getName() + "</td>");
	            out.println("<td>" + updateOne.get(i).getStudentid() + "</td>");
	            out.println("<td>" + updateOne.get(i).getKor() + "</td>");
	            out.println("<td>" + updateOne.get(i).getEng() + "</td>");
	            out.println("<td>" + updateOne.get(i).getMat() + "</td></tr>");
	        } else {
	        	out.println("<tr><td>" + updateOne.get(i).getName() + "</td>");
	            out.println("<td>" + updateOne.get(i).getStudentid() + "</td>");
	            out.println("<td>" + updateOne.get(i).getKor() + "</td>");
	            out.println("<td>" + updateOne.get(i).getEng() + "</td>");
	            out.println("<td>" + updateOne.get(i).getMat() + "</td></tr>");
	        }
		}
	%>

</body>
</html>