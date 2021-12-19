package kr.co.sist.user.card;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class SelectCard {
	
	
	/**
	 * 조회정보가 없으면 검색이 안되므로, 그때 쓸 플래그
	 * @param card_no
	 * @return
	 * @throws SQLException
	 */
	public CardVO checkSavedCard (String id) throws SQLException{
		CardVO cdVO = null;
		
		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
						
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		// 3. 쿼리
		String checkFlag = "select nvl(max(card_no), '0') card_no from  card_info where id = ?";
		
		// interface를 anonymous inner class로 생성하여 그 안에서 조회결과를 VO에 할당
		cdVO = jt.queryForObject(checkFlag, new Object[] {id},
				new RowMapper<CardVO>() {
				@Override
					public CardVO mapRow(ResultSet rs, int rowNum) throws SQLException {
					CardVO cdVO = new CardVO();
					cdVO.setCard_no(rs.getString("card_no"));
					return cdVO;
				}
			});
	
	// 4. Spring Container 닫기
	gjt.closeAc();
	
		return cdVO;
	}//checkSavedCard
	
	
	/**
	 * 사용자 id로 기존의 저장된 카드 정보 가져오기
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public CardVO selectCardInfo ( String id) throws SQLException{
		
		CardVO cVO = null;
		
		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
				
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		// 3. 쿼리
		String selectCard = "select card_no, company, val_mm, val_yy from card_info where id = ?";
		
		// interface를 anonymous inner class로 생성하여 그 안에서 조회결과를 VO에 할당
		cVO = jt.queryForObject(selectCard, new Object[] {id},
				new RowMapper<CardVO>() {
					@Override
					public CardVO mapRow(ResultSet rs, int rowNum) throws SQLException {
						CardVO cVO = new CardVO();
						cVO.setCard_no(rs.getString("card_no"));
						cVO.setCompany(rs.getString("company"));
						cVO.setVal_mm(rs.getString("val_mm"));
						cVO.setVal_yy(rs.getString("val_yy"));
						
						
						return cVO;
					}
				});
		
		// 4. Spring Container 닫기
		gjt.closeAc();
		
		return cVO;
	}//selectCardInfo
}//class
