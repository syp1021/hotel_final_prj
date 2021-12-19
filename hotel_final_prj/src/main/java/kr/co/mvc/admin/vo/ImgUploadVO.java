package kr.co.mvc.admin.vo;


public class ImgUploadVO {
	private String imgName, lastModified;
	private int imgLength;
	
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
	public int getImgLength() {
		return imgLength;
	}
	public void setImgLength(int imgLength) {
		this.imgLength = imgLength;
	}
	
	
}
