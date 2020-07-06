package DB;

import java.sql.*;

public class DBTest {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		//String url = "jdbc:oracle:thin:@localhost:1521/xe";
		String url = "jdbc:mysql://localhost:3306/DB?useUnicode=true&characterEncoding=euc-kr";
		//String sql = "select * from member";
		String sql = "select * from location where id = 'tstw11'";
		
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url,"root","0000");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(sql);
		
		while (rs.next()) {
			String id = rs.getString("id");
			String la = rs.getString("la");
			String lo = rs.getString("lo");
			String store = rs.getString("store");
			System.out.printf("ID : %s, 위도 : %s, 경도 : %s, 가게 : %s\n",id,la,lo,store);
		}

		rs.close();
		st.close();
		con.close();
	}
}