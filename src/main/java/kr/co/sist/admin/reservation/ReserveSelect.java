package kr.co.sist.admin.reservation;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;
import kr.co.sist.util.cipher.DataDecrypt;

/**
 * 예약 조회를 수행하는 클래스
 * 
 * @author user
 */
public class ReserveSelect {

	/**
	 * 예약관리 페이지에서 보여질 예약 조회<br>
	 * 최근 예약일자부터 내림차순으로 조회
	 * @param date
	 * @return
	 * @throws DataAccessException
	 */
	public List<ReserveSelectVO> selectRes(ReserveDateVO date) throws DataAccessException {
		List<ReserveSelectVO> rsList = null;

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		StringBuilder select = new StringBuilder();
		select.append(
				"select	rs.res_status, to_char(rs.res_date, 'yyyy.mm.dd HH24:MI') res_date, rs.res_no, m.kname,")
				.append("		(rs.chkin_date || '-'|| rs.chkout_date) staydate,")
				.append("		(nvl(rs.adult,0) + nvl(rs.child,0)) guest, r.r_name		")
				.append("from   reservation rs, member m, room r		")
				.append("where  (rs.id = m.id and rs.room_no = r.room_no) and rs.res_status='Y' 	");

		if (date.getYear() != null) { // 일자가 입력되었다면 체크인 날짜로 where 절에 문구 추가
			select.append("and chkin_date = '") // year.month.day
					.append(date.getYear()).append(".").append(date.getMonth()).append(".").append(date.getDay())
					.append("'");
		} // end if

		select.append("		order by  res_date desc");
		rsList = jt.query(select.toString(), new selectRes());

		gjt.closeAc();
		return rsList;
	}// selectRes

	/**
	 * selectRes에서 조회된 예약 정보를 담을 inner class
	 * @author user
	 */
	public class selectRes implements RowMapper<ReserveSelectVO> {
		public ReserveSelectVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			ReserveSelectVO rsVO = null;
			try {
				rsVO = new ReserveSelectVO();
				DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");
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
			}
			return rsVO;
		}// mapRow

	}// selectRes

	/**
	 * 선택 예약건 수정 전 기존 정보를 조회하는 method
	 * @param resNum
	 * @return
	 * @throws DataAccessException
	 */
	public ReserveUpdateVO selectRes(String resNum) throws DataAccessException {
		ReserveUpdateVO ruVO = null;

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		StringBuilder select = new StringBuilder();
		select.append("select rs.res_no, m.kname, rs.chkin_date, rs.chkout_date,")
				.append("		rs.adult, nvl(rs.child,0) child,").append("		r.r_name, rs.add_req		")
				.append("from   reservation rs, member m, room r 	")
				.append("where  (rs.id = m.id and rs.room_no = r.room_no) and res_no=?");

		ruVO = jt.queryForObject(select.toString(), new Object[] { resNum }, new RowMapper<ReserveUpdateVO>() {
			public ReserveUpdateVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				ReserveUpdateVO ruVO = null;
				try {
					ruVO = new ReserveUpdateVO();
					DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");
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
				}
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

		// 4. Spring Container닫기
		gjt.closeAc();

		return ruVO;
	}// selectRes

	/**
	 * 예약수정 프로세스에서 사용할 최대 객실인원 수
	 * @param rName
	 * @return
	 * @throws DataAccessException
	 */
	public int selectMaxGuest(String rName) throws DataAccessException {
		int maxGuest = 0;

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String select = "select max_Guest from room where r_name=?";
		maxGuest = jt.queryForObject(select, new Object[] { rName }, Integer.class);

		gjt.closeAc();

		return maxGuest;
	}// selectMaxGuest


	/**
	 * 예약수정 프로세스에서 사용할 체크인/아웃 일자 유효 체크<br>
	 * 기존 예약건과 일자가 겹치는 경우를 조회 <br>
	 * @param ruVO
	 * @return
	 * @throws DataAccessException
	 */
	public List<String> selectStayDateRange(ReserveUpdateVO ruVO) throws DataAccessException {
		List<String> list = null;

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		StringBuilder select = new StringBuilder();
		select.append("	select res_no	").append("	from   reservation	")
				.append("	where  room_no= (select room_no from room where r_name= ?)	")
				.append("	 and ((to_date(?,'yyyy.mm.dd') between to_date(chkin_date,'yyyy.mm.dd') and (to_date(chkout_date,'yyyy.mm.dd')-1)) or	")
				.append("	 (to_date(chkin_date,'yyyy.mm.dd') between to_date(?,'yyyy.mm.dd') and to_date(?,'yyyy.mm.dd')-1))	")
				.append("	 and res_no != ? 	and res_status = 'Y'");

		list = jt.query(select.toString(), new Object[] { ruVO.getrName(), ruVO.getChkInDate(), ruVO.getChkInDate(),
				ruVO.getChkOutDate(), ruVO.getResNo() }, new SelectResNo());

		gjt.closeAc();

		return list;

	}// selectStayDateRange

	public class SelectResNo implements RowMapper<String> {
		@Override
		public String mapRow(ResultSet rs, int cnt) throws SQLException {
			String resNo = rs.getString("res_no");
			return resNo;
		}// mapRow
	}// SelectResNo

}// class
