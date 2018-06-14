package image;

import java.sql.*;
import DBConnection.*;

public class ImageDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public ImageDAO() {
		dbconnect = new DBConnect();
	}
	
	public boolean InsertImage(ImageDTO dto)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		
		try {
			sql = "insert into images(wpid, filename) values(?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getWpid());
			pstmt.setString(2, dto.getFilename());
			
			pstmt.execute();
			
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			DBClose.close(con,pstmt);
		}
		return true;
	}
}
