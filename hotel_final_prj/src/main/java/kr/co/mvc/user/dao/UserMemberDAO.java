package kr.co.mvc.user.dao;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import kr.co.mvc.user.vo.UserMemberVO;

@Component
public class UserMemberDAO {
	
	@Autowired(required = false)
	private JdbcTemplate jt;
	
	/**
	 * 아이디 중복검사 : 아이디가 DB Table에 존재하는지?
	 * @param id 조회할 id
	 * @return 조회된 id
	 * @throws SQLException
	 */
	public String selectId(String id)throws SQLException{
		String returnId="";

		String selectId="select id from member where id=?";
		try {
			//한건의 레코드가 조회되면 조회결과가 변수에 저장
			returnId=jt.queryForObject(selectId, new Object[] {id}, String.class);
		}catch(EmptyResultDataAccessException erdae){
			//조회결과가 없을 때에는 예외를 발생.
			returnId="";
		}//end catch

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

		String selectEmail="select email from member where email=?";
		try {
			//한건의 레코드가 조회되면 조회결과가 변수에 저장
			returnEmail=jt.queryForObject(selectEmail, new Object[] {email}, String.class);
		}catch(EmptyResultDataAccessException erdae){
			//조회결과가 없을 때에는 예외를 발생.
			returnEmail="";
		}//end catch	

		return returnEmail;
	}//selectEmail
	
	
	
	/**
	 * 회원정보 추가(회원가입)
	 * @param mVO
	 * @throws DataAccessException
	 */
	public void insertMember(UserMemberVO mVO)throws DataAccessException{
		
		String insertMember="insert into member(id,email,pass,ename_fst,ename_lst,kname,birth_year,tel,req_agree,opt_agree,m_status)values(?,?,?,?,?,?,?,?,?,?,?)";
		int i=jt.update(insertMember,mVO.getId(),mVO.getEmail(),mVO.getPass(),mVO.getEname_fst(),mVO.getEname_lst(),mVO.getKname(),mVO.getBirth_year()
				,mVO.getTel(),mVO.getReq_agree(),mVO.getOpt_agree(),mVO.getM_status());
		System.out.println("------"+i);

	}//insertMember

	
	
}//class
