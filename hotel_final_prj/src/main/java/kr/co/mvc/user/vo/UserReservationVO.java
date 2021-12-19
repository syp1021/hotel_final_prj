package kr.co.mvc.user.vo;

import java.util.Date;

public class UserReservationVO {

	private int room_no, adult, child, price;
	private String res_no, id, chkin_date, chkout_date, add_req, 
				cc_agree, pi_agree, res_status, r_name, val_mm, val_yy,
				ename_lst, ename_fst, company, tel, card_no, email, main_img;
	private Date res_date;
	
	
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public int getAdult() {
		return adult;
	}
	public void setAdult(int adult) {
		this.adult = adult;
	}
	public int getChild() {
		return child;
	}
	public void setChild(int child) {
		this.child = child;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getRes_no() {
		return res_no;
	}
	public void setRes_no(String res_no) {
		this.res_no = res_no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getChkin_date() {
		return chkin_date;
	}
	public void setChkin_date(String chkin_date) {
		this.chkin_date = chkin_date;
	}
	public String getChkout_date() {
		return chkout_date;
	}
	public void setChkout_date(String chkout_date) {
		this.chkout_date = chkout_date;
	}
	public String getAdd_req() {
		return add_req;
	}
	public void setAdd_req(String add_req) {
		this.add_req = add_req;
	}
	public String getCc_agree() {
		return cc_agree;
	}
	public void setCc_agree(String cc_agree) {
		this.cc_agree = cc_agree;
	}
	public String getPi_agree() {
		return pi_agree;
	}
	public void setPi_agree(String pi_agree) {
		this.pi_agree = pi_agree;
	}
	public String getRes_status() {
		return res_status;
	}
	public void setRes_status(String res_status) {
		this.res_status = res_status;
	}
	public String getR_name() {
		return r_name;
	}
	public void setR_name(String r_name) {
		this.r_name = r_name;
	}
	public String getVal_mm() {
		return val_mm;
	}
	public void setVal_mm(String val_mm) {
		this.val_mm = val_mm;
	}
	public String getVal_yy() {
		return val_yy;
	}
	public void setVal_yy(String val_yy) {
		this.val_yy = val_yy;
	}
	public String getEname_lst() {
		return ename_lst;
	}
	public void setEname_lst(String ename_lst) {
		this.ename_lst = ename_lst;
	}
	public String getEname_fst() {
		return ename_fst;
	}
	public void setEname_fst(String ename_fst) {
		this.ename_fst = ename_fst;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getCard_no() {
		return card_no;
	}
	public void setCard_no(String card_no) {
		this.card_no = card_no;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMain_img() {
		return main_img;
	}
	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	public Date getRes_date() {
		return res_date;
	}
	public void setRes_date(Date res_date) {
		this.res_date = res_date;
	}
	@Override
	public String toString() {
		return "UserReservationVO [room_no=" + room_no + ", adult=" + adult + ", child=" + child + ", price=" + price
				+ ", res_no=" + res_no + ", id=" + id + ", chkin_date=" + chkin_date + ", chkout_date=" + chkout_date
				+ ", add_req=" + add_req + ", cc_agree=" + cc_agree + ", pi_agree=" + pi_agree + ", res_status="
				+ res_status + ", r_name=" + r_name + ", val_mm=" + val_mm + ", val_yy=" + val_yy + ", ename_lst="
				+ ename_lst + ", ename_fst=" + ename_fst + ", company=" + company + ", tel=" + tel + ", card_no="
				+ card_no + ", email=" + email + ", main_img=" + main_img + ", res_date=" + res_date + "]";
	}
	
	
	
}//class
