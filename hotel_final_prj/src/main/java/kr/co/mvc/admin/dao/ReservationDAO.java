package kr.co.mvc.admin.dao;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import kr.co.mvc.admin.vo.ChkInDateVO;
import kr.co.mvc.admin.vo.ReservationSelectVO;
import kr.co.mvc.admin.vo.ReservationUpdateVO;

import kr.co.sist.util.cipher.DataDecrypt;

@Component
public class ReservationDAO {
	
	@Autowired(required = false)
	private JdbcTemplate jt;
	
	/**
	 * 객실 예약 조회<br>
	 * 최근 예약일자부터 내림차순
	 * @param date
	 * @return
	 * @throws DataAccessException
	 */
	public List<ReservationSelectVO> selectRes(ChkInDateVO date, int startNum, int endNum) throws DataAccessException {
		List<ReservationSelectVO> rsList = null;
		
		StringBuilder select = new StringBuilder();
		select.append("		select	*	from	(	")
		//inline view 시작
				.append("		select row_number()over(order by rs.res_date desc) rnum,")
				.append("rs.res_status, to_char(rs.res_date, 'yyyy.mm.dd HH24:MI') res_date, rs.res_no, m.kname,")
				.append("		(rs.chkin_date || '-'|| rs.chkout_date) staydate,")
				.append("		(nvl(rs.adult,0) + nvl(rs.child,0)) guest, r.r_name		")
				.append("from   reservation rs, member m, room r		")
				.append("where  (rs.id = m.id and rs.room_no = r.room_no) and rs.res_status='Y' 	");

		if (date != null && date.getYear() != null && !("".equals(date.getYear()))) { // 일자가 입력되었다면 체크인 날짜로 where 절에 문구 추가
			select.append("and chkin_date = '") // year.month.day
					.append(date.getYear()).append(".").append(date.getMonth()).append(".").append(date.getDay())
					.append("'");
		} // end if

		select.append("	)")
		//inline view 끝
			.append("		where 	rnum between	?  and   ?		");
		
		rsList = jt.query(select.toString(), new Object[] {startNum, endNum},new RowMapper<ReservationSelectVO>(){

			@Override
			public ReservationSelectVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				ReservationSelectVO rsVO = null;
				try {
					DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");
					rsVO = new ReservationSelectVO();
					rsVO.setrNum(rs.getString("rnum"));
					rsVO.setResNo(rs.getString("res_no"));
					rsVO.setResDate(rs.getString("res_date"));
					rsVO.setkName(dd.decryption(rs.getString("kname")));
					rsVO.setStayDate(rs.getString("staydate"));
					rsVO.setGuest(rs.getInt("guest"));
					rsVO.setrName(rs.getString("r_name"));
					rsVO.setResStauts(rs.getString("res_status"));
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				} catch (GeneralSecurityException e) {
					e.printStackTrace();
				}//end catch
				return rsVO;
			}//end marRow
		});
		return rsList;
	}// selectRes
	
	/**
	 * 페이지네이션을 위한 전체 레코드 수 조회
	 * @param date
	 * @return
	 * @throws DataAccessException
	 */
	public int selectAllResCnt(ChkInDateVO date) throws DataAccessException {
		int allResCnt = 0;
		
		StringBuilder select = new StringBuilder();
		select.append("select	count(rs.res_no)	")  // 기본키인 res_no으로 전체 행수 조회
		.append("from   reservation rs, member m, room r		")
		.append("where  (rs.id = m.id and rs.room_no = r.room_no) and rs.res_status='Y' 	");
		
		if (date != null && date.getYear() != null && !("".equals(date.getYear()))) { // 일자가 입력되었다면 체크인 날짜로 where 절에 문구 추가
			select.append("and chkin_date = '") // year.month.day
			.append(date.getYear()).append(".").append(date.getMonth()).append(".").append(date.getDay())
			.append("'");
		} // end if
		
		select.append("		order by  res_date desc");
		
		allResCnt = jt.queryForObject(select.toString(),Integer.class);
		
		return allResCnt;
	}// selectAllResCnt

	
	/**
	 * 특정예약건 삭제 method / update로 status N로 변경
	 * @param delResNum
	 * @return
	 * @throws DataAccessException
	 */
	public int deleteRes(String delResNum) throws DataAccessException {
		int cnt = 0;

		String deleteRes = "update reservation 	set res_status='N'	where res_no=?";
		cnt = jt.update(deleteRes, delResNum);
		
		return cnt;
	}// deleteRes
	
	
	
	/**
	 * 선택 예약건 수정 전 기존 정보를 조회하는 method
	 * @param resNum
	 * @return
	 */
	public ReservationUpdateVO selectRes(String resNum) throws DataAccessException {
		ReservationUpdateVO ruVO = null;

		StringBuilder select = new StringBuilder();
		select.append("select rs.res_no, m.kname, rs.chkin_date, rs.chkout_date,")
				.append("		rs.adult, nvl(rs.child,0) child,").append("		r.r_name, rs.add_req		")
				.append("from   reservation rs, member m, room r 	")
				.append("where  (rs.id = m.id and rs.room_no = r.room_no) and res_no=?");

		ruVO = jt.queryForObject(select.toString(), new Object[] { resNum }, new RowMapper<ReservationUpdateVO>() {
			public ReservationUpdateVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				ReservationUpdateVO ruVO = null;
				try {
					DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");
					ruVO = new ReservationUpdateVO();
					ruVO.setResNo(rs.getString("res_no"));
					ruVO.setkName(dd.decryption(rs.getString("kname")));
					ruVO.setChkInDate(rs.getString("chkin_date"));
					ruVO.setChkOutDate(rs.getString("chkout_date"));
					ruVO.setAdult(rs.getInt("adult"));
					ruVO.setChild(rs.getInt("child"));
					ruVO.setrName(rs.getString("r_name"));
					ruVO.setAddReq(rs.getString("add_req"));
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				} catch (GeneralSecurityException e) {
					e.printStackTrace();
				}//end catch
				return ruVO;
			}// mapRow
		});

		// 체크인.아웃 날짜 분리하여 저장
		ruVO.setInYear(ruVO.getChkInDate().substring(0, 4));
		ruVO.setInMonth(ruVO.getChkInDate().substring(5, 7));
		ruVO.setInDay(ruVO.getChkInDate().substring(8, 10));
		ruVO.setOutYear(ruVO.getChkOutDate().substring(0, 4));
		ruVO.setOutMonth(ruVO.getChkOutDate().substring(5, 7));
		ruVO.setOutDay(ruVO.getChkOutDate().substring(8, 10));

		return ruVO;
	}// selectRes

	
	/**
	 * 예약변경시 사용할 활성화된 객실 리스트 조회
	 * @return
	 */
	public List<String> selectAvailableRoomList() throws DataAccessException {
		List<String> list = null;

		String select = "select r_name from room where r_status='Y'";
		list = jt.query(select, new RowMapper<String>() {
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				String name = rs.getString("r_name");
				return name;
			}// mapRow
		});

		return list;
	}// selectAvailableRoomList
	
	
	/**
	 * 예약변경 요청된 객실의 최대 수용인원 조회
	 * @param ruVO
	 * @return
	 * @throws DataAccessException
	 */
	public int selectMaxGuest(ReservationUpdateVO ruVO) throws DataAccessException {
		int maxGuest = 0;

		String select = "select max_Guest from room where r_name=?";
		maxGuest = jt.queryForObject(select, new Object[] { ruVO.getrName() }, Integer.class);

		return maxGuest;
	}// selectMaxGuest


	/**
	 * 예약변경 요청된 일자와 중복예약일자 조회
	 * @param ruVO
	 * @return
	 * @throws DataAccessException
	 */
	public List<String> selectStayDateList(ReservationUpdateVO ruVO) throws DataAccessException {
		List<String> list = null;

		StringBuilder select = new StringBuilder();
		select.append("	select res_no	").append("	from   reservation	")
				.append("	where  room_no= (select room_no from room where r_name= ?)	")
				.append("	 and ((to_date( ? ) between to_date(chkin_date) and (to_date(chkout_date)-1)) or	")
				.append("	 (to_date(chkin_date) between to_date( ? ) and to_date( ? )-1))	")
				.append("	 and res_no != ? 	and res_status = 'Y'");

		list = jt.query(select.toString(), new Object[] { ruVO.getrName(), ruVO.getChkInDate(), ruVO.getChkInDate(),
				ruVO.getChkOutDate(), ruVO.getResNo() }, new SelectResNo());

		return list;
	}// selectStayDateList

	public class SelectResNo implements RowMapper<String> {
		@Override
		public String mapRow(ResultSet rs, int cnt) throws SQLException {
			String resNo = rs.getString("res_no");
			return resNo;
		}// mapRow
	}// SelectResNo
	
	
	/**
	 * 특정 예약 update
	 * @param ruVO
	 * @return
	 * @throws DataAccessException
	 */
	public int updateRes(ReservationUpdateVO ruVO) throws DataAccessException {
		int cnt = 0;

		StringBuilder sb = new StringBuilder();
		sb.append("update reservation		")
				.append("	set 	chkin_date = to_char(to_date(?),'yyyy.mm.dd'),")
				.append("		chkout_date = to_char(to_date(?),'yyyy.mm.dd'),")
				.append("		adult = ?, child = ?,")
				.append("		room_no = (select room_no from room where r_name=?),")
				.append("       add_req = ?	 , res_date=sysdate	").append("where  res_no=?	");

		cnt = jt.update(sb.toString(), ruVO.getChkInDate(), ruVO.getChkOutDate(), ruVO.getAdult(),
				ruVO.getChild(), ruVO.getrName(), ruVO.getAddReq(), ruVO.getResNo());

		return cnt;
	}// updateRes
	
	
}//class 
