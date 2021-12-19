package kr.co.sist.user.login;

import java.sql.SQLException;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.sist.dao.GetJdbcTemplate;
import kr.co.sist.user.login.MemberChgPassVO;

public class UpdateDAO {

	
	
	
	/**
	 * 비밀번호
	 * @param mVO
	 * @return
	 * @throws 
	 */
	public int updatePass(MemberChgPassVO mVO)throws DataAccessException{
		//1.Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3.쿼리문 수행.   
		String updatePass="update member set pass=? where id=? and pass=?";
		int cnt=jt.update(updatePass,mVO.getChange_pass(), mVO.getId(), mVO.getPass() );
		//4. Spring Container 닫기.
		gjt.closeAc();
		
		return cnt;
	}
	
	/**
	 * @param kname
	 * @return
	 */
	public int delmember(memberVO mVO)throws SQLException {
		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. 쿼리 실행
		String deleteRes = "update member set m_status='N', out_date = sysdate where id=? ";
		int cnt = jt.update(deleteRes, mVO.getId());
		// 4. Spring Container 닫기
		gjt.closeAc();

		return cnt;
	}// delete
	
}
