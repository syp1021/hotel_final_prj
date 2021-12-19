package kr.co.mvc.user.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kr.co.mvc.admin.vo.OtherImgVO;
import kr.co.mvc.admin.vo.RoomVO;
import kr.co.mvc.user.dao.UserReservationDAO;
import kr.co.mvc.user.vo.ImagesVO;
import kr.co.mvc.user.vo.UserCardVO;
import kr.co.mvc.user.vo.UserMemberVO;
import kr.co.mvc.user.vo.UserReservationVO;
import kr.co.mvc.user.vo.UserRoomVO;
import kr.co.mvc.user.vo.searchRoomVO;
import kr.co.sist.util.cipher.DataDecrypt;

@Component
public class UserReservationService {

	@Autowired
	private UserReservationDAO resDAO;
	
	/**
	 * �� ���� ��ȸ(intro�� ����)
	 * @param rName
	 * @param rStatus
	 * @return
	 */
	public List<RoomVO> searchAllRooms(String rName, String rStatus){
		List<RoomVO> rList = null;

		rList = resDAO.selectRoomInfo(rName, rStatus);
		
		return rList;
	}//searchAllRooms
	
	/**
	 * �� ��Ÿ�̹��� ��ȸ(intro�� ����)
	 * @param rName
	 * @return
	 */
	public List<List<OtherImgVO>> searchOtherImgs(String rName, String rStatus){
		List<RoomVO> rList = null;
		rList = resDAO.selectRoomInfo(rName, rStatus);
		
		List<List<OtherImgVO>> imgVOList = new ArrayList<List<OtherImgVO>>();
		List<OtherImgVO> list = null; //���Ǻ� ��ȸ�� �� 
		for(RoomVO rVO : rList){
			list = new ArrayList<OtherImgVO>();
			list = (resDAO.selectOtherImg(rVO.getRoomName()));
			imgVOList.add(list);
		}//end for
		
		return imgVOList;
	}//searchOtherImgs
	
	
	/**
	 * ���Ǵ� �̹��� ����(intro�� ����)
	 * @param rName
	 * @param rStatus
	 * @return
	 */
	public List<Integer> roomCnt(String rName, String rStatus){
		List<RoomVO> rList = null;
		rList = resDAO.selectRoomInfo(rName, rStatus);
		List<OtherImgVO> list = null; //���Ǻ� ��ȸ�� �� 
		List<Integer> cnt = new ArrayList<Integer>(); //���Ǵ� �̹��� ����
		
		for(RoomVO rVO : rList){
			list = new ArrayList<OtherImgVO>();
			list = (resDAO.selectOtherImg(rVO.getRoomName()));
			cnt.add(Integer.valueOf(list.size()));
			
		}//end for
		System.out.println(cnt);
		return cnt;
	}//roomCnt
	
//-------------------------------------------------------------------------
	
