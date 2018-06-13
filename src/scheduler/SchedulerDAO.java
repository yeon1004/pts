package scheduler;

import DBConnection.*;

public class SchedulerDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public SchedulerDAO() {
		dbconnect = new DBConnect();
	}
}
