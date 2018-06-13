package users;

import java.sql.*;
import DBConnection.*;

public class UsersDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public UsersDAO() {
		dbconnect = new DBConnect();
	}
	
	public int Login(String uid, String upw) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int wpid = -1;
		try {
			sql = "select wpid from users where uid=? and upw=password(?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setString(2, upw);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				wpid = rs.getInt(1);
			}
			
		}catch(Exception e) {

		}finally {
			DBClose.close(con,pstmt,rs);
		}
		
		return wpid;
	}
	
	public String getWpname(int wpid) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "select wpname from workplace where wpid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, wpid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch(Exception e) {

		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return "";
	}
}
