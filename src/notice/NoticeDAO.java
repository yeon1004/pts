package notice;

import DBConnection.*;

public class NoticeDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public NoticeDAO() {
		dbconnect = new DBConnect();
	}
}
