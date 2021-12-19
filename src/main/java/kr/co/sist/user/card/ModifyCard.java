package kr.co.sist.user.card;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.sist.dao.GetJdbcTemplate;


public class ModifyCard {

	/**
	 * 사용자의 id로 카드번호 업데이트
	 * @param cVO
	 * @return
	 * @throws DataAccessException
	 */
	public int updateCard ( CardVO cVO ) throws DataAccessException{
		int cnt = 0;
		
		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
				
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
				
		// 3. 쿼리 실행
		String updateCard = "update card_info set card_no = ? where id = ?";
		cnt = jt.update(updateCard, cVO.getCard_no(), cVO.getId() );
		return cnt;
	}//updateCard
	
}//class
