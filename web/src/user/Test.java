package user;

import java.sql.Connection;
import java.sql.PreparedStatement;

import DB.DButil;

public class Test {	// 데이터 접근 객체
	
	public int join(String userID, String userPwd) {
		String SQL = "insert into member values (?,?)";
		try {
			Connection conn = DButil.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPwd);
			return pstmt.executeUpdate();	// insert구문 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
