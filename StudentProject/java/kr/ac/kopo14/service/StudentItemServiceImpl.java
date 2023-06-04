package kr.ac.kopo14.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import kr.ac.kopo14.dao2.StudentItemDao;
import kr.ac.kopo14.dao2.StudentItemDaoImpl;
import kr.ac.kopo14.dto.Pagination;

public class StudentItemServiceImpl implements StudentItemService {

	private StudentItemDao studentItemDao = new StudentItemDaoImpl();
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	@Override
	public StudentItemDao getStudentItemDao() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setStudentItemDao(StudentItemDao studentItemDao) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Pagination getPagination(int page, int countPerPage) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		//studentItemDao.selectAll(page, countPerPage);
		Pagination pagination = new Pagination();
		
		int totalCount = studentItemDao.count();
		
		int totalPage = totalCount / countPerPage;
			if (totalCount % countPerPage != 0) {
				totalPage += 1;
			}
		
		int cPage = page;
			if (cPage <= 0) {
				cPage = 1;
			} else if (cPage > totalPage) {
				cPage = totalPage; 
			}
		
		int startPage = ((page - 1) / 10) * 10 + 1;
		
		int endPage = startPage + 9;
			if (endPage > totalPage) {
				endPage = totalPage;
			}
		
		int nPage = endPage + 1;
			if (nPage > totalPage) {
				nPage = -1;
			}
		
		int nnPage = totalPage;
			
		int pPage = startPage - 10;
			if (pPage < 1) {
				pPage = -1;
			}
		
		int ppPage = 1;
			if (cPage <= 10) {
				ppPage = -1;
			}
		
		pagination.setC(cPage);
		pagination.setS(startPage);
		pagination.setE(endPage);
		pagination.setN(nPage);
		pagination.setNn(nnPage);
		pagination.setP(pPage);
		pagination.setPp(ppPage);
		pagination.setTotalCount(totalCount);
		pagination.setTotalPage(totalPage);
		
		return pagination;
	}

	@Override
	public int getVisitCount() throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.cj.jdbc.Driver"); //jdbc 드라이버 로딩
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.63:33060/kopo14", "root", "0405");
        //데이터베이스와 연결
        Statement stmt = conn.createStatement(); // 스테이트먼트 객체 생성
        ResultSet rset = stmt.executeQuery("select * from exam_table_visit;"); //실행문 결과 리절트셋에 저장 
        
        int cnt = 0;
        while (rset.next()) {
        	cnt = rset.getInt(1) + 1;
        }
        
        stmt.execute("update exam_table_visit set cnt = " + cnt + ";");
        
        rset.close();
        stmt.close();
		conn.close();
		return cnt;
	}

}
