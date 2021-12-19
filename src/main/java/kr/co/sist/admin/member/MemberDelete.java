package kr.co.sist.admin.member;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class MemberDelete {
	
	/**
	 * Å»ÅðÈ¸¿ø Á¶È¸ ( ¾ÆÀÌµð,ÀÌ¸§,Å»Åð)
	 * 
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<MemberVO> selectDeleteMember() throws SQLException {
		List<MemberVO> list = null;

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();

		JdbcTemplate jt = gjt.getJdbcTemplate();

		StringBuilder selectDeleteMember = new StringBuilder();
		selectDeleteMember.append(" select id,kname,out_date").append(" from member ").append(" where m_status= 'N' ");

		list = jt.query(selectDeleteMember.toString(), new selectDeleteMember());

		gjt.closeAc();
		return list;
	}// MemberSelect

	public class selectDeleteMember implements RowMapper<MemberVO> {
		public MemberVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			MemberVO mv = new MemberVO();
			mv.setId(rs.getString("id"));
			mv.setKname(rs.getString("kname"));
			mv.setOut_date(rs.getDate("out_date"));
			return mv;
		}
	}

}// class
