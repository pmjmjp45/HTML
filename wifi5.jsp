<%@ page contentType="text/html; charset=UTF-8" %>
<%--JSP 파일에서 한글 인코딩 위해 꼭 있어야 함--%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%--필요한 자바의 기능을 임포트--%>
<HTML>
<HEAD>
<STYLE>
    /*테이블 스타일
        너비 1000픽셀
        이중 테두리 x
        실선, 1픽셀 테두리*/
    table{
        width: 1000px;
        border-collapse: collapse;
    }
    table td{
        border: solid 1px;
    }
    div {
        width: 1000px;
        text-align: center;
    }
    /*div(페이지 선택) 스타일
        너비 1000픽셀
        가운데 정렬*/
</STYLE>
</HEAD>
<BODY>
    <h1>무료 와이파이</h1>
    <%
        
        String from2 = request.getParameter("from"); // from인자 문자열에 저장
        String cnt2 = request.getParameter("cnt"); // cnt인자 문자열에 저장
        Integer fromPT = 0; // 최초 실행시 값 없으므로 초기값 설정
        Integer cntPT = 10; // 최초 실행시 값 없으므로 초기값 설정
 
        if (cnt2 != null) { 
            cntPT = Integer.parseInt(cnt2); // 정수화
        }
        if (from2 != null) {  
            fromPT = Integer.parseInt(from2); // 정수화
        }

        //if (fromPT / cntPT < 1) { // from값을 cnt보다 작은 값을 줄 경우 앞 페이지가 짤리는 현상 방지
        //    fromPT = fromPT / cntPT;
        //}

        File f = new File("/var/lib/tomcat9/webapps/전국무료와이파이표준데이터_번호날짜추가1.txt");
        // 파일 가져옴
        BufferedReader br = new BufferedReader(new FileReader(f));
        // 파일 읽기
        String readtxt; // 저장하기 위한 문자열

        if ((readtxt = br.readLine()) == null) {// 한 줄 읽기
            out.println("빈 파일입니다");
        } 

        String[] field_name = readtxt.split("\t");// 맨 윗줄은 칼럼명이므로 배열에 저장

        out.println("<table><tr><td>" + field_name[15] + "</td>"); // 테이블 만들어서 한 줄 추가하고 셀 쌓기, 번호
        out.println("<td>" + field_name[8] + "</td>"); // 소재지도로명주소
        out.println("<td>" + field_name[9] + "</td>"); // 소재지지번주소
        out.println("<td>" + field_name[12] + "</td>"); // 위도
        out.println("<td>" + field_name[13] + "</td>"); // 경도
        out.println("<td>거리</td></tr>");  // 거리

        double lat = 37.3806521; // kopo의 위도
        double lng = 127.1214038; // kopo의 경도
        ArrayList<String> line = new ArrayList<>(); // 개수를 세기 위한 어레이리스트

        while ((readtxt = br.readLine()) != null) { // 더 이상 읽을게 없을 때까지 한 줄씩 읽는다
            line.add(readtxt); // 어레이리스트에 저장
        }  
        br.close(); // BufferedReader 닫기
       
       //////////////////////////출력 부분
        if (fromPT < 0) fromPT = 0; // fromPT가 0보다 작은 경우 첫페이지 나오게
        else if (fromPT >= line.size()) fromPT = line.size() - 1;
        //(line.size() % cntPT); // fromPT가 데이터총량보다 클 경우 마지막페이지 나오게
        if (cntPT <= 0) cntPT = 1; // cntPT가 0보다 작은 경우 페이지당 1개씩 데이터 출력
        else if (cntPT > 10000) cntPT = 10000; // 최대 페이지당 출력 10000개
       
        for (int i = fromPT; i < (fromPT + cntPT); i++) { //from부터 cnt개 출력하도록 함

            if(i >= line.size()) break; // 마지막 번호 끝나고 탈출해야 indexOutOfBounds 예외에 안 걸림

            String[] field = line.get(i).split("\t");// 탭 기준으로 한 줄을 칼럼 별로 나눠서 배열에 저장

            out.println("<tr><td>" + field[15] + "</td>"); // 테이블에 한 줄 추가하고 셀 쌓기, 번호
            out.println("<td>" + field[8] + "</td>"); // 소재지도로명주소
            out.println("<td>" + field[9] + "</td>"); // 소재지지번주소
            out.println("<td>" + field[12] + "</td>"); // 위도
            out.println("<td>" + field[13] + "</td>"); // 경도

            double distance = Math.sqrt(Math.pow(Double.parseDouble(field[12]) - lat, 2)
                                + Math. pow(Double.parseDouble(field[13]) - lng, 2));
            // 거리는 피타고라스의 정리로 구함
            out.println("<td>" + distance + "</td></tr>"); // 거리
            
        }
        out.println("</table>"); // 테이블 닫기
    %>  

    <div> <!--페이지 선택 부분-->
    <%  
        int pageNum = 10; // 한 번에 출력하는 페이지수
        int totalPage = line.size() / cntPT; // 총 페이지수
            if (line.size() % cntPT != 0) totalPage++; // 총 페이지가 딱 떨어지지 않으면 1페이지 추가해야 함
        int currentPage = (fromPT / cntPT) + 1; // 현재 페이지
            if (fromPT % cntPT == 0) currentPage--; // 개수 딱 떨어질때는 +1 하지 않는다
            //if(currentPage * cntPT < fromPT + cntPT) currentPage++; 
        int tenPage = currentPage / pageNum; // 페이지의 10의 자리
        
        

        if (currentPage >= 10) { //11페이지 이상일 때만 << 있음
            out.println("<a href='wifi5.jsp?from=" + 0 + "&cnt=" + cntPT + "'>&lt;&lt;</a>"); // <<
            out.println("<a href='wifi5.jsp?from=" + ((tenPage * cntPT * pageNum) - cntPT) + "&cnt=" + cntPT + "'>&lt;</a>"); // <
            //이전 페이지의 가장 큰 값 나오게 함
        }
        for (int i = 0; i < 10; i++) { // 한 화면에 10페이지씩 출력
            if ((tenPage * 10) + i >= totalPage) break; // 마지막 값 이후로는 페이지 생성되지 않도록 하는 탈출 조건
            if ((tenPage * 10) + i == currentPage) { // 현재 페이지 폰트 크기 키움
                out.println("<a href='wifi5.jsp?from=" + ((tenPage * 10 + i) * cntPT) + "&cnt=" + cntPT + "' style='font-size: 2em;'>" + ((tenPage * 10) + i + 1) + "</a>");
            } else {
                out.println("<a href='wifi5.jsp?from=" + ((tenPage * 10 + i) * cntPT) + "&cnt=" + cntPT + "'>" + ((tenPage * 10) + i + 1) + "</a>");
            // from에 현재의 페이지값 기준으로 값을 쏴줌
            }
        }
        if (tenPage < (line.size() / cntPT / 10)) { // 마지막 10배수 아닐 때만 >> 있음
            out.println("<a href='wifi5.jsp?from=" + ((tenPage + 1) * 10 * cntPT) + "&cnt=" + cntPT + "'>&gt;</a>"); // >
            // from에 현재의 페이지값 기준으로 값을 쏴줌
            out.println("<a href='wifi5.jsp?from=" + (line.size() - (line.size() % cntPT)) + "&cnt=" + cntPT + "'>&gt;&gt;</a>"); // >>
        }
        out.println("텐페이지 : " + tenPage);
        out.println("현재페이지 : " + currentPage);
    %>
    </div>

</BODY>
</HTML>