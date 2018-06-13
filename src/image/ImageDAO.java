package image;

import DBConnection.*;

public class ImageDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public ImageDAO() {
		dbconnect = new DBConnect();
	}
}
