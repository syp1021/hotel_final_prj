package kr.co.sist.user.login;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.sist.dao.GetJdbcTemplate;

public class UpdateMemDAO {
	/**
	 * 전화번호,이메일,이름 수정하는 일.
	 * @param mVO
	 * @return
	 * @throws 
	 */
	public int updateMem(MemberChgVO mVO)throws DataAccessException{
		//1.Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3.쿼리문 수행.
		String updateMem="update member set kname=?,tel=?,email=? where id=?";
		int cnt= jt.update(updateMem,mVO.getKname(), mVO.getTel(), mVO.getEmail(), mVO.getId() );
		//4. Spring Container 닫기.
		gjt.closeAc();
		
		return cnt;
		}
}
