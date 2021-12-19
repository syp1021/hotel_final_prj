package kr.co.mvc.user.vo;

public class searchRoomVO {

	private int room_no, max_guest, price;
	private String r_name, description, main_img;
	
	
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public int getMax_guest() {
		return max_guest;
	}
	public void setMax_guest(int max_guest) {
		this.max_guest = max_guest;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getR_name() {
		return r_name;
	}
	public void setR_name(String r_name) {
		this.r_name = r_name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getMain_img() {
		return main_img;
	}
	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	
	
	
}
