package DBConnection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
	public DBConnect(){};
	
	public Connection getConnection() {
		Connection conn = null;
		
		String jdbc_driver = "com.mysql.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://220.66.67.246:3306/web04";
		String id = "web04";
		String pw = "mis5312!";
		
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
}