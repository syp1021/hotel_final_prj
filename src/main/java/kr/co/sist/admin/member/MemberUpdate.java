package kr.co.sist.admin.member;

import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.sist.dao.GetJdbcTemplate;

public class MemberUpdate {

	
	
	/**
	 * 특정회원 삭제 method / update로 status N로 변경
	 * 
	 * @param kname 회원 이름
	 * @return 삭제 성공 시 1반환
	 */
	public int memberFlag(String id) {
		int cnt = 0;

		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. 쿼리 실행
		String deleteRes = "update member set 	m_status='N', out_date=sysdate	where id=?";
		cnt = jt.update(deleteRes, id);
		// 4. Spring Container 닫기
		gjt.closeAc();
		return cnt;
	}// delete
}// class
