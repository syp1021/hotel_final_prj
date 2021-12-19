package kr.co.mvc.user.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import kr.co.mvc.user.vo.MainRoomVO;


@Component
public class MainDAO {

	@Autowired(required = false)
	private JdbcTemplate jt;
	
	/**
	 * 메인에 보여질 간단한 룸정보를 위해 만듦 / 모든 객실의 메인이미지, 룸네임만 가져감
	 * @return
	 * @throws SQLException
	 */
	public List<MainRoomVO> selectMainRoom() throws SQLException{
		List<MainRoomVO> rList = null;
		
		String selectMainRoom = "select room_no, r_name, main_img from room where r_status = 'Y'  order by room_no asc";
		//rList = jt.query(selectMainRoom, new RowMapper<RoomVO>() {
		rList = jt.query(selectMainRoom, new RowMapper<MainRoomVO>() {

			@Override
			public MainRoomVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MainRoomVO rVO = new MainRoomVO();
				rVO.setRoom_no(rs.getInt("room_no"));
				rVO.setR_name(rs.getString("r_name"));
				rVO.setMain_img(rs.getString("main_img"));
				return rVO;
			}//mapRow	

		});


		return rList;
	}//selectAllDeptno
	
}
