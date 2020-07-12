package user;



import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.ArrayList;



public class UserDAO {



	private Connection conn;
	
	private PreparedStatement pstmt;

	private ResultSet rs;



	public UserDAO() {

		try {

			String dbURL = "jdbc:mysql://localhost:8509/DB?useUnicode=true&characterEncoding=euc-kr";

			String dbID = "root";

			String dbPassword = "rus7wp850!@vkt";

			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {

			e.printStackTrace();

		}

	}
	
	public ArrayList<User> search(String userName) {
		String SQL = "SELECT * FROM USER WHERE userName LIKE ?";
		ArrayList<User> userList = new ArrayList<User>(); 
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + userName + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserName(rs.getString(1));
				user.setUserAge(rs.getInt(2));
				user.setUserGender(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				userList.add(user);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userList;
	}

	

	public int login(String userID, String userPassword) {

		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, userID);

			rs = pstmt.executeQuery();

			if(rs.next()) {

				if(rs.getString(1).equals(userPassword))

					return 1; // �α��� ����

				else

					return 0; // ��й�ȣ Ʋ��

			}

			return -1; // ���̵� ����

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return -2; // �����ͺ��̽� ����

	}

	

	public int join(UserDTO user) {

		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, false)";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, user.getUserID());

			pstmt.setString(2, user.getUserPassword());

			pstmt.setString(3, user.getUserEmail());

			pstmt.setString(4, user.getUserEmailHash());

			return pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return -1; // ȸ������ ����

	}

	

	public String getUserEmail(String userID) {

		String SQL = "SELECT userEmail FROM USER WHERE userID = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, userID);

			rs = pstmt.executeQuery();

			while(rs.next()) {

				return rs.getString(1); // �̸��� �ּ� ��ȯ

			}

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return null; // �����ͺ��̽� ����

	}

	

	public boolean getUserEmailChecked(String userID) {

		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, userID);

			rs = pstmt.executeQuery();

			while(rs.next()) {

				return rs.getBoolean(1); // �̸��� ��� ���� ��ȯ

			}

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return false; // �����ͺ��̽� ����

	}

	

	public boolean setUserEmailChecked(String userID) {

		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, userID);

			pstmt.executeUpdate();

			return true; // �̸��� ��� ���� ����

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return false; // �̸��� ��� ���� ����

	}
	


}