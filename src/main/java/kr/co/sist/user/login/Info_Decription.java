package kr.co.sist.user.login;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.SQLException;
import java.util.List;

import kr.co.sist.util.cipher.DataDecrypt;

public class Info_Decription {

	
	/**
	 *  이름,전화번호,이메일 복호화
	 * @param kname
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws GeneralSecurityException
	 * @throws SQLException
	 */
	public List<memberVO>  DecryptDeleteMemberData(String id) throws SQLException,UnsupportedEncodingException,GeneralSecurityException {
		List<memberVO> list = null;
		MemberDAO mDAO= new MemberDAO();
		list=mDAO.selectInfo(id);
		DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");
		for(memberVO mVO:list) {
			mVO.setKname(dd.decryption(mVO.getKname()));
			mVO.setTel(dd.decryption(mVO.getTel()));
			mVO.setEmail(dd.decryption(mVO.getEmail()));
		}
		return list;
	}//DecryptDeleteMemberData
	
	
}//class
