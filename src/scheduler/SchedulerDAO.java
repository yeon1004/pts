<<<<<<< HEAD
package scheduler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DBConnection.*;

public class SchedulerDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public SchedulerDAO() {
		dbconnect = new DBConnect();
	}
	
	public ArrayList<SchedulerDTO> getMemberList(int wpid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<SchedulerDTO> schList = new ArrayList<SchedulerDTO>();
		
		try {
			sql = "select sid, sday, stime, etime, able from scheduler where wpid = ? order by stime, sday";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, wpid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SchedulerDTO dto = new SchedulerDTO();
				dto.setSid(rs.getInt(1));
				dto.setSday(rs.getString(2));
				dto.setStime(rs.getFloat(3));
				dto.setEtime(rs.getFloat(4));
				dto.setAble(rs.getBoolean(5));
				schList.add(dto);
			}
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return schList;
	}
	
	public int getApplyId(int sid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "select aid from apply where sid=? and astatus='½ÂÀÎ'";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, sid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return -1;
	}
	
	public String getApplyUserName(int sid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "select users.uname from scheduler, apply, users where scheduler.sid=? and scheduler.sid = apply.sid and apply.uid=users.uid";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, sid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return "";
	}
}
=======
package scheduler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DBConnection.*;

public class SchedulerDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public SchedulerDAO() {
		dbconnect = new DBConnect();
	}
	
	public ArrayList<SchedulerDTO> getMemberList(int wpid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<SchedulerDTO> schList = new ArrayList<SchedulerDTO>();
		
		try {
			sql = "select sid, sday, stime, etime, able from scheduler where wpid = ? order by stime, sday";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, wpid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SchedulerDTO dto = new SchedulerDTO();
				dto.setSid(rs.getString(1));
				dto.setSday(rs.getString(2));
				dto.setStime(rs.getFloat(3));
				dto.setEtime(rs.getFloat(4));
				dto.setAble(rs.getBoolean(5));
				schList.add(dto);
			}
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return schList;
	}
	
	public int getApplyId(int sid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "select aid from apply where sid=? and astatus='½ÂÀÎ'";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, sid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return -1;
	}
	
	public String getApplyUserName(String sid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int id = Integer.parseInt(sid);
		try {
			sql = "select users.uname from scheduler, apply, users where scheduler.sid=? and scheduler.sid = apply.sid and apply.uid=users.uid";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return "";
	}
}
>>>>>>> branch 'master' of https://github.com/yeon1004/pts
