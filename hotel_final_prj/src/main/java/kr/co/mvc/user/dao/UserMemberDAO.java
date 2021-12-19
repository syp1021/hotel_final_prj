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
	 * ���̵� �ߺ��˻� : ���̵� DB Table�� �����ϴ���?
	 * @param id ��ȸ�� id
	 * @return ��ȸ�� id
	 * @throws SQLException
	 */
	public String selectId(String id)throws SQLException{
		String returnId="";

		String selectId="select id from member where id=?";
		try {
			//�Ѱ��� ���ڵ尡 ��ȸ�Ǹ� ��ȸ����� ������ ����
			returnId=jt.queryForObject(selectId, new Object[] {id}, String.class);
		}catch(EmptyResultDataAccessException erdae){
			//��ȸ����� ���� ������ ���ܸ� �߻�.
			returnId="";
		}//end catch

		return returnId;
	}//selectId
	
	
	/**
	 * �̸��� �ߺ��˻� : �̸����� DB Table�� �����ϴ���?
	 * @param email ��ȸ�� email
	 * @return ��ȸ�� email
	 * @throws SQLException
	 */
	public String selectEmail(String email)throws SQLException{
		String returnEmail="";

		String selectEmail="select email from member where email=?";
		try {
			//�Ѱ��� ���ڵ尡 ��ȸ�Ǹ� ��ȸ����� ������ ����
			returnEmail=jt.queryForObject(selectEmail, new Object[] {email}, String.class);
		}catch(EmptyResultDataAccessException erdae){
			//��ȸ����� ���� ������ ���ܸ� �߻�.
			returnEmail="";
		}//end catch	

		return returnEmail;
	}//selectEmail
	
	
	
	/**
	 * ȸ������ �߰�(ȸ������)
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
