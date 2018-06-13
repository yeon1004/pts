package scheduler;

public class SchedulerDTO {
	private int sid;
	private String sday;
	private String stime;
	private String etime;
	private String able;
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
	public void setSday(String sday) {
		this.sday = sday;
	}
	public String getStime() {
		return stime;
	}
	public void setStime(String stime) {
		this.stime = stime;
	}
	public String getEtime() {
		return etime;
	}
	public void setEtime(String etime) {
		this.etime = etime;
	}
	public String getAble() {
		return able;
	}
	public void setAble(String able) {
		this.able = able;
	}
	public int getWpid() {
		return wpid;
	}
	public void setWpid(int wpid) {
		this.wpid = wpid;
	}
}
