package kr.co.mvc.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import kr.co.mvc.admin.dao.RoomDAO;
import kr.co.mvc.admin.vo.ImgFormVO;
import kr.co.mvc.admin.vo.OtherImgVO;
import kr.co.mvc.admin.vo.RoomVO;

@Component
public class RoomService {

	@Autowired
	private RoomDAO roomDAO;
	
	/**
	 * 등록된 모든 룸 상세정보 조회
	 * @param rName
	 * @return
	 */
	public List<RoomVO> searchRoomInfo(String rName, String roomNum) {
		List<RoomVO> roomList = null;
		try {
			roomList = roomDAO.selectRoomInfo(rName, roomNum);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		
		return roomList;
	}//searchRoomInfo
	
	
	/**
	 * 특정객실의 기타이미지 조회
	 * @param rName
	 * @return
	 */
	public List<OtherImgVO> searchOtherImg(String rName, String roomNum) {
		List<OtherImgVO> imgList = null;
		
		try {
			imgList = roomDAO.selectOtherImg(rName, roomNum);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		
		return imgList;
	}//searchOtherImg
	
	
	/**
	 * 객실 추가 시, 가장 끝번호의 RoomNo를 조회하여 사용
	 * @return
	 */
	public int searchLastRoomNo(){
		int num=0;
		try {
			num = roomDAO.selectLastRoomNo();
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		return num;
	}//searchLastRoomNo
	
	
	/**
	 * 객실 추가
	 * @param rmVO
	 * @param lastRoomNo
	 * @param imgFrmVO
	 * @return
	 */
	public boolean addRoom(RoomVO rmVO, int lastRoomNo, ImgFormVO imgFrmVO) {
		boolean flag = false;
		try {
			flag = roomDAO.insertRoom(rmVO, lastRoomNo, imgFrmVO);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		return flag;
	}//addRoom 
	
	
	/**
	 * 기타이미지 존재 시, 이미지 추가
	 * @param rmVO
	 * @param imgFrmVO
	 * @return
	 */
	public boolean addOtherImg(RoomVO rmVO, ImgFormVO imgFrmVO) {
		boolean flag = false;
		try {
			flag = roomDAO.insertOtherImg(rmVO, imgFrmVO);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		return flag;
	}//addOtherImg
	
	
	/**
	 * 객실 상태 변경
	 * @param rmVO
	 * @return
	 */
	public int changeRoomStatus(RoomVO rmVO){
		int cnt = 0;
		try {
			cnt = roomDAO.UpdateRoomStatus(rmVO);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		return cnt;
	}//changeRoomStatus
	

	/**
	 * 객실 수정 시, 중복 객실명 조회
	 * @param rmVO
	 * @return
	 */
	public List<String> searchDupRoomName(RoomVO rmVO) {
		List<String> list = null;
		try {
			list = roomDAO.selectDupRoomName(rmVO);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		return list;
	}//searchDupRoomName
	
	
	/**
	 * 객실 정보 수정
	 * @param rmVO
	 * @return
	 */
	public boolean changeRoom(RoomVO rmVO) {
		boolean flag = false;
		try {
			flag = roomDAO.updateRoom(rmVO);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		return flag;
	}//changeRoom
	
	
	/**
	 * 기존 객실의 기타이미지 존재 시 모두 삭제
	 * @param rmVO
	 * @return
	 */
	public boolean removeAllOtherImg(RoomVO rmVO) {
		boolean flag = false;
		try {
			flag = roomDAO.deleteAllOtherImg(rmVO);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		return flag;
	}//removeAllOtherImg
	
}// class

