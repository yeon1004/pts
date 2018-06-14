package scheduler;

public class SchedulerDTO {
	private int sid;
	private String sday;
	private double stime;
	private double etime;
	private boolean able;
	private int wpid;
	
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public String getSday() {
		return sday;
	}
	public void setSday(String string) {
		this.sday = string;
	}
	public double getStime() {
		return stime;
	}
	public void setStime(double stime) {
		this.stime = stime;
	}
	public double getEtime() {
		return etime;
	}
	public void setEtime(double etime) {
		this.etime = etime;
	}
	public boolean getAble() {
		return able;
	}
	public void setAble(boolean able) {
		this.able = able;
	}
	public int getWpid() {
		return wpid;
	}
	public void setWpid(int wpid) {
		this.wpid = wpid;
	}
}
