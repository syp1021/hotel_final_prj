package kr.co.sist.admin.room;

public class UploadImgVO {
	private String imgName, lastModified;
	private int imgLeng;
	
	public UploadImgVO() {
	}

	public UploadImgVO(String imgName, String lastModified, int imgLeng) {
		this.imgName = imgName;
		this.lastModified = lastModified;
		this.imgLeng = imgLeng;
	}

	public String getImgName() {
		return imgName;
	}

	public void setImgName(String imgName) {
		this.imgName = imgName;
	}

	public String getLastModified() {
		return lastModified;
	}

	public void setLastModified(String lastModified) {
		this.lastModified = lastModified;
	}

	public int getImgLeng() {
		return imgLeng;
	}

	public void setImgLeng(int length) {
		this.imgLeng = length;
	}
	
}
