package scheduler;

import java.sql.*;
import java.util.*;
import java.util.Date;

import DBConnection.*;

public class SchedulerDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public SchedulerDAO() {
		dbconnect = new DBConnect();
	}
	
	public ArrayList<SchedulerDTO> getMemberList(String wpid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<SchedulerDTO> schList = new ArrayList<SchedulerDTO>();
		
		try {
			sql = "select sid, sday, stime, etime from scheduler where wpid = ? order by stime, sday";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(wpid));
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SchedulerDTO dto = new SchedulerDTO();
				dto.setSid(rs.getString(1));
				dto.setSday(rs.getString(2));
				dto.setStime(rs.getDouble(3));
				dto.setEtime(rs.getDouble(4));
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
			sql = "select aid from apply where sid=? and astatus='승인";
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
	
	public void InsertNewSchedule(SchedulerDTO sdto)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
			
		try {
			sql = "insert into scheduler(sday, stime, etime, wpid) values(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			
			//pstmt.setString(1, udto.getUid());
			pstmt.setString(1, sdto.getSday());
			pstmt.setDouble(2, sdto.getStime());
			pstmt.setDouble(3, sdto.getEtime());
			pstmt.setInt(4, Integer.parseInt(sdto.getWpid()));
			
			pstmt.execute();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(con,pstmt);
		}
	}
	
	public Date GetFirstDayOfWeek(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.set(2018, date.getMonth(), date.getDate());
		int day = date.getDay();
		cal.add(Calendar.DATE, day*-1);
		return cal.getTime();
	}
	
	public Date GetLastDayOfWeek(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.set(2018, date.getMonth(), date.getDate());
		int day = date.getDay();
		cal.add(Calendar.DATE, 6-day);
		return cal.getTime();
	}
	
	public Date GetDayAfter(Date date, int num) {
		Calendar cal = Calendar.getInstance();
		cal.set(2018, date.getMonth(), date.getDate());
		cal.add(Calendar.DATE, num);
		return cal.getTime();
	}
	
	public boolean CheckSchedule(SchedulerDTO sdto)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<SchedulerDTO> schList = new ArrayList<SchedulerDTO>();
		
		try {
			sql = "select sid, sday, stime, etime from scheduler where wpid = ? and sday = ? order by stime";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(sdto.getWpid()));
			pstmt.setString(2, sdto.getSday());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Double stime = rs.getDouble(3);
				Double etime = rs.getDouble(4);
				
				if(sdto.getStime() < stime) {
					if(sdto.getEtime() > stime) return false;
				}
				else if(sdto.getStime() < etime){
					return false;
				}
			}
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return true;
	}
}