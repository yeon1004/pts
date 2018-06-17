package workplace;

import java.sql.*;
import DBConnection.*;

public class WorkplaceDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public WorkplaceDAO() {
		dbconnect = new DBConnect();
	}
	
	public boolean InsertWp(WorkplaceDTO dto) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		
		try {
			sql = "insert into workplace(wpname, wpnum, opentime, closetime) values(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getWpname());
			pstmt.setString(2, dto.getWpnum());
			pstmt.setDouble(3, dto.getOpentime());
			pstmt.setDouble(4, dto.getClosetime());
			pstmt.execute();
			
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			DBClose.close(con,pstmt);
		}

		return true;
	}
	
	public String getWpid(String wpname, String wpnum)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "select wpid from workplace where wpname=? and wpnum=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, wpname);
			pstmt.setString(2, wpnum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				return new Integer(rs.getInt(1)).toString();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			return "";
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		
		return "";
	}
	
	public boolean CheckWpid(String wpid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int id = Integer.parseInt(wpid);
		
		try {
			sql = "select * from workplace where wpid=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			DBClose.close(con,pstmt);
		}
		
		return false;
	}
	
	public double getOpenTime(String wpid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int id = Integer.parseInt(wpid);
		
		try {
			sql = "select opentime from workplace where wpid=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				return rs.getDouble(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(con,pstmt);
		}
		
		return 0;
	}
	
	public double getCloseTime(String wpid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int id = Integer.parseInt(wpid);
		
		try {
			sql = "select closetime from workplace where wpid=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				return rs.getDouble(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(con,pstmt);
		}
		
		return 0;
	}
}
