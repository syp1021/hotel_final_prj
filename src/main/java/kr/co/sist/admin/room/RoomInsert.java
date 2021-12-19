package kr.co.sist.admin.room;

import java.io.IOException;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.sist.dao.GetJdbcTemplate;

/**
 * 객실 추가 시 사용되는 클래스<br>
 * 1. 객실추가 / 2. 기타이미지가 존재하면 이미지 추가<br>
 * @author user
 */
public class RoomInsert {

	/**
	 * 객실추가 프로세스<br>
	 * room과 이미지를 호출하여 DB 추가 <br>
	 * temp 폴더의 이미지를 roomImages 폴더로 이동<br>
	 * @param roomVO
	 * @return
	 * @throws DataAccessException
	 * @throws IOException 
	 */
	public boolean insertProcess(RoomVO roomVO) throws DataAccessException, IOException {
		boolean totalFlag = false;
		
		boolean flag1 = insertRoom(roomVO);
		boolean flag2 = insertImg(roomVO);
		
		//객실추가 성공시 이미지 roomImages로 이동 및 temp 폴더의 임시파일 삭제
		if(flag1 == flag2) {
			UploadImgList ul = new UploadImgList();
			ul.moveRoomImg(); // roomImages 폴더로 이동
			ul.removeAllImg();
			totalFlag = true;
		}//end if
		return totalFlag;
	}// insertProcess

	/**
	 * 객실 정보를 insert
	 * @param roomVO
	 * @return
	 * @throws DataAccessException
	 */
	public boolean insertRoom(RoomVO roomVO) throws DataAccessException {
		boolean flag = false;

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		// room insert
		RoomSelect rs = new RoomSelect();
		int maxRoomNo = rs.selectMaxRoomNo();

		StringBuilder insertRoom = new StringBuilder();

		insertRoom.append("insert into	room	(room_no, r_name, description, price, bed_type, max_guest, ")
				.append("r_size, chkin_time, chkout_time, r_view, service, amnt_gen, amnt_bath, amnt_other, ")
				.append("more_info, main_img, input_date, r_status)	").append("	values	(")
				.append("?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,'Y'").append(")");

		int cnt = jt.update(insertRoom.toString(), maxRoomNo + 1, roomVO.getRoomName(), roomVO.getMainDesc(),
				roomVO.getPrice(), roomVO.getType(), roomVO.getGuestNum(), roomVO.getRoomSize(), roomVO.getChkIn(),
				roomVO.getChkOut(), roomVO.getView(), roomVO.getSpecialServ(), roomVO.getGeneralAmn(),
				roomVO.getBathAmn(), roomVO.getOtherAmn(), roomVO.getMoreInfo(), roomVO.getImg());

		// room insert 실패시 false return
		if (cnt == 1) {
			flag = true;
		}
		
		gjt.closeAc();

		return flag;
	}// insertRoom

	/**
	 * 기타 이미지 존재 시, 이미지 테이블에 추가 insert
	 * @param roomVO
	 * @return
	 * @throws DataAccessException
	 */
	public boolean insertImg(RoomVO roomVO) throws DataAccessException {
		boolean flag = false;

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		StringBuilder insertImg = new StringBuilder();

		insertImg.append("insert into 	images	 (img_no, room_no, img_src)		")
				.append("values 	(img_seq.nextval, (select room_no from room where r_name=?),?)");

		int roomCnt = 0;
		UploadImgList ul = new UploadImgList();
		String[] imgList = ul.searchOtherImg();

		if (imgList.length != 0) {
			for (String imgName : imgList) {
				if (imgName != null) {
					roomCnt += jt.update(insertImg.toString(), roomVO.getRoomName(), imgName);
				} // end if
			} // endfor
		} // end if

		if (roomCnt == imgList.length) {
			flag = true;
		} 
		
		//기타이미지 없어도 true
		if(imgList.length==0) {
			flag = true;
		}
		
		gjt.closeAc();

		return flag;
	}// insertImg
	
}// class
