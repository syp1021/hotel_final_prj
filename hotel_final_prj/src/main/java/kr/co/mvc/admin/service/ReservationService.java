package kr.co.mvc.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import kr.co.mvc.admin.dao.ReservationDAO;
import kr.co.mvc.admin.vo.ChkInDateVO;
import kr.co.mvc.admin.vo.ReservationSelectVO;
import kr.co.mvc.admin.vo.ReservationUpdateVO;


@Component
public class ReservationService {

	@Autowired
	private ReservationDAO resDAO;
	
	/**
	 * 예약 조회
	 * @param date 체크인일자 또는 현재일자
	 * @return 예약리스트
	 */
	public List<ReservationSelectVO> searchRes(ChkInDateVO date, int startNum, int endNum){
		List<ReservationSelectVO> resList = null;
		
		try {
			resList = resDAO.selectRes(date, startNum, endNum);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		
		return resList;
	}//searchRes

	/**
	 * 페이지네이션을 위한 전체 레코드 수 조회
	 * @param date
	 * @return
	 */
	public int selectAllResCnt(ChkInDateVO date){
		int allResCnt = 0;
		
		try {
			allResCnt = resDAO.selectAllResCnt(date); 
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		
		return allResCnt;
	}//selectAllResCnt
	
	/**
	 * 예약 삭제
	 * @param delResNum
	 * @return
	 */
	public int removeRes(String delResNum){
		int result = 0;
		
		try {
			result = resDAO.deleteRes(delResNum); 
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		
		return result;
	}//removeRes
	
	/**
	 * 1건 예약 조회
	 * @param resNum 예약번호
	 * @return
	 */
	public ReservationUpdateVO searchOneRes(String resNum){
		ReservationUpdateVO ruVO =null;
		
		try {
			ruVO = resDAO.selectRes(resNum); 
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		
		return ruVO;
	}//searchOneRes
	
	
	/**
	 * 예약변경시 사용가능한 객실리스트 조회
	 * @return
	 */
	public List<String> searchAvailableRoomList(){
		List<String> roomList =null;
		
		try {
			roomList = resDAO.selectAvailableRoomList(); 
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		
		return roomList;
	}//searchAvailableRoomList
	
	
	/**
	 * 예약변경 요청된 객실의 최대 수용인원 조회
	 * @param ruVO
	 * @return
	 */
	public int searchMaxGuest(ReservationUpdateVO ruVO) {
		int maxGuest = 0;
		
		try {
			maxGuest = resDAO.selectMaxGuest(ruVO); 
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		
		return maxGuest;
	}//searchMaxGuest
	
	/**
	 * 예약변경 요청된 일자와 중복예약일자 조회
	 * @param ruVO
	 * @return
	 */
	public List<String> searchStayDateList(ReservationUpdateVO ruVO) {
		List<String> list = null;
		
		ruVO.setChkInDate(ruVO.getInYear()+"."+ruVO.getInMonth()+"."+ruVO.getInDay());
		ruVO.setChkOutDate(ruVO.getOutYear()+"."+ruVO.getOutMonth()+"."+ruVO.getOutDay());
		
		try {
			list = resDAO.selectStayDateList(ruVO); 
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		
		return list;
	}//searchStayDateList
	
	
	/**
	 * 특정 예약 update
	 * @param ruVO
	 * @return
	 */
	public int changeRes(ReservationUpdateVO ruVO) {
		int result = 0;
		
		try {
			result = resDAO.updateRes(ruVO); 
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		
		return result;
	}//searchMaxGuest
}//class
