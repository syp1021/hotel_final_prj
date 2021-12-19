package kr.co.mvc.admin.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import kr.co.mvc.admin.vo.ImgFormVO;
import kr.co.mvc.admin.vo.OtherImgVO;
import kr.co.mvc.admin.vo.RoomVO;

@Component
public class RoomDAO {

	@Autowired(required = false)
	private JdbcTemplate jt;
	
	/**
	 * 등록된 모든 room 상세정보 조회
	 */
	public List<RoomVO> selectRoomInfo(String rName, String roonNum) throws DataAccessException {
		List<RoomVO> roomList = null;

		StringBuilder select = new StringBuilder("select * from room");
		//객실명 들어왔을 때 조건문 추가 
		if (rName != null && !"".equals(rName) ){ 
			select.append("		where r_name='")
					.append(rName)
					.append("'");
		} // end if
		
		//객실번호 들어왔을 때 조건문 추가 
		if (roonNum != null && !"".equals(roonNum) ){ 
			select.append("		where room_no='")
			.append(roonNum)
			.append("'");
		} // end if
 
		roomList = jt.query(select.toString(), new RowMapper<RoomVO>() {
			@Override
			public RoomVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				RoomVO rmVO = new RoomVO();
				rmVO.setrStatus(rs.getString("r_status"));
				rmVO.setRoomNum(rs.getString("room_no"));
				rmVO.setRoomName(rs.getString("r_name"));
				rmVO.setMainDesc(rs.getString("description"));
				rmVO.setType(rs.getString("bed_type"));
				rmVO.setRoomSize(rs.getString("r_size"));
				rmVO.setView(rs.getString("r_view"));
				rmVO.setChkIn(rs.getString("chkin_time"));
				rmVO.setChkOut(rs.getString("chkout_time"));
				rmVO.setSpecialServ(rs.getString("service"));
				rmVO.setGeneralAmn(rs.getString("amnt_gen"));
				rmVO.setBathAmn(rs.getString("amnt_bath"));
				rmVO.setOtherAmn(rs.getString("amnt_other"));
				rmVO.setMoreInfo(rs.getString("more_info"));
				rmVO.setImg(rs.getString("main_img"));
				rmVO.setInputDate(rs.getString("input_date"));
				String price = new DecimalFormat("#,###").format(rs.getInt("price"));
				rmVO.setPrice(price);
				rmVO.setGuestNum(rs.getString("max_guest"));
				return rmVO;
			}//mapRow
		});

