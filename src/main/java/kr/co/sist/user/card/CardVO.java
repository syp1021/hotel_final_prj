package kr.co.sist.user.card;

public class CardVO {
	String card_no,	company, val_mm,	val_yy,	id,	res_no;
	
	public CardVO() {
	}	

	/**
	 * @param card_no
	 * @param company
	 * @param val_mm
	 * @param val_yy
	 * @param id
	 * @param res_no
	 */
	public CardVO(String card_no, String company, String val_mm, String val_yy, String id, String res_no) {
		super();
		this.card_no = card_no;
		this.company = company;
		this.val_mm = val_mm;
		this.val_yy = val_yy;
		this.id = id;
		this.res_no = res_no;
	}

	public String getCard_no() {
		return card_no;
	}

	public void setCard_no(String card_no) {
		this.card_no = card_no;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRes_no() {
		return res_no;
	}

	public void setRes_no(String res_no) {
		this.res_no = res_no;
	}

	@Override
	public String toString() {
		return "CardVO [card_no=" + card_no + "]";
	}
	
	
	
	

	
}//class
