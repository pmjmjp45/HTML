package kr.ac.kopo14.dao2;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo14.domain.StudentItem;

public interface StudentItemDao {

	boolean createTable() throws ClassNotFoundException, SQLException; 	
	boolean dropTable();
	StudentItem insertNewData(String name, int kor, int eng, int mat) throws ClassNotFoundException, SQLException;
	//StudentItem selectOne(int id) throws ClassNotFoundException, SQLException;
	List<StudentItem> selectAll() throws ClassNotFoundException, SQLException;
	int count() throws ClassNotFoundException, SQLException;
	boolean allData();
	StudentItem selectOne(String name) throws ClassNotFoundException, SQLException;
	StudentItem selectOne2(int id) throws ClassNotFoundException, SQLException;
	List<StudentItem> updateData(String name, int id, int kor, int eng, int mat) throws ClassNotFoundException, SQLException;
	List<StudentItem> deleteData(int id) throws ClassNotFoundException, SQLException;
	
}