	/**
	 * ��¥�� �ο��� �޾� ���డ���� ���� ��ȸ��
	 * @param queryString
	 * @return
	 */
	public String searchAvaileReserve(String start_date, String end_date, int adult, int child) {
		
		List<UserRoomVO> rList = null;
		
		try {
			rList = resDAO.selectAvaileReserve(start_date, end_date, adult, child);
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
		
		JSONObject jsonObj = new JSONObject();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		jsonObj.put("pubDate", sdf.format(new Date()));
		jsonObj.put("searchStartDate", start_date);
		jsonObj.put("searchEndDate", end_date);
		jsonObj.put("adultCnt", adult);
		jsonObj.put("childCnt", child);
		jsonObj.put("dataRow", rList.size() );
		jsonObj.put("dataResult", !rList.isEmpty() );

		//JSONArray ����
		JSONArray jsonArr = new JSONArray();
		JSONObject jsonTemp = new JSONObject();

		//��ȸ����� ����Ͽ� JSONObject ����
		for( UserRoomVO rVO : rList ){
			jsonTemp = new JSONObject();
			jsonTemp.put("room_no", rVO.getRoom_no());
			jsonTemp.put("r_name", rVO.getR_name());
			jsonTemp.put("description", rVO.getDescription());
			jsonTemp.put("price", rVO.getPrice());
			jsonTemp.put("main_img", rVO.getMain_img());
			jsonTemp.put("max_guest", rVO.getMax_guest());
			
			//������ JSONObject�� JSONArray�� �߰�
			jsonArr.add(jsonTemp);
		}//end for

		//JSONArray�� JSONObject�� �Ҵ�
		jsonObj.put("data", jsonArr);

		return jsonObj.toJSONString();
		
	}//searchAvaileReserve
	
	
	
	/**
	 * ��¥�� �ο����� ��ȸ���� �� ���̴� ���� ����� ���� ���λ��� ������
	 * @param room_no
	 * @return 
	 */
	public UserRoomVO searchRoomInfo(int room_no ) {
	UserRoomVO rVO = null;
			
		try {
			rVO = resDAO.selectRoomInfo(room_no);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rVO;
	}//searchRoominfo
	
	
	/**
	 * ���� ��Ÿ �̹��� ����
	 * @param room_no
	 * @return
	 */
	public int searchImgCnt( int room_no ) {
		int cnt = 0;
		cnt = resDAO.selectCountImg(room_no);
		return cnt;
	}//searchImgCnt
	
	
	/**
	 * ���� ��Ÿ �̹��� ��������
	 * @param room_no
	 * @return
	 * @throws SQLException 
	 */
	public List<ImagesVO> searchSubImgs( int room_no ) throws SQLException{
		List<ImagesVO> iList= null;
		iList = resDAO.selectSubImages(room_no);
		return iList;
	}//searchImgs
	
	
	
	
	/**
	 * ����� ���� ��ȣȭ
	 * @param id
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws GeneralSecurityException
	 * @throws SQLException
	 */
	public UserMemberVO DecryptSelectMemInfo (String id) throws UnsupportedEncodingException, GeneralSecurityException, SQLException {
			
		UserMemberVO mv = null;

		mv = resDAO.selectMemAllInfo(id);
		DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");
			mv.setId(mv.getId());
			mv.setEmail(dd.decryption(mv.getEmail()));
			mv.setEname_fst(dd.decryption(mv.getEname_fst()));
			mv.setEname_lst(dd.decryption(mv.getEname_lst()));
			mv.setKname(dd.decryption(mv.getKname()));
			mv.setTel(dd.decryption(mv.getTel()));
		return mv;
					
	}//DecryptSelectMemInfo
	
	
	/**
	 * ����� ������� ī�� �ο찡 �ִ��� Ȯ�� -> ������ card_no�� 0���� ��ȯ
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public String searchCardFlag( String id ) throws SQLException {
		String savedFlag = null;
		savedFlag = resDAO.selectSavedCard(id).getCard_no();
		return savedFlag;
	}//searchCardFlag
	
	
	/**
	 * ������� ī�� ���� ��������
	 * @param id
	 * @return
	 * @throws SQLException 
	 */
	public UserCardVO searchCardInfo( String id ) throws SQLException {
		UserCardVO cVO = null;
		cVO = resDAO.selectCardInfo(id);
		return cVO;
	} //searchCardInfo
	
	
	/**
	 * �����ϱ�
	 * @param rsVO
	 */
	public void addReservation ( UserReservationVO rsVO ) {
		System.out.println("����service----------" + rsVO);
		resDAO.insertRes(rsVO);
	}//addReservation
	
	
	/**
	 * ī������ �߰��ϱ�
	 * @param cardVO
	 */
	public void addCardInfo ( UserCardVO cardVO ) {
		System.out.println("ī���߰�service----------" + cardVO);
		resDAO.insertCardInfo(cardVO);
	}//addCardInfo
	
	
	/**
	 * ī������ �����ϱ�
	 * @param cardVO
	 */
	public void modifyCardInfo ( UserCardVO cardVO ) {
		System.out.println("ī�庯��service----------" + cardVO);
		resDAO.updateCard(cardVO);
	}//modifyCardInfo
	
}//class
