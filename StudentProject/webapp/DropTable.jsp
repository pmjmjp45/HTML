<%@ page contentType="text/html; charset=UTF-8" %>
<%--JSP 파일에서 한글 인코딩 위해 꼭 있어야 함--%>
<%@ page import="kr.ac.kopo14.dao2.*, kr.ac.kopo14.domain.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%--필요한 자바의 기능을 임포트--%>
<HTML>
<HEAD>
</HEAD>
<BODY>
    <h1>테이블 삭제</h1>
    <%
    	StudentItemDao studentItemDao = new StudentItemDaoImpl();
    	boolean drop = studentItemDao.dropTable();
 
    	if (drop == true) {
			out.println("<h2>테이블 삭제 성공</h2>"); //성공 출력문
		} else {
			out.println("<h2>테이블 삭제 실패</h2>"); //실패 출력문
		}
    %>
</BODY>
</HTML>