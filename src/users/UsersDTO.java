package users;

public class UsersDTO {
	private String uid;
	private String upw;
	private String uname;
	private String uphone;
	private String uaddr;
	private String ulevel;
	private String wpid;
	
	public UsersDTO()
	{
		uphone = "";
		uaddr = "";
	}
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUpw() {
		return upw;
	}
	public void setUpw(String upw) {
		this.upw = upw;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUphone() {
		return uphone;
	}
	public void setUphone(String uphone) {
		this.uphone = uphone;
	}
	public String getUaddr() {
		return uaddr;
	}
	public void setUaddr(String uaddr) {
		this.uaddr = uaddr;
	}
	public String getUlevel() {
		return ulevel;
	}
	public void setUlevel(String ulevel) {
		this.ulevel = ulevel;
	}
	public String getWpid() {
		return wpid;
	}
	public void setWpid(String wpid) {
		this.wpid = wpid;
	}
}
