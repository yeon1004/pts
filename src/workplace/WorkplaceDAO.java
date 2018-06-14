package workplace;

import DBConnection.*;

public class WorkplaceDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public WorkplaceDAO() {
		dbconnect = new DBConnect();
	}
}
