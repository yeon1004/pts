package users;

import java.sql.*;
import DBConnection.*;

public class UsersDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public UsersDAO() {
		dbconnect = new DBConnect();
	}
	
	public String Login(String uid, String upw) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String wpid = "";
		try {
			sql = "select wpid from users where uid=? and upw=password(?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setString(2, upw);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				wpid = rs.getString(1);
			}
			
		}catch(Exception e) {

		}finally {
			DBClose.close(con,pstmt,rs);
		}
		
		return wpid;
	}
	
	public String getWpname(String wpid) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "select wpname from workplace where wpid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(wpid));
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
	
	public void InsertNewUser(UsersDTO udto)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
			
		try {
			sql = "insert into users(uid, upw, uname, uphone, uaddr, ulevel, wpid) values(?, password(?), ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, udto.getUid());
			pstmt.setString(2, udto.getUpw());
			pstmt.setString(3, udto.getUname());
			pstmt.setString(4, udto.getUphone());
			pstmt.setString(5, udto.getUaddr());
			pstmt.setString(6, udto.getUlevel());
			pstmt.setInt(7, Integer.parseInt(udto.getWpid()));
			
			pstmt.execute();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(con,pstmt);
		}
	}
	
	public boolean IsManager(String uid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "select ulevel from users where uid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals("관리자"))
					return true;
			}
			
		}catch(Exception e) {

		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return false;
	}
	
	public String getUserName(String uid) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String uname="";
		try {
			sql = "select uname from users where uid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				uname = rs.getString(1);
			}
			
		}catch(Exception e) {

		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return uname;
	}
}
