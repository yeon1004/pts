
package notice;

import DBConnection.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class NoticeDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public NoticeDAO() {
		dbconnect = new DBConnect();
	}
	
	public int count() {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		
		try {
			sql = "SELECT COUNT(*) FROM notice";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt=rs.getInt(1);
			}
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return cnt;
	}
	
	public String pasing(String data) {
		try {
			data = new String(data.getBytes("8859_1"), "UTF-8");
		}catch (Exception e){ }
		return data;
	}
	
	public ArrayList<NoticeDTO> getNoticeMemberList() {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		
		try {
			sql = "SELECT nid, ntitle, uid, ndate, nhit FROM notice ORDER BY nid DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNid(rs.getInt(1));
				dto.setNtitle(rs.getString(2));
				dto.setUid(rs.getString(3));
				dto.setNdate(rs.getString(4).substring(0,10));
				dto.setNhit(rs.getInt(5));
				noticeList.add(dto);
			}
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return noticeList;
	}
	
	public int getMax() {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int max = 0;
		
		try {
			sql = "SELECT MAX(NUM) FROM notice";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				max=rs.getInt(1);
			}
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return max;
	}
	
	public boolean insertWrite(NoticeDTO dto) 
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		
		try {
			sql = "INSERT INTO notice(ntitle, ncont, uid) values (?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getNtitle());
			pstmt.setString(2, dto.getNcont());
			pstmt.setString(3, dto.getUid());
			pstmt.execute();
		
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			DBClose.close(con,pstmt);
		}
		return true;
	}
	
	public NoticeDTO getNoticeView(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeDTO dto = null;
		
		try {
			sql = "SELECT ntitle, ncont, uid, ndate, nhit FROM notice WHERE nid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new NoticeDTO();
				dto.setNtitle(rs.getString(1));
				dto.setNcont(rs.getString(2));
				dto.setUid(rs.getString(3));
				dto.setNdate(rs.getString(4));
				dto.setNhit(rs.getInt(5)+1);
			
			}
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return dto;
	}
	
	public void UpdateHit(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		
		try {
			sql = "UPDATE notice SET nhit=nhit+1 where nid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt);
		}
	}
	
	
	
}