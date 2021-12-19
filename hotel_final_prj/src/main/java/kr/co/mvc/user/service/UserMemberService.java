package kr.co.mvc.user.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kr.co.mvc.user.dao.UserMemberDAO;
import kr.co.mvc.user.vo.UserMemberVO;
import kr.co.sist.util.cipher.DataEncrypt;

@Component
public class UserMemberService {
	
	@Autowired
	private UserMemberDAO memDAO;
	
	
	/**
	 * ���̵� �ߺ� ��ȸ
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public String searchID( String id) throws SQLException {
		String dupId = null;
		dupId = memDAO.selectId(id);
		return dupId;
		
	}//searchID
	
	
	/**
	 * �̸��� �ߺ� ��ȸ
	 * @param email
	 * @return
	 * @throws SQLException
	 */
	public String searchEmail( String email) throws SQLException {
		String dupEmail = null;
		dupEmail = memDAO.selectEmail(email);
		return dupEmail;
	}//searcEmail
	
	
	public void addMember( UserMemberVO mVO ) throws UnsupportedEncodingException, GeneralSecurityException {
		try {
			mVO.setPass(DataEncrypt.messageDigest("SHA-512", mVO.getPass()));
 
			//�̸� ��ȣȭ
			DataEncrypt de=new DataEncrypt("AbcdEfgHiJkLmnOpQ");
			mVO.setKname(de.encryption(mVO.getKname()) );//�̸�
			mVO.setEname_fst(de.encryption(mVO.getEname_fst()));  //�����̸�
			mVO.setEname_lst(de.encryption(mVO.getEname_lst()));//�����̸�
			mVO.setEmail(de.encryption(mVO.getEmail()));//�̸���
			mVO.setBirth_year(de.encryption(mVO.getBirth_year()));//�������
			mVO.setTel(de.encryption(mVO.getTel()));//��ȣ
			mVO.setId(mVO.getId());
			mVO.setReq_agree(mVO.getReq_agree());
			mVO.setOpt_agree(mVO.getOpt_agree());
			mVO.setJoin_date(mVO.getJoin_date());
			mVO.setOut_date(mVO.getOut_date());
			mVO.setM_status(mVO.getM_status()); 
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}//end catch
		 
		memDAO.insertMember(mVO);
		
	}//addMember

}//class
