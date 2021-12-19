package kr.co.sist.user.member;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.SQLException;

import kr.co.sist.util.cipher.DataDecrypt;

public class User_Decryption {

	public MemberVO DecryptSelectMemInfo (String id) throws UnsupportedEncodingException, GeneralSecurityException, SQLException {
		
		MemberVO mv = null;
		
		MemberSelect ms = new MemberSelect();
		mv = ms.selectMemInfo(id);
		DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");
			mv.setId(mv.getId());
			mv.setEmail(dd.decryption(mv.getEmail()));
			mv.setEname_fst(dd.decryption(mv.getEname_fst()));
			mv.setEname_lst(dd.decryption(mv.getEname_lst()));
			mv.setKname(dd.decryption(mv.getKname()));
			mv.setTel(dd.decryption(mv.getTel()));

		return mv;
		
		
	}//DecryptSelectMemInfo
	
	
}//class
