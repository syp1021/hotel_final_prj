package kr.co.sist.user.images;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class ImageCount {

	/**
	 * 룸당 등록된 사진 갯수 
	 * 캐러셀 인디케이터 설정 시 사용
	 * @param room_no
	 * @return
	 * @throws EmptyResultDataAccessException
	 * @throws IncorrectResultSizeDataAccessException
	 * @throws BadSqlGrammarException
	 */
	public int selectCountImg( int room_no ) throws EmptyResultDataAccessException, IncorrectResultSizeDataAccessException, BadSqlGrammarException{
		int cnt = 0;
		
		// 1. Spring Container를 사용할 수 있는 객체 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		// 2. 쿼리문을 실행할 수 있는 객체 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		// 3. 쿼리를 수행 후 결과 얻기
		String selectCountImg = "select count(img_src) from images where room_no = ? ";
		
		cnt = jt.queryForObject(selectCountImg, new Object[] { room_no }, int.class);
				
		// 4. Spring Container 닫기
		gjt.closeAc();
		
		return cnt;
	}//selectDname
	
	
	/**
	 * 룸넘버로 서브이미지들 가져오기
	 * @param room_no
	 * @return
	 * @throws SQLException
	 */
	public List<ImagesVO> selectImages( int room_no ) throws SQLException {
		List<ImagesVO> list = null;
		
		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		// 3. 쿼리실행
		StringBuilder selectImg = new StringBuilder();
		selectImg.append
		("	select img_src").append("	from images	");
		
		// Dynamic query
		if( room_no != 0) {
			selectImg.append("	where room_no = ?	");
		}//end if
			
		if( room_no == 0) {
			// 모든 사원정보를 조회
			list = jt.query(selectImg.toString(), new SelectImg() );
		}else {
			// 부서별 사원정보를 조회
			list = jt.query(selectImg.toString(), new Object[] { Long.valueOf(room_no) }, new SelectImg() );
		}//end else
		
		
		// 4. Spring Container 닫기
		gjt.closeAc();
		
		return list;
	}//selectDeptEmp
	
	/////////////////////////////////////////////////
	public class SelectImg implements RowMapper<ImagesVO>{
		public ImagesVO mapRow(ResultSet rs, int rowNum) throws SQLException{
			ImagesVO iv = new ImagesVO();
			iv.setImg_src(rs.getString("img_src"));
			return iv;
		}//mapRow
	}
	
}//class
