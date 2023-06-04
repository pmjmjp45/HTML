<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--JSP 파일에서 한글 인코딩 위해 꼭 있어야 함--%>
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
		String data;
		int cnt = 0;
		
		FileReader F = new FileReader("C:\\Users\\kopo14\\[web]eclipse-workspace for web\\StudentProject\\src\\main\\webapp\\cnt.txt");
		StringBuffer sb = new StringBuffer();
		int ch = 0;
		
		while ((ch = F.read()) != -1) { // 한 글자씩 읽음, null이면 -1 반환
			sb.append((char)ch); // 버퍼에 저장
		}
		
		data = sb.toString().trim().replace("\n",""); // 버퍼에 저장된 숫자를 문자열로 data에 저장
		F.close();
		
		if (data == "") { //빈 문서일 경우
			cnt = 0;
		} else {
			cnt = Integer.parseInt(data); // 저장된 문자열을 정수로 변환
		}
		cnt++; // 방문자 카운터 1 증가
		
		data = Integer.toString(cnt); // 증가한 카운터를 다시 데이터에 저장
		
		out.println("<br><br>현재 홈페이지 방문 조회수는 ["+ data +"]입니다<br>");
		
		FileWriter FW = new FileWriter("C:\\Users\\kopo14\\[web]eclipse-workspace for web\\StudentProject\\src\\main\\webapp\\cnt.txt", false);
		//,false하면 파일이 있을 경우 덮어쓰기됨
		FW.write(data); //데이터 입력
		FW.close();
	%>
</body>
</html>