		//room_no대로 정렬
		if(roomList != null) {
			Collections.sort(roomList, new CompareRNoAsc());
		}//end if
		return roomList;
	}// selectRoomInfo
	
	/**
	 *selectRoomInfo에서 room no 순서대로 정렬하는 inner Class
	 * @author user
	 */
	public class CompareRNoAsc implements Comparator<RoomVO> {
		@Override
		public int compare(RoomVO o1, RoomVO o2) {
			return o1.getRoomNum().compareTo(o2.getRoomNum());
		}
	}// CompareRNoAsc
	
	
	/**
	 * images 테이블에서 룸별 이미지 조회
	 * @param rName
	 * @return
	 * @throws DataAccessException
	 */
	public List<OtherImgVO> selectOtherImg(String rName, String roomNum) throws DataAccessException {
		List<OtherImgVO> imgList = null;
		StringBuilder select = new StringBuilder();

		select.append(" 	select * 	from   images");
		if (rName != null && !"".equals(rName) ){ 
			select.append(" 	where  room_no = (select room_no from room where r_name='")
			      .append(rName)
			      .append("')");
		}//end if
		
		if (roomNum != null && !"".equals(roomNum) ){ 
			select.append(" 	where  room_no ='")
				.append(roomNum)
				.append("'");
		}//end if
		
			imgList = jt.query(select.toString(), 
					new RowMapper<OtherImgVO>() {
						public OtherImgVO mapRow(ResultSet rs, int rowNum) throws SQLException  {
							OtherImgVO imgVO = new OtherImgVO();
							imgVO.setImgNo(rs.getInt("img_no"));
							imgVO.setRoomNo(rs.getInt("room_no"));
							imgVO.setImgSrc(rs.getString("img_src"));
							return imgVO;
						}//mapRow
			});
			
			//이미지 이름 대로 정렬
			if(imgList != null) {
				Collections.sort(imgList, new CompareImgSrcAsc());
			}//end if
		return imgList;
	}// selectOtherImg
	
	/**
	 * selectOtherImg에서 imrSrc 이름 순서대로 정렬하는 inner Class
	 * @author user
	 */
	public class CompareImgSrcAsc implements Comparator<OtherImgVO> {
		@Override
		public int compare(OtherImgVO o1, OtherImgVO o2) {
			return o1.getImgSrc().compareTo(o2.getImgSrc());
		}
	}// CompareRNoAsc
	
	/**
	 * 객실 추가 시 가장 끝번호인 RoomNo를 조회하여 사용
	 * @return
	 * @throws DataAccessException
	 */
	public int selectLastRoomNo() throws DataAccessException{
		int num = 0;
		String selectLastRoomNo = "select max(room_no) from room";
		num = jt.queryForObject(selectLastRoomNo, Integer.class);
		return num;
	}//selectLastRoomNo
	
	/**
	 * 객실 수정 시, 중복 이름을 조회하는 일
	 * @param rmVO
	 * @return
	 * @throws DataAccessException
	 */
	public List<String> selectDupRoomName(RoomVO rmVO) throws DataAccessException {
		List<String> list = null;
		//현재 객실번호와 다르나 객실이름이 같은 항목을 조회하여 반환
		String select = "select r_name from room where r_name=? and room_no!=?";
		list = jt.query(select, new Object[] {rmVO.getRoomName(), rmVO.getRoomNum()}, new RowMapper<String>() {
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				String name = rs.getString("r_name");
				return name;
			}// mapRow
		});
		return list;
	}// selectDupRoomName
	
	
	/**
	 * 객실 정보를 insert
	 * @param rmVO
	 * @return
	 * @throws DataAccessException
	 */
	public boolean insertRoom(RoomVO rmVO, int lastRoomNo, ImgFormVO imgFrmVO) throws DataAccessException {
		boolean flag = false;
		
		//파라미터로 받은 메인이미지명을 setting
		rmVO.setImg(imgFrmVO.getMainImg());
		
		StringBuilder insertRoom = new StringBuilder();
		
		insertRoom.append("insert into	room	(room_no, r_name, description, price, bed_type, max_guest, ")
				.append("r_size, chkin_time, chkout_time, r_view, service, amnt_gen, amnt_bath, amnt_other, ")
				.append("more_info, main_img, input_date, r_status)	").append("	values	(")
				.append("?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,'Y'").append(")");

		int cnt = jt.update(insertRoom.toString(), lastRoomNo + 1, rmVO.getRoomName(), rmVO.getMainDesc(),
				rmVO.getPrice(), rmVO.getType(), rmVO.getGuestNum(), rmVO.getRoomSize(), rmVO.getChkIn(),
				rmVO.getChkOut(), rmVO.getView(), rmVO.getSpecialServ(), rmVO.getGeneralAmn(),
				rmVO.getBathAmn(), rmVO.getOtherAmn(), rmVO.getMoreInfo(), rmVO.getImg());
		
		if (cnt == 1) {
			flag = true;
		}//end if
		
		return flag;
	}// insertRoom

	/**
	 * 기타 이미지 존재 시, 이미지 테이블에 추가 insert
	 * @param roomVO
	 * @return
	 * @throws DataAccessException
	 */
	public boolean insertOtherImg(RoomVO rmVO, ImgFormVO imgFrmVO) throws DataAccessException {
		boolean flag = false;
		StringBuilder insertImg = new StringBuilder();
		
		insertImg.append("insert into 	images	 (img_no, room_no, img_src)		")
				.append("values 	(img_seq.nextval, (select room_no from room where r_name=?),?)");
		
		String[] otherImgList = imgFrmVO.getOtherImgs();
		int cnt = 0;
		if (otherImgList.length != 0) {
			for (String otherImg : otherImgList) {
				if (otherImg != null) {
					cnt += jt.update(insertImg.toString(), rmVO.getRoomName(), otherImg);
				} // end if
			} // endfor
		} // end if

		if (cnt == otherImgList.length) {
			flag = true;
		}//end if
		
		//기타이미지 없어도 true
		if(otherImgList.length == 0) {
			flag = true;
		}//end if
		
		return flag;
	}// insertOtherImg
	
	/**
	 * 객실 상태 변경
	 * @param statusRNo 룸넘버
	 * @param rStatus Y | N
	 * @return
	 */
	public int UpdateRoomStatus(RoomVO rmVO) throws DataAccessException {
		int cnt = 0;

		StringBuilder updateStatus = new StringBuilder();
		updateStatus.append("update 	room		")
				.append(" set   r_status=?	")
				.append(" where 	room_no=?");

		cnt = jt.update(updateStatus.toString(), rmVO.getrStatus(), rmVO.getRoomNum());

		return cnt;
	}// UpdateRoomStatus


	/**
	 * 객실 정보 수정
	 * @param rmVO
	 * @return
	 * @throws DataAccessException
	 */
	public boolean updateRoom(RoomVO rmVO) throws DataAccessException {
		boolean flag = false;
		
		StringBuilder updateRoom = new StringBuilder();
		updateRoom
			.append("	update	 room	")
			.append("	set		r_name=?, 	description=?,	price=?,	bed_type=?, 	max_guest=?,	r_size=?,	")
			.append("		chkin_time=?,	chkout_time=?, 	r_view=?,	service=?,	amnt_gen=?,		amnt_bath=?,	")
			.append("		amnt_other=?,	more_info=?,	main_img=?,		input_date=sysdate")
			.append("	where	 room_no = ?");
		
		int cnt = jt.update(updateRoom.toString(), rmVO.getRoomName(), rmVO.getMainDesc(),
				rmVO.getPrice(), rmVO.getType(), rmVO.getGuestNum(), rmVO.getRoomSize(), rmVO.getChkIn(),
				rmVO.getChkOut(), rmVO.getView(), rmVO.getSpecialServ(), rmVO.getGeneralAmn(),
				rmVO.getBathAmn(), rmVO.getOtherAmn(), rmVO.getMoreInfo(), rmVO.getImg(),rmVO.getRoomNum());

		// room insert 실패시 false return
		if (cnt == 1) {
			flag = true;
		}//end if 
		
		return flag;
	}// updateRoom
	
	/**
	 * 기존에 기타 이미지가 있으면 삭제
	 * @param rmVO
	 * @return
	 * @throws DataAccessException
	 */
	public boolean deleteAllOtherImg(RoomVO rmVO) throws DataAccessException {
		boolean flag = false;

		//기타이미지 없으면 delete 처리안하고 true return
		List<OtherImgVO> list = selectOtherImg(rmVO.getRoomName(),null);
		if(list.size()==0) {
			flag = true;
		} else {
			StringBuilder deleteImg = new StringBuilder();
			deleteImg.append("delete	from 	images	")
					.append("where	room_no=?");
	
			int cnt = jt.update(deleteImg.toString(), rmVO.getRoomNum());
			if(cnt == list.size()) {
				flag = true;
			}//end if
		}//end else

		return flag;
	}// deleteAllOtherImg
	
	
}//class
