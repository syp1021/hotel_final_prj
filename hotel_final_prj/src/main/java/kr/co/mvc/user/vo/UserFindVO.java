package kr.co.mvc.user.vo;

public class UserFindVO {

	String id_kname, id_email, pw_id, pw_kname, pw_email, temp_pw;

	public String getId_kname() {
		return id_kname;
	}

	public void setId_kname(String id_kname) {
		this.id_kname = id_kname;
	}

	public String getId_email() {
		return id_email;
	}

	public void setId_email(String id_email) {
		this.id_email = id_email;
	}

	public String getPw_id() {
		return pw_id;
	}

	public void setPw_id(String pw_id) {
		this.pw_id = pw_id;
	}

	public String getPw_kname() {
		return pw_kname;
	}

	public void setPw_kname(String pw_kname) {
		this.pw_kname = pw_kname;
	}

	public String getPw_email() {
		return pw_email;
	}

	public void setPw_email(String pw_email) {
		this.pw_email = pw_email;
	}

	public String getTemp_pw() {
		return temp_pw;
	}

	public void setTemp_pw(String temp_pw) {
		this.temp_pw = temp_pw;
	}

}//class
