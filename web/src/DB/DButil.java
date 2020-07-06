package DB;

import java.sql.*;

public class DButil {

	public static Connection getConnection() {
		try {
			
			//String url = "jdbc:oracle:thin:@localhost:1521/xe";
			String url = "jdbc:mysql://localhost:3306/DB";
			//String sql = "select * from member";
			//String dbID = "Test";
			String dbID = "root";
			String dbPWD = "0000";
			//Class.forName("oracle.jdbc.driver.OracleDriver");
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(url,dbID,dbPWD);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}