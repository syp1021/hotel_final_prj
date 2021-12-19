package kr.co.sist.user.find;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.admin.member.MemberVO;
import kr.co.sist.dao.GetJdbcTemplate;
import kr.co.sist.user.reservation.ReservationVO;
import kr.co.sist.util.cipher.DataEncrypt;

/**
 * 아이디와 비밀번호 찾기
 * 
 * @author user
 *
 */
public class FindSelect {
	
	/**
	 * 이름과 이메일로 아이디 찾기
	 * @param kname
	 * @param email
	 * @return
	 * @throws DataAccessException
	 */
	public String findId(String kname, String email) throws DataAccessException {
		String id = null;

		String enKname = null;
		String enEmail = null;
		
		try {
			DataEncrypt de = new DataEncrypt("AbcdEfgHiJkLmnOpQ");
			enKname = de.encryption(kname);
			enEmail = de.encryption(email);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String selectId = "select id from member where kname=? and email=?";
		id = jt.queryForObject(selectId, new Object[] { enKname, enEmail }, String.class);

		gjt.closeAc();

		return id;
	}//findId

	/**
	 * 이름과 아이디와 이메일로 사용자 인증 후 임시 비밀번호 할당
	 * @param fVO
	 * @return
	 * @throws DataAccessException
	 */
	public FindVO findPass(FindVO fVO) throws DataAccessException {
		String id = fVO.getId();
		
		String enKname = null;
		String enEmail = null;
		try {
			DataEncrypt de = new DataEncrypt("AbcdEfgHiJkLmnOpQ");
			enKname = de.encryption(fVO.getKname());
			enEmail = de.encryption(fVO.getEmail());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		String selectJoin = "select join_date from member where id=? and kname=? and email=?";
		
		String joinDate 
			 = jt.queryForObject(selectJoin, new Object[] {id, enKname, enEmail }, String.class);
		
		gjt.closeAc();
		
		if(joinDate !=null) {//조회 결과가 있다면 임시 비밀번호 반환
			    char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
			    'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a',
			    'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
			    'w', 'x', 'y', 'z' };
			 
			    StringBuilder sb = new StringBuilder();

			    int temp=0;
			    for (int i = 0; i < 14; i++) {//14자리 비밀번호 생성
			        temp = (int) (charArr.length * Math.random());
			        sb.append(charArr[temp]);
			    }//end for
			    
			    fVO.setPass(sb.toString());
		}//end if
		return fVO;
	}//findPass

	
	/**
	 * 임시비밀번호로 table update
	 * @param fVO
	 * @return
	 * @throws DataAccessException
	 */
	public int updatePass(FindVO fVO) throws DataAccessException {
		int cnt = 0;
		
		String id = fVO.getId();
		String enPass=null;
		try {
			enPass = DataEncrypt.messageDigest("SHA-512", fVO.getPass());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}//end catch
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		String updatePass = "update member set pass=? where id=?";
		
		cnt = jt.update(updatePass,enPass,id);
		gjt.closeAc();
		
		return cnt;
	}//updatePass
	
	
}//class
