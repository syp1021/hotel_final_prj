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
	 * 아이디 중복 조회
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
	 * 이메일 중복 조회
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
 
			//이름 암호화
			DataEncrypt de=new DataEncrypt("AbcdEfgHiJkLmnOpQ");
			mVO.setKname(de.encryption(mVO.getKname()) );//이름
			mVO.setEname_fst(de.encryption(mVO.getEname_fst()));  //영문이름
			mVO.setEname_lst(de.encryption(mVO.getEname_lst()));//영문이름
			mVO.setEmail(de.encryption(mVO.getEmail()));//이메일
			mVO.setBirth_year(de.encryption(mVO.getBirth_year()));//생년월일
			mVO.setTel(de.encryption(mVO.getTel()));//번호
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
