package kr.co.sist.user.login;

import java.util.Date;

public class memberVO {
	private String id, email, pass,  ename_fst, ename_lst, kname, birth_year, tel, req_agree, opt_agree, m_status;
	private Date join_date, out_date;
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getEname_fst() {
		return ename_fst;
	}

	public void setEname_fst(String ename_fst) {
		this.ename_fst = ename_fst;
	}

	public String getEname_lst() {
		return ename_lst;
	}

	public void setEname_lst(String ename_lst) {
		this.ename_lst = ename_lst;
	}

	public String getKname() {
		return kname;
	}

	public void setKname(String kname) {
		this.kname = kname;
	}

	public String getBirth_year() {
		return birth_year;
	}

	public void setBirth_year(String birth_year) {
		this.birth_year = birth_year;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getReq_agree() {
		return req_agree;
	}

	public void setReq_agree(String req_agree) {
		this.req_agree = req_agree;
	}

	public String getOpt_agree() {
		return opt_agree;
	}

	public void setOpt_agree(String opt_agree) {
		this.opt_agree = opt_agree;
	}

	public String getM_status() {
		return m_status;
	}

	public void setM_status(String m_status) {
		this.m_status = m_status;
	}

	public Date getJoin_date() {
		return join_date;
	}

	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}

	public Date getOut_date() {
		return out_date;
	}

	public void setOut_date(Date out_date) {
		this.out_date = out_date;
	}

	@Override
	public String toString() {
		return "memberVO [id=" + id + ", email=" + email + ", pass=" + pass + ", ename_fst=" + ename_fst
				+ ", ename_lst=" + ename_lst + ", kname=" + kname + ", birth_year=" + birth_year + ", tel=" + tel
				+ ", req_agree=" + req_agree + ", opt_agree=" + opt_agree + ", m_status=" + m_status + ", join_date="
				+ join_date + ", out_date=" + out_date + "]";
	}

}
