package member;



import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.ArrayList;



public class MemberDAO {



	private Connection conn;
	
	private PreparedStatement pstmt;

	public ResultSet rs;

	public MemberDAO() {

		try {

			String dbURL = "jdbc:mysql://namweb.iptime.org:8509/DB?useUnicode=true&characterEncoding=euc-kr";
			//String dbURL = "jdbc:mysql://localhost:8509/DB?useUnicode=true&characterEncoding=euc-kr";

			String dbID = "root";

			String dbPassword = "rus7wp850!@vkt";

			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {
			e.printStackTrace();
		}


	}
	

/*	public String memberName(String name) {

		String sql = "SELECT id FROM member where name = ?";
		
		try {

			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, name);

			rs = pstmt.executeQuery();

			while(rs.next()) {

				return rs.getString("id"); // id 반환

			}

		} catch (SQLException e) {

			e.printStackTrace();

		}
		return null;

	}	*/
	
	public ArrayList<Member> search(String memberName) {
		String sql = "SELECT * FROM member WHERE name LIKE ?";
		ArrayList<Member> memberList = new ArrayList<Member>(); 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + memberName + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Member member = new Member();
				member.setMemberName(rs.getString(2));
				member.setMemberId(rs.getString(1));
				member.setMemberPwd(rs.getString(3));
				member.setMemberAddress(rs.getString(4));
				member.setMemberAge(rs.getInt(5));
				member.setMemberSex(rs.getString(6));
				memberList.add(member);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberList;
	}
	
	public int register(Member member) {
		String SQL = "INSERT INTO member VALUES (?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, member.getMemberName());
			pstmt.setString(2, member.getMemberId());
			pstmt.setString(3, member.getMemberPwd());
			pstmt.setString(4, member.getMemberAddress());
			pstmt.setInt(5, member.getMemberAge());
			pstmt.setString(6, member.getMemberSex());
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류
	}
}