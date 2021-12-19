package kr.co.sist.user.login;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;
/**
 * 회원에 관련된 작업.
 * 아이디 중복체크, 회원가입처리, 로그인 처리
 * 비밀번호 변경, 회원정보 변경
 * @author user
 *
 */
public class MemberDAO {

	/**
	 * 아이디 중복검사 : 아이디가 DB Table에 존재하는지?
	 * @param id 조회할 id
	 * @return 조회된 id
	 * @throws SQLException
	 */
	public String selectId(String id)throws SQLException{
		String returnId="";
		
		//1.Spring Container얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2.JdbcTemplate얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3.쿼리 실행.
		String selectId="select id from member where id=?";
		try {
			//한건의 레코드가 조회되면 조회결과가 변수에 저장
			returnId=jt.queryForObject(selectId, new Object[] {id}, String.class);
		}catch(EmptyResultDataAccessException erdae){
			//조회결과가 없을 때에는 예외를 발생.
			returnId="";
		}//end catch
		
		//4.Spring Container 닫기
		gjt.closeAc();
		return returnId;
	}//selectId
	
	/**
	 * 이메일 중복검사 : 이메일이 DB Table에 존재하는지?
	 * @param email 조회할 email
	 * @return 조회된 email
	 * @throws SQLException
	 */
	public String selectEmail(String email)throws SQLException{
		String returnEmail="";
		
		//1.Spring Container얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2.JdbcTemplate얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3.쿼리 실행.
		String selectEmail="select email from member where email=?";
		try {
			//한건의 레코드가 조회되면 조회결과가 변수에 저장
			returnEmail=jt.queryForObject(selectEmail, new Object[] {email}, String.class);
		}catch(EmptyResultDataAccessException erdae){
			//조회결과가 없을 때에는 예외를 발생.
			returnEmail="";
		}//end catch	
		//4.Spring Container 닫기
		gjt.closeAc();
		return returnEmail;
	}//selectEmail
	
	/**
	 * 회원정보 추가
	 * @param mVO 웹 파라메터 값을 가진 VO
	 * @throws DataAccessException
	 */
	public void insertMember(memberVO mVO)throws DataAccessException{
		//1.스프링 컨테이너 생성
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3.쿼리문 수행.
		String insertMember="insert into member(id,email,pass,ename_fst,ename_lst,kname,birth_year,tel,req_agree,opt_agree,m_status)values(?,?,?,?,?,?,?,?,?,?,?)";
		jt.update(insertMember,mVO.getId(),mVO.getEmail(),mVO.getPass(),mVO.getEname_fst(),mVO.getEname_lst(),mVO.getKname(),mVO.getBirth_year()
				,mVO.getTel(),mVO.getReq_agree(),mVO.getOpt_agree(),mVO.getM_status());
		//4.스프링 컨테이너 닫기.
		gjt.closeAc();
	}//insertMember
	
	/**
	 * 아이디와 비밀번호를 입력받아 이름을 조회하는 일.
	 * @param mVO
	 * @return
	 * @throws SQLException
	 */
	public String selectLogin(memberVO mVO)throws DataAccessException{
		String kname="";//이름은 AES 암호화되어있다.
		//1.Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3.쿼리문 수행.
		String selectId="select kname from member where id=? and pass=? and m_status='Y'";
		kname=
			jt.queryForObject(selectId, new Object[] {mVO.getId(),mVO.getPass()},String.class );
		//4. Spring Container 닫기.
		gjt.closeAc();
		
		return kname;
	}
	/**
	 * 비밀번호를 입력받아 이름을 조회하는 일.
	 * @param mVO
	 * @return
	 * @throws SQLException
	 */
	public String selectPass(memberVO mVO)throws SQLException{
		String pass="";
		//1.Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3.쿼리문 수행.
		String selectpass="select pass from member where pass=?";
		pass=
			jt.queryForObject(selectpass, new Object[] {mVO.getPass()},String.class );
		//4. Spring Container 닫기.
		gjt.closeAc();
		
		return pass;
	}
	
	/**
	 * 비밀번호를 입력받아 아이디를 조회하는 일.
	 * @param mVO
	 * @return
	 * @throws SQLException
	 */
	public String selectId(memberVO mVO)throws SQLException{
		String id="";
		//1.Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3.쿼리문 수행.
		String selectpass="select pass from member where id=?";
		id=
				jt.queryForObject(selectpass, new Object[] {mVO.getPass()},String.class );
		//4. Spring Container 닫기.
		gjt.closeAc();
		
		return id;
	}
	
	/**
	 * 회원정보 이름, 전화번호,이메일 조회
	 * @param mVO
	 * @return
	 * @throws SQLException
	 */
	
	public List<memberVO>selectInfo(String id) throws SQLException{
		List<memberVO> list =null;
		//1.Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3.쿼리문 수행.
		String selectpass="select kname,tel,email from member where id=?";
		list=	jt.query(selectpass.toString(), new Object[] {id}, new RowMapper<memberVO>() {
			public memberVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				memberVO mVO = new memberVO();
				mVO.setKname(rs.getString("kname"));
				mVO.setTel(rs.getString("tel"));
				mVO.setEmail(rs.getString("email"));
				return mVO;
			}
		});
		//4. Spring Container 닫기.
		gjt.closeAc();
		return list;
	}
	
}//class
