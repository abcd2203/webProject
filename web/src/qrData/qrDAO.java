package qrData;



import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.sql.SQLException;



public class qrDAO {



	private Connection conn;

	private ResultSet rs;

	public qrDAO() {

		try {

			String dbURL = "jdbc:mysql://localhost:3306/DB?useUnicode=true&characterEncoding=euc-kr";

			String dbID = "root";

			String dbPassword = "0000";

			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {

			e.printStackTrace();

		}

	}

	

	public int qrCheck(String id, String pwd) {

		String SQL = "SELECT location.id FROM member, location WHERE member.id = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if(rs.next()) {

				if(rs.getString(1).equals(pwd))

					return 1; // 아이디 맞음

				else

					return 0; // 아이디 틀림

			}

			return -1; // 아이디 없음

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return -2; // 데이터베이스 오류

	}

	
	public int qrDataJoin(qrDTO user) {

		String SQL = "INSERT INTO location(time,la,lo,store) VALUES (?, ?, ?, ?)";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, user.getTime());

			pstmt.setString(2, user.getla());

			pstmt.setString(3, user.getlo());

			pstmt.setString(4, user.getStore());

			return pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return -1; // 회원가입 실패

	}

}