package member;



import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.sql.SQLException;



public class memberDAO {



	private Connection con;

	public ResultSet rs;

	public memberDAO() {

		try {

			String dbURL = "jdbc:mysql://localhost:3306/DB?useUnicode=true&characterEncoding=euc-kr";

			String dbID = "root";

			String dbPassword = "0000";

			Class.forName("com.mysql.jdbc.Driver");

			con = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {
			e.printStackTrace();
		}


	}
	

	public String memberName(String name) {

		String sql = "SELECT id FROM member where name = ?";
		
		try {

			PreparedStatement pstmt = con.prepareStatement(sql);

			pstmt.setString(1, name);

			rs = pstmt.executeQuery();

			while(rs.next()) {

				return rs.getString("id"); // id ¹ÝÈ¯

			}

		} catch (SQLException e) {

			e.printStackTrace();

		}
		return null;

	}
}