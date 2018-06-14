package pay;

import DBConnection.*;

public class PayDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public PayDAO() {
		dbconnect = new DBConnect();
	}
}
