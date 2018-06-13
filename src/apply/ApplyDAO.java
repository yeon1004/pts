package apply;

import DBConnection.*;

public class ApplyDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public ApplyDAO() {
		dbconnect = new DBConnect();
	}
}
