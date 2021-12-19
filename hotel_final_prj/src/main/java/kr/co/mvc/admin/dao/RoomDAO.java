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
	 * ��ϵ� ��� room ������ ��ȸ
	 */
	public List<RoomVO> selectRoomInfo(String rName, String roonNum) throws DataAccessException {
		List<RoomVO> roomList = null;

		StringBuilder select = new StringBuilder("select * from room");
		//���Ǹ� ������ �� ���ǹ� �߰� 
		if (rName != null && !"".equals(rName) ){ 
			select.append("		where r_name='")
					.append(rName)
					.append("'");
		} // end if
		
		//���ǹ�ȣ ������ �� ���ǹ� �߰� 
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

		//room_no��� ����
		if(roomList != null) {
			Collections.sort(roomList, new CompareRNoAsc());
		}//end if
		return roomList;
	}// selectRoomInfo
	
	/**
	 *selectRoomInfo���� room no ������� �����ϴ� inner Class
	 * @author user
	 */
	public class CompareRNoAsc implements Comparator<RoomVO> {
		@Override
		public int compare(RoomVO o1, RoomVO o2) {
			return o1.getRoomNum().compareTo(o2.getRoomNum());
		}
	}// CompareRNoAsc
	
	
	/**
	 * images ���̺��� �뺰 �̹��� ��ȸ
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
			
			//�̹��� �̸� ��� ����
			if(imgList != null) {
				Collections.sort(imgList, new CompareImgSrcAsc());
			}//end if
		return imgList;
	}// selectOtherImg
	
	/**
	 * selectOtherImg���� imrSrc �̸� ������� �����ϴ� inner Class
	 * @author user
	 */
	public class CompareImgSrcAsc implements Comparator<OtherImgVO> {
		@Override
		public int compare(OtherImgVO o1, OtherImgVO o2) {
			return o1.getImgSrc().compareTo(o2.getImgSrc());
		}
	}// CompareRNoAsc
	
	/**
	 * ���� �߰� �� ���� ����ȣ�� RoomNo�� ��ȸ�Ͽ� ���
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
	 * ���� ���� ��, �ߺ� �̸��� ��ȸ�ϴ� ��
	 * @param rmVO
	 * @return
	 * @throws DataAccessException
	 */
	public List<String> selectDupRoomName(RoomVO rmVO) throws DataAccessException {
		List<String> list = null;
		//���� ���ǹ�ȣ�� �ٸ��� �����̸��� ���� �׸��� ��ȸ�Ͽ� ��ȯ
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
	 * ���� ������ insert
	 * @param rmVO
	 * @return
	 * @throws DataAccessException
	 */
	public boolean insertRoom(RoomVO rmVO, int lastRoomNo, ImgFormVO imgFrmVO) throws DataAccessException {
		boolean flag = false;
		
		//�Ķ���ͷ� ���� �����̹������� setting
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
	 * ��Ÿ �̹��� ���� ��, �̹��� ���̺� �߰� insert
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
		
		//��Ÿ�̹��� ��� true
		if(otherImgList.length == 0) {
			flag = true;
		}//end if
		
		return flag;
	}// insertOtherImg
	
	/**
	 * ���� ���� ����
	 * @param statusRNo ��ѹ�
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
	 * ���� ���� ����
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

		// room insert ���н� false return
		if (cnt == 1) {
			flag = true;
		}//end if 
		
		return flag;
	}// updateRoom
	
	/**
	 * ������ ��Ÿ �̹����� ������ ����
	 * @param rmVO
	 * @return
	 * @throws DataAccessException
	 */
	public boolean deleteAllOtherImg(RoomVO rmVO) throws DataAccessException {
		boolean flag = false;

		//��Ÿ�̹��� ������ delete ó�����ϰ� true return
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
