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
        div {
        	display: flex;
        	justify-content: center;
        	margin: 10px;
       	}
    </style>
    <script type="text/javascript">
 
    function characterCheck(obj){
 		var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi; 

 			if( regExp.test(obj.value) ){
				obj.value = null;
  			}
    }
  </script>
</head>
<body>
	<h1>성적 조회 후 정정, 삭제</h1>
    <form method="get" action="ShowRec.jsp">
       조회할 학번: <input name="id" type="number" min="230000" maxlength="6" style="width:100px;"/>
       <input type="submit" value="조회"/>
    </form> 
	<%
		int id = Integer.parseInt(request.getParameter("id")); // name에 저장된 인자를 저장
		out.println("<h2>[" + id + "]의 데이터 조회</h2>");
		
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		
		StudentItem insertOne = studentItemDao.selectOne2(id);

        if (insertOne.getName() != null) { // 리절트셋에 값이 있다면
            //출력(테이블 한 줄씩 추가)
        	 out.println("<form method='get' name='form'>");
             out.println("<table>");
             out.println("<tr><td>이름</td><td><input name='name' type='text' onkeyup='characterCheck(this)' maxlength='10' required value='" + insertOne.getName() + "' style='text-align:center; width:100px;'/></td></tr>");
             out.println("<tr><td>학번</td><td><input name='id' type='text' value='" + insertOne.getStudentid() + "' style='text-align:center; font-weight: bold; width:100px;' readonly/></td></tr>");
             out.println("<tr><td>국어</td><td><input name='kor' type='number' min='1' max='100' required value='" + insertOne.getKor() + "'style='text-align:center; width:100px;' /></td></tr>");
             out.println("<tr><td>영어</td><td><input name='eng' type='number' min='1' max='100' required value='" + insertOne.getEng() + "'style='text-align:center; width:100px;'/></td></tr>");
             out.println("<tr><td>수학</td><td><input name='math' type='number' min='1' max='100' required value='" + insertOne.getMat() + "'style='text-align:center; width:100px;'/></td></tr>");
             out.println("</table>"); // 테이블 닫기

             out.println("<div><input type='submit' value='수정' onclick='form.action=\"UpdateDB.jsp\";' style='margin-right: 10px;'/>");
             out.println("<input type='submit' value='삭제' onclick='form.action=\"DeleteDB.jsp\"'/></div></form>");
            
        } else {//리절트셋에 값이 없다면(해당하는 id가 없다면)
            out.println("<h3>해당 사항 없음</h3>");
        }
	%>

</body>
</html>