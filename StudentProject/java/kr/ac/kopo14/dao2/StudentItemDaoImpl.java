package kr.ac.kopo14.dao2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo14.domain.StudentItem;

public class StudentItemDaoImpl implements StudentItemDao {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean dropTable() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //jdbc 드라이버 로딩
	        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.63:33060/kopo14", "root", "0405");
	        //데이터베이스와 연결
	        Statement stmt = conn.createStatement(); // 스테이트먼트 객체 생성
			stmt.execute("drop table exam_table;");
	
			stmt.close();
			conn.close();
		} catch(Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public boolean createTable() throws ClassNotFoundException, SQLException {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //jdbc 드라이버 로딩
	        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.63:33060/kopo14", "root", "0405");
	        //데이터베이스와 연결
	        Statement stmt = conn.createStatement(); // 스테이트먼트 객체 생성
			stmt.execute("create table exam_table(id int not null primary key, name varchar(20), studentID int, kor int, eng int, mat int);");
	
			stmt.close();
			conn.close();
		} catch(Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public boolean allData() { // 1000명 데이터 입력
		// TODO Auto-generated method stub
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //jdbc 드라이버 로딩
	        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.63:33060/kopo14", "root", "0405");
	        //데이터베이스와 연결
	        Statement stmt = conn.createStatement(); // 스테이트먼트 객체 생성
	        
	        for (int i = 0; i < 1000; i++) {
	        	String name = "홍길동".concat(Integer.toString(i));
	        	int studentid = 230000 + i;
	        	
	        	stmt.execute("insert into exam_table (id, name, studentID, kor, eng, mat) values ("
	        			+ i + ", '" + name + "'," + studentid + ", rand() * 100, rand() * 100, rand() * 100);");
	        }
			stmt.close();
			conn.close();
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public StudentItem insertNewData(String name, int kor, int eng, int mat) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); //jdbc 드라이버 로딩
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.63:33060/kopo14", "root", "0405");
        //데이터베이스와 연결
        Statement stmt = conn.createStatement(); // 스테이트먼트 객체 생성
		stmt.execute("insert into exam_table (id, name, studentID, kor, eng, mat) select"
					+ " ifnull((select max(id) + 1 from exam_table),1), '"
					+ name 
					+ "', ifnull((select min(studentID + 1) from exam_table as a where not exists (select studentID from exam_table where studentID = (a.studentID + 1))), 230000), " 
					// 테이블에서 아이디+1이 존재하지 않는 아이디 중 최소값
					+ kor + ", " + eng + ", " + mat + ";");

        ResultSet rset = stmt.executeQuery("select * from exam_table where id = (select max(id) from exam_table);"); //실행문 결과 리절트셋에 저장 
        StudentItem insertNew = new StudentItem();
        while(rset.next()) {
        	insertNew.setName(rset.getString(2));
        	insertNew.setStudentid(rset.getInt(3));
        	insertNew.setKor(rset.getInt(4));
        	insertNew.setEng(rset.getInt(5));
        	insertNew.setMat(rset.getInt(6));
        }
        rset.close();
		stmt.close();
		conn.close();
		
		return insertNew;
	}

	@Override
	public StudentItem selectOne(String name) throws ClassNotFoundException, SQLException {
		StudentItem selectOne = new StudentItem();
		
		Class.forName("com.mysql.cj.jdbc.Driver"); //jdbc 드라이버 로딩
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.63:33060/kopo14", "root", "0405");
        //데이터베이스와 연결
        Statement stmt = conn.createStatement(); // 스테이트먼트 객체 생성
        ResultSet rset = stmt.executeQuery("select * , (kor + eng + mat) as total, (kor + eng + mat) / 3 as avg "
        		+ ", (select count(*) from exam_table where (kor + eng + mat) > total) + 1 from exam_table where name ='" + name + "';"); //실행문 결과 리절트셋에 저장 
        
        while(rset.next()) {
        	selectOne.setId(rset.getInt(1));
        	selectOne.setName(rset.getString(2));
        	selectOne.setStudentid(rset.getInt(3));
        	selectOne.setKor(rset.getInt(4));
        	selectOne.setEng(rset.getInt(5));
        	selectOne.setMat(rset.getInt(6));
        	selectOne.setTotal(rset.getInt(7));
        	selectOne.setAvg(rset.getInt(8));
        	selectOne.setRanking(rset.getInt(9));
        
        }
        
        stmt.close();
		conn.close();
		return selectOne;
	}

	@Override
	public StudentItem selectOne2(int id) throws ClassNotFoundException, SQLException {
		StudentItem selectOne = new StudentItem();
		
		Class.forName("com.mysql.cj.jdbc.Driver"); //jdbc 드라이버 로딩
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.63:33060/kopo14", "root", "0405");
        //데이터베이스와 연결
        Statement stmt = conn.createStatement(); // 스테이트먼트 객체 생성
        ResultSet rset = stmt.executeQuery("select * from exam_table where studentID =" + id + ";"); //실행문 결과 리절트셋에 저장 
        
        while(rset.next()) {
        	selectOne.setId(rset.getInt(1));
        	selectOne.setName(rset.getString(2));
        	selectOne.setStudentid(rset.getInt(3));
        	selectOne.setKor(rset.getInt(4));
        	selectOne.setEng(rset.getInt(5));
        	selectOne.setMat(rset.getInt(6));
        }
        
        stmt.close();
		conn.close();
		return selectOne;
	}

	@Override
	public List<StudentItem> selectAll() throws ClassNotFoundException, SQLException {

		List<StudentItem> listAll = new ArrayList<>();
		//List<StudentItem> selectAllList = new ArrayList<>();
		
		Class.forName("com.mysql.cj.jdbc.Driver"); //jdbc 드라이버 로딩
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.63:33060/kopo14", "root", "0405");
        //데이터베이스와 연결
        Statement stmt = conn.createStatement(); // 스테이트먼트 객체 생성
        ResultSet rset = stmt.executeQuery("select *, (kor + eng + mat) as total, (kor + eng + mat) / 3 as avg"
        		+ ", (select count(*) from exam_table where (kor + eng + mat) > total) + 1 as ranking from exam_table order by studentID asc;"); //실행문 결과 리절트셋에 저장 
        
        while(rset.next()) {
    		StudentItem selectall = new StudentItem();
    		selectall.setId(rset.getInt(1));
        	selectall.setName(rset.getString(2));
        	selectall.setStudentid(rset.getInt(3));
        	selectall.setKor(rset.getInt(4));
        	selectall.setEng(rset.getInt(5));
        	selectall.setMat(rset.getInt(6));
        	selectall.setTotal(rset.getInt(7));
        	selectall.setAvg(rset.getInt(8));
        	selectall.setRanking(rset.getInt(9));
        	listAll.add(selectall);
        }
        
        stmt.close();
		conn.close();
		return listAll;
	
	}

	@Override
	public List<StudentItem> updateData(String name, int id, int kor, int eng, int mat)
			throws ClassNotFoundException, SQLException {
		List<StudentItem> listAll = new ArrayList<>();

		Class.forName("com.mysql.cj.jdbc.Driver"); //jdbc 드라이버 로딩
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.63:33060/kopo14", "root", "0405");
        //데이터베이스와 연결
        Statement stmt = conn.createStatement(); // 스테이트먼트 객체 생성
        stmt.execute("update exam_table set name = '" + name + "' where studentID = " + id + ";");
        stmt.execute("update exam_table set kor = '" + kor + "' where studentID = " + id + ";");
        stmt.execute("update exam_table set eng = '" + eng + "' where studentID = " + id + ";");
        stmt.execute("update exam_table set mat = '" + mat + "' where studentID = " + id + ";");
        ResultSet rset = stmt.executeQuery("select * from exam_table order by studentID asc;"); //실행문 결과 리절트셋에 저장 
        
        while(rset.next()) {
    		StudentItem updateOne = new StudentItem();
    		
    		updateOne.setId(rset.getInt(1));
        	updateOne.setName(rset.getString(2));
        	updateOne.setStudentid(rset.getInt(3));
        	updateOne.setKor(rset.getInt(4));
        	updateOne.setEng(rset.getInt(5));
        	updateOne.setMat(rset.getInt(6));
        	listAll.add(updateOne);

        }
        rset.close();
        stmt.close();
		conn.close();
		return listAll;
	}

	@Override
	public List<StudentItem> deleteData(int id) throws ClassNotFoundException, SQLException {
		List<StudentItem> listAll = new ArrayList<>();

		Class.forName("com.mysql.cj.jdbc.Driver"); //jdbc 드라이버 로딩
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.63:33060/kopo14", "root", "0405");
        //데이터베이스와 연결
        Statement stmt = conn.createStatement(); // 스테이트먼트 객체 생성
        stmt.execute("delete from exam_table where studentID = " + id + ";");
        ResultSet rset = stmt.executeQuery("select * from exam_table order by studentID asc;"); //실행문 결과 리절트셋에 저장 
        
        while(rset.next()) {
    		StudentItem deleteOne = new StudentItem();
    		
    		deleteOne.setId(rset.getInt(1));
    		deleteOne.setName(rset.getString(2));
    		deleteOne.setStudentid(rset.getInt(3));
    		deleteOne.setKor(rset.getInt(4));
    		deleteOne.setEng(rset.getInt(5));
    		deleteOne.setMat(rset.getInt(6));
        	listAll.add(deleteOne);

        }
        rset.close();
        stmt.close();
		conn.close();
		return listAll;
	}

	@Override
	public int count() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver"); //jdbc 드라이버 로딩
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.63:33060/kopo14", "root", "0405");
        //데이터베이스와 연결
        Statement stmt = conn.createStatement(); // 스테이트먼트 객체 생성
        ResultSet rsetCount = stmt.executeQuery("select count(*) from exam_table;"); //실행문 결과 리절트셋에 저장 
       
        int cnt = 0;
        while(rsetCount.next()) {
        	cnt = rsetCount.getInt(1);
        }
        
        rsetCount.close();
        stmt.close();
		conn.close();
		return cnt;
	}

}
