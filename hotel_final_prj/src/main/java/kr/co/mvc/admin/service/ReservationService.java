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
	 * ���� ��ȸ
	 * @param date üũ������ �Ǵ� ��������
	 * @return ���ฮ��Ʈ
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
	 * ���������̼��� ���� ��ü ���ڵ� �� ��ȸ
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
	 * ���� ����
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
	 * 1�� ���� ��ȸ
	 * @param resNum �����ȣ
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
	 * ���ຯ��� ��밡���� ���Ǹ���Ʈ ��ȸ
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
	 * ���ຯ�� ��û�� ������ �ִ� �����ο� ��ȸ
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
	 * ���ຯ�� ��û�� ���ڿ� �ߺ��������� ��ȸ
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
	 * Ư�� ���� update
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
