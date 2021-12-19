package kr.co.mvc.admin.service;

import org.springframework.stereotype.Component;

/**
 * 페이지네이션 수행 클래스
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
	 * 전체 페이지 수 
	 * @param totalCnt
	 * @return
	 */
	public int getTotalPage(int totalCnt) {
		int totalPage = 0;
		
		totalPage=(int) Math.ceil((double)totalCnt/pageScale);
		return totalPage;
	}//findTotalPage

	
	/**
	 * 현재페이지 형식 체크
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
	 * 현재페이지에 따라 시작번호 구하기
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
	 * 끝번호 구하기
	 * @param startNum
	 * @param pageScale
	 * @return
	 */
	public int getEndNum(int startNum) {
		int endNum = startNum + pageScale-1;
		return endNum;
	}//getEndNum
	

}//class
