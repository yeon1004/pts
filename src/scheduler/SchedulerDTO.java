package scheduler;

public class SchedulerDTO {
	private String sid;
	private String sday;
	private double stime;
	private double etime;
	private boolean able;
	private String wpid;
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getSday() {
		return sday;
	}
	public void setSday(String sday) {
		this.sday = sday;
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
	public boolean isAble() {
		return able;
	}
	public void setAble(boolean able) {
		this.able = able;
	}
	public String getWpid() {
		return wpid;
	}
	public void setWpid(String wpid) {
		this.wpid = wpid;
	}

}
