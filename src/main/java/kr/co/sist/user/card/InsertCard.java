package kr.co.sist.user.card;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.sist.dao.GetJdbcTemplate;


public class InsertCard {

	public int insertCard (CardVO cardVO) throws DataAccessException{
		int cnt = 0;
		
		// 1. GetJdbcTemplate 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance(); // JdbcTemplate 등장
				
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		System.out.println(cnt);
		System.out.println( cardVO.getCard_no());
		
		//  쿼리문
		String insertCard = "insert into card_info (card_no, company, val_mm, val_yy, id, res_no) values( ?, ?, ?, ?, ?, ?)";
		
		// 3. 쿼리문 수행 
		cnt = jt.update(insertCard, cardVO.getCard_no(), cardVO.getCompany(), cardVO.getVal_mm(), cardVO.getVal_yy(), cardVO.getId(), cardVO.getRes_no() );
		
		// 4. 연결 끊기
		gjt.closeAc();
				
		return cnt;
		
	}//insertCard
}//class
