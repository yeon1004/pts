<<<<<<< HEAD
package image;

public class ImageDTO {
	private int iid;
	private int nid;
	private int wpid;
	private String filepath;
	private String filename;
	
	public int getIid() {
		return iid;
	}
	public void setIid(int iid) {
		this.iid = iid;
	}
	public int getNid() {
		return nid;
	}
	public void setNid(int nid) {
		this.nid = nid;
	}
	public int getWpid() {
		return wpid;
	}
	public void setWpid(int wpid) {
		this.wpid = wpid;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
}
=======
package image;

public class ImageDTO {
	private String iid;
	private String nid;
	private String wpid;
	private String filename;
	public String getIid() {
		return iid;
	}
	public void setIid(String iid) {
		this.iid = iid;
	}
	public String getNid() {
		return nid;
	}
	public void setNid(String nid) {
		this.nid = nid;
	}
	public String getWpid() {
		return wpid;
	}
	public void setWpid(String wpid) {
		this.wpid = wpid;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
}
>>>>>>> branch 'master' of https://github.com/yeon1004/pts
