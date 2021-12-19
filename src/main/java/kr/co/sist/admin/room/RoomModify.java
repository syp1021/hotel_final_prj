package kr.co.sist.admin.room;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.sist.dao.GetJdbcTemplate;

/**
 * 객실 정보 변경을 수행하는 클래스
 * @author user
 */
public class RoomModify {

	/**
	 * 객실 상태 변경
	 * @param statusRNo 룸넘버
	 * @param rStatus Y | N
	 * @return
	 */
	public int UpdateRoomStatus(String statusRNo, String rStatus) throws DataAccessException {
		int cnt = 0;

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		StringBuilder updateStatus = new StringBuilder();
		updateStatus.append("update 	room		")
				.append(" set   r_status=?	")
				.append(" where 	room_no=?");

		cnt = jt.update(updateStatus.toString(), rStatus, statusRNo);

		gjt.closeAc();

		return cnt;
	}// RoomStatusUpdate


	/**
	 * 객실 정보 수정
	 * @param roomVO
	 * @return
	 * @throws DataAccessException
	 */
	public boolean updateRoom(RoomVO roomVO) throws DataAccessException {
		boolean flag = false;

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		StringBuilder updateRoom = new StringBuilder();

		updateRoom
			.append("	update	 room	")
			.append("	set		r_name=?, 	description=?,	price=?,	bed_type=?, 	max_guest=?,	r_size=?,	")
			.append("		chkin_time=?,	chkout_time=?, 	r_view=?,	service=?,	amnt_gen=?,		amnt_bath=?,	")
			.append("		amnt_other=?,	more_info=?,	main_img=?,		input_date=sysdate")
			.append("	where	 room_no = ?");
		
		
		int cnt = jt.update(updateRoom.toString(), roomVO.getRoomName(), roomVO.getMainDesc(),
				roomVO.getPrice(), roomVO.getType(), roomVO.getGuestNum(), roomVO.getRoomSize(), roomVO.getChkIn(),
				roomVO.getChkOut(), roomVO.getView(), roomVO.getSpecialServ(), roomVO.getGeneralAmn(),
				roomVO.getBathAmn(), roomVO.getOtherAmn(), roomVO.getMoreInfo(), roomVO.getImg(),roomVO.getRoomNum());

		// room insert 실패시 false return
		if (cnt == 1) {
			flag = true;
		}//end if 
		
		gjt.closeAc();

		return flag;
	}// updateRoom
	
	/**
	 * 기존에 기타 이미지가 있으면 삭제
	 * @param roomVO
	 * @return
	 * @throws DataAccessException
	 */
	public boolean deleteImg(RoomVO roomVO) throws DataAccessException {
		boolean flag = false;

		//기타이미지 없으면 delete 처리안하고 true return
		RoomSelect rs = new RoomSelect();
		List<OtherImgVO> list = rs.selectOtherImg(roomVO.getRoomName());
		if(list.size()==0) {
			flag = true;
		}else {
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		StringBuilder deleteImg = new StringBuilder();

		deleteImg.append("delete	from 	images	")
				.append("where	room_no=?");

		int cnt = jt.update(deleteImg.toString(), roomVO.getRoomNum());
		if(cnt==list.size()) {
			flag = true;
		}//end if
		gjt.closeAc();
		}//ed else

		return flag;
	}// deleteImg
	
}// class
