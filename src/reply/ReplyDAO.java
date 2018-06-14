package reply;

import DBConnection.*;

public class ReplyDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public ReplyDAO() {
		dbconnect = new DBConnect();
	}
}
