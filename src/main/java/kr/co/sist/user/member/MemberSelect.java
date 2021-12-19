package kr.co.sist.user.member;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class MemberSelect {

	public MemberVO selectMemInfo (String id) throws SQLException{
		MemberVO mv = null;
		
		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
				
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		// 3. 쿼리실행
		String selectMem = "select * from member where id = ?";
		
		// interface를 anonymous inner class로 생성하여 그 안에서 조회결과를 VO에 할당
		mv = jt.queryForObject(selectMem, new Object[] { id }, 
			new RowMapper<MemberVO>() {
				public MemberVO mapRow(ResultSet rs, int rowNum) throws SQLException{
					MemberVO mv = new MemberVO();
					mv.setId(rs.getString("id"));
					mv.setEmail(rs.getString("email"));
					mv.setPass(rs.getString("pass"));
					mv.setEname_fst(rs.getString("ename_fst"));
					mv.setEname_lst(rs.getString("ename_lst"));
					mv.setKname(rs.getString("kname"));
					mv.setBirth_year(rs.getString("birth_year"));
					mv.setTel(rs.getString("tel"));
					mv.setReq_agree(rs.getString("req_agree"));
					mv.setOpt_agree(rs.getString("opt_agree"));
					// 조회결과를 반환
					return mv;
				}
			});
		// 4. Spring Container 닫기
		gjt.closeAc();
		
		return mv;
	}//selectMemInfo
}//class
