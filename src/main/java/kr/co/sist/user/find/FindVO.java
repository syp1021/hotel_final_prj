package kr.co.sist.user.find;

public class FindVO {

	public String id, kname, email, pass;

	public FindVO() {

	}

	public FindVO(String id, String kname, String email, String pass) {
		this.id = id;
		this.kname = kname;
		this.email = email;
		this.pass = pass;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getKname() {
		return kname;
	}

	public void setKname(String kname) {
		this.kname = kname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	@Override
	public String toString() {
		return "FindVO [id=" + id + ", kname=" + kname + ", email=" + email + ", pass=" + pass + "]";
	}
	
	
	
}
