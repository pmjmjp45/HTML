package kr.ac.kopo14.service;

import java.sql.SQLException;

import kr.ac.kopo14.dao2.StudentItemDao;
import kr.ac.kopo14.dto.Pagination;

public interface StudentItemService {
	StudentItemDao getStudentItemDao();
	void setStudentItemDao(StudentItemDao studentItemDao);
	
	Pagination getPagination(int page, int countPerPage) throws ClassNotFoundException, SQLException;
	int getVisitCount() throws ClassNotFoundException, SQLException;
}
