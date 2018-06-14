package workplace;

public class WorkplaceDTO {
	private String wpid;
	private String wpname;
	private String wpnum;
	private double opentime;
	private double closetime;
	public String getWpid() {
		return wpid;
	}
	public void setWpid(String wpid) {
		this.wpid = wpid;
	}
	public String getWpname() {
		return wpname;
	}
	public void setWpname(String wpname) {
		this.wpname = wpname;
	}
	public String getWpnum() {
		return wpnum;
	}
	public void setWpnum(String wpnum) {
		this.wpnum = wpnum;
	}
	public double getOpentime() {
		return opentime;
	}
	public void setOpentime(double opentime) {
		this.opentime = opentime;
	}
	public double getClosetime() {
		return closetime;
	}
	public void setClosetime(double closetime) {
		this.closetime = closetime;
	}
}
