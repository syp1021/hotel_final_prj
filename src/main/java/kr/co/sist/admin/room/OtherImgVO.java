package kr.co.sist.admin.room;

/**
 * 객실 메인 이미지 외 기타 이미지를 저장할 VO
 * @author user
 */
public class OtherImgVO {
	
	private String imgSrc;
	private int imgNo, roomNo;

	public OtherImgVO() {
	}

	public OtherImgVO(String imgSrc, int imgNo, int roomNo) {
		this.imgSrc = imgSrc;
		this.imgNo = imgNo;
		this.roomNo = roomNo;
	}

	public String getImgSrc() {
		return imgSrc;
	}

	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}

	public int getImgNo() {
		return imgNo;
	}

	public void setImgNo(int imgNo) {
		this.imgNo = imgNo;
	}

	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}


}
