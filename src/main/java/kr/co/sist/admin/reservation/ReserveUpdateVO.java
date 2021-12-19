package kr.co.sist.admin.reservation;

/**
 * 예약변경 시 사용할 VO
 * @author user
 */
public class ReserveUpdateVO {

	private String resNo, kName, chkInDate, chkOutDate,rName,addReq;
	private String inYear,inMonth,inDay,outYear,outMonth,outDay;
	private int adult, child;
	
	public ReserveUpdateVO() {
	}

	public ReserveUpdateVO(String resNo, String kName, String chkInDate, String chkOutDate, String rName, String addReq,
			String inYear, String inMonth, String inDay, String outYear, String outMonth, String outDay, int adult,
			int child) {
		super();
		this.resNo = resNo;
		this.kName = kName;
		this.chkInDate = chkInDate;
		this.chkOutDate = chkOutDate;
		this.rName = rName;
		this.addReq = addReq;
		this.inYear = inYear;
		this.inMonth = inMonth;
		this.inDay = inDay;
		this.outYear = outYear;
		this.outMonth = outMonth;
		this.outDay = outDay;
		this.adult = adult;
		this.child = child;
	}

	public String getResNo() {
		return resNo;
	}

	public void setResNo(String resNo) {
		this.resNo = resNo;
	}

	public String getkName() {
		return kName;
	}

	public void setkName(String kName) {
		this.kName = kName;
	}

	public String getChkInDate() {
		return chkInDate;
	}

	public void setChkInDate(String chkInDate) {
		this.chkInDate = chkInDate;
	}

	public String getChkOutDate() {
		return chkOutDate;
	}

	public void setChkOutDate(String chkOutDate) {
		this.chkOutDate = chkOutDate;
	}

	public String getrName() {
		return rName;
	}

	public void setrName(String rName) {
		this.rName = rName;
	}

	public String getAddReq() {
		return addReq;
	}

	public void setAddReq(String addReq) {
		this.addReq = addReq;
	}

	public String getInYear() {
		return inYear;
	}

	public void setInYear(String inYear) {
		this.inYear = inYear;
	}

	public String getInMonth() {
		return inMonth;
	}

	public void setInMonth(String inMonth) {
		this.inMonth = inMonth;
	}

	public String getInDay() {
		return inDay;
	}

	public void setInDay(String inDay) {
		this.inDay = inDay;
	}

	public String getOutYear() {
		return outYear;
	}

	public void setOutYear(String outYear) {
		this.outYear = outYear;
	}

	public String getOutMonth() {
		return outMonth;
	}

	public void setOutMonth(String outMonth) {
		this.outMonth = outMonth;
	}

	public String getOutDay() {
		return outDay;
	}

	public void setOutDay(String outDay) {
		this.outDay = outDay;
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


}//class
