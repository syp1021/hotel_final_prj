package kr.co.mvc.admin.service;

import org.springframework.stereotype.Component;

/**
 * ���������̼� ���� Ŭ����
 * @author user
 */

@Component
public class PagenationService {
	
	private int pageScale;
	
	/** 
	 * pageScale setting
	 * @param pageScale
	 */
	public void setPageScale(int pageScale) {
		this.pageScale = pageScale;
	}//setPageScale
	
	/**
	 * ��ü ������ �� 
	 * @param totalCnt
	 * @return
	 */
	public int getTotalPage(int totalCnt) {
		int totalPage = 0;
		
		totalPage=(int) Math.ceil((double)totalCnt/pageScale);
		return totalPage;
	}//findTotalPage

	
	/**
	 * ���������� ���� üũ
	 * @return
	 */
	public int setCurrentpage(String currentPage) {
		int currentPage1 = 0;
		try {
			currentPage1 = Integer.parseInt(currentPage);
		}catch(NumberFormatException nfe) {
			currentPage1 = 1;
		}//end catch
		return currentPage1;
	}//setCurrentpage
	
	
	/**
	 * ������������ ���� ���۹�ȣ ���ϱ�
	 * @param currentPage
	 * @param pageScale
	 * @return
	 */
	public int getStartNum(int currentPage) {
		int startNum =0;
		startNum = currentPage*pageScale-pageScale+1;
		return startNum;
	}//getStartNum
 
	
	/**
	 * ����ȣ ���ϱ�
	 * @param startNum
	 * @param pageScale
	 * @return
	 */
	public int getEndNum(int startNum) {
		int endNum = startNum + pageScale-1;
		return endNum;
	}//getEndNum
	

}//class
