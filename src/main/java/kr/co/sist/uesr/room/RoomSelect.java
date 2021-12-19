package kr.co.sist.uesr.room;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;




public class RoomSelect {
	
	
	/**
	 * 활성화된 방 조회
	 * @return
	 * @throws SQLException
	 */
	public List<Integer> selectAllRoomNo() throws SQLException{
		List<Integer> list = null;
		
		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		// 3. 쿼리실행
		String selectRoomNo = "select room_no from room where r_status='Y'";
		list = jt.query(selectRoomNo, new RowMapper<Integer>() {
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				Integer i = Integer.valueOf(rs.getInt("room_no"));
				return i;
			}//mapRow
		});
		
		// 4. Spring Container 닫기
		gjt.closeAc();
		
		return list;
	}//selectAllDeptno
	
	
	
	/**
	 * 메인에 보여질 간단한 룸정보를 위해 만듦 / 모든 객실의 메인이미지, 룸네임만 가져감
	 * @return
	 * @throws SQLException
	 */
	public List<RoomVO> selectMainRoom() throws SQLException{
		List<RoomVO> rList = null;
		
		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		// 3. 쿼리실행
		String selectMainRoom = "select room_no, r_name, main_img from room where r_status = 'Y'  order by room_no asc";
		rList = jt.query(selectMainRoom, new RowMapper<RoomVO>() {

			@Override
			public RoomVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				RoomVO rVO = new RoomVO();
				rVO.setRoom_no(rs.getInt("room_no"));
				rVO.setR_name(rs.getString("r_name"));
				rVO.setMain_img(rs.getString("main_img"));
				return rVO;
			}//mapRow
			
		});
		
		// 4. Spring Container 닫기
		gjt.closeAc();
		
		return rList;
	}//selectAllDeptno
	
	

	/**
	 * 하나의 객실정보 얻어오기
	 * @param room_no
	 * @return
	 * @throws SQLException
	 */
	public RoomVO selectRoomInfo( int room_no ) throws SQLException{
		RoomVO rv = null;
		
		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		// 3. 쿼리 실행
		String select = "select r_name, description, bed_type, max_guest, r_size, chkin_time, chkout_time, r_view, "
				+ "amnt_gen, amnt_bath, amnt_other, main_img, price from room where room_no = ?";
		
		// interface를 anonymous inner class로 생성하여 그 안에서 조회결과를 VO에 할당
		rv = jt.queryForObject(select, new Object[] { room_no }, 
				new RowMapper<RoomVO>() {
			public RoomVO mapRow(ResultSet rs, int rowNum) throws SQLException{
						RoomVO rv = new RoomVO();
						// ResultSet을 사용하여 조회결과를 VO에 저장
						rv.setR_name(rs.getString("r_name"));
						rv.setDescription(rs.getString("description"));
						rv.setBed_type(rs.getString("bed_type"));
						rv.setMax_guest(rs.getInt("max_guest"));
						rv.setR_view(rs.getString("r_view"));
						rv.setR_size(rs.getString("r_size"));
						rv.setChkin_time(rs.getString("chkin_time"));
						rv.setChkout_time(rs.getString("chkout_time"));
						rv.setAmnt_gen(rs.getString("amnt_gen"));
						rv.setAmnt_bath(rs.getString("amnt_bath"));
						rv.setAmnt_other(rs.getString("amnt_other"));
						rv.setMain_img(rs.getString("main_img"));
						rv.setPrice(rs.getInt("price"));
						
						
						// 조회결과를 저장한 dv 반환
						return rv;
					}
				});

		// 4. Spring Container 닫기
		gjt.closeAc();
		
		return rv;
	}//selectRoomInfo
	
	
	
	/**
	 * 사용자가 선택한 인원수와 날짜를 받아 예약가능한 방을 조회하기
	 * @param start_date
	 * @param end_date
	 * @param adult
	 * @param child
	 * @return
	 * @throws SQLException
	 */
	public List<RoomVO> selectAvaileReserve (String start_date, String end_date, String adult, String child)
		throws SQLException{
		
		List<RoomVO> list = null;
		
		//Spring Container얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
				
		//JdbcTemplate 얻기	
		JdbcTemplate jt = gjt.getJdbcTemplate();
				   
		//쿼리실행
		StringBuilder selectAvailReserve = new StringBuilder();
		selectAvailReserve
		.append("	select 	room_no, room.r_status, room.r_name, room.max_guest, room.description, room.price, room.main_img	")
		.append("	from room	")
		.append("	where room_no not in ")
		.append("	(select room.room_no	")
		.append("	from  room room, reservation res	")
		.append("	where (res.room_no=room.room_no)	")
		.append("	and (  (to_date(chkin_date,'yyyy.mm.dd')<=to_date(?,'yyyy.mm.dd')	")
		.append("	and to_date(chkout_date,'yyyy.mm.dd') >= to_date(?,'yyyy.mm.dd')))	")
		.append(" 	)	")
		.append("	and ((to_number(?) + nvl(to_number(?),0) ) <= room.max_guest)	")
		.append("   and(room.r_status = 'Y')"	);
		// 날짜에 해당하는 값이 없고,
		// 최대 인원수보다 작거나 같은 방
		// adult, child 파라메터를 String형으로 받아오기 때문에, 연산가능한 number로 형변환한다.
		// 어린이 0 명일때를 고려하여 nvl 사용
		
		
		list = jt.query(selectAvailReserve.toString(), new Object[] { start_date, end_date, adult, child },
				new RowMapper<RoomVO>() {

					@Override
					public RoomVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
						RoomVO rVO = new RoomVO();
						rVO.setR_name(rs.getString("r_name"));
						rVO.setRoom_no(rs.getInt("room_no"));
						rVO.setR_status(rs.getString("r_status"));
						rVO.setMax_guest(rs.getInt("max_guest"));
						rVO.setDescription(rs.getString("description"));
						rVO.setPrice(rs.getInt("price"));
						rVO.setMain_img(rs.getString("main_img"));
						return rVO;
					}
	
		});
				
		//Spring Container 연결끊기
		gjt.closeAc();
		
		return list;
		
	}//selectAvailReserve
	
}//class
