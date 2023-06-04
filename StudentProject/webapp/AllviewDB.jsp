<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--JSP 파일에서 한글 인코딩 위해 꼭 있어야 함--%>
<%@ page import="kr.ac.kopo14.dao2.*, kr.ac.kopo14.domain.*, kr.ac.kopo14.service.*, kr.ac.kopo14.dto.*" %>
<%--자바 클래스 임포트--%>
<%@ page import="java.util.*" %>
<%--필요한 자바의 기능을 임포트--%>
    
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
        div {
        	width: 750px;
        	text-align: center;
        }
    </style>
</head>
<body>
	<%
		StudentItemService studentItemService = new StudentItemServiceImpl();
		String page2 = request.getParameter("page");
		String cnt2 = request.getParameter("cnt");
		int currentPage = 1;
		int countPerPage = 10;
		if (page2 != null) {
			currentPage = Integer.parseInt(page2);
		}
		if (cnt2 != null) {
			countPerPage = Integer.parseInt(cnt2);
		}
		Pagination p = studentItemService.getPagination(currentPage, countPerPage);
	%>
	<h1>전체 테이블 조회</h1>
	 <table> <!--테이블 태그-->
	 	<tr>
	 		<td colspan="4" style="text-align:left; border:none;">
	 			현재페이지: <%=p.getC() %>
	 		</td>
	 		<td colspan="4" style="text-align:right; border:none;">
		 		<form method="get" action="AllviewDB.jsp" onchange="this.submit()">
		 			<label for="countPerPage">페이지 당 개수</label>
		 			<select id="countPerPage" name="cnt" size="1" >
		 				<option value="10" selected></option>
		 				<option value="10">10</option>
		 				<option value="30">30</option>
		 				<option value="50">50</option>
		 				<option value="100">100</option>
		 			</select>
		 		</form>
	 		</td>
	 	</tr>  
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
		List<StudentItem> allView = studentItemDao.selectAll();

		for (int i = ((currentPage - 1) * countPerPage); i < ((currentPage - 1) * countPerPage) + countPerPage; i++) { 
			if (i >= p.getTotalCount()) break;
			out.println("<tr><td><a href='./OneView.jsp?name=" + allView.get(i).getName() + "'>" +  allView.get(i).getName() + "</td>");
			out.println("<td>" + allView.get(i).getStudentid() + "</td>");
			out.println("<td>" + allView.get(i).getKor() + "</td>");
			out.println("<td>" + allView.get(i).getEng() + "</td>");
			out.println("<td>" + allView.get(i).getMat() + "</td>");
			out.println("<td>" + allView.get(i).getTotal() + "</td>");
			out.println("<td>" + allView.get(i).getAvg() + "</td>");
			out.println("<td>" + allView.get(i).getRanking() + "</td></tr>");
		}
	%>
	</table>
	<div>
	<%
		if (currentPage >= 10) {
			out.println("<a href='AllviewDB.jsp?page=" + p.getPp() + "&cnt=" + countPerPage + "'>&lt;&lt;</a>");
			out.println("<a href='AllviewDB.jsp?page=" + p.getP() + "&cnt=" + countPerPage + "'>&lt;</a>");
		}
	
		for (int i = p.getS(); i <= p.getE(); i++) {
			if (i > p.getTotalPage()) break;
			if (i == currentPage) {
				out.println("<a href='AllviewDB.jsp?page=" + p.getC() + "&cnt=" + countPerPage + "' style='font-size: 2em;'>" + p.getC() + "</a>");
			} else {
				out.println("<a href='AllviewDB.jsp?page=" + i + "&cnt=" + countPerPage + "'>" + i + "</a>");
			}
		}
		if (currentPage < ((p.getTotalPage() - 1) / 10) * 10 + 1) {
			out.println("<a href='AllviewDB.jsp?page=" + p.getN() + "&cnt=" + countPerPage + "'>&gt;</a>");
			out.println("<a href='AllviewDB.jsp?page=" + p.getNn() + "&cnt=" + countPerPage + "'>&gt;&gt;</a>");
		}
	%>
	</div>
</body>
</html>