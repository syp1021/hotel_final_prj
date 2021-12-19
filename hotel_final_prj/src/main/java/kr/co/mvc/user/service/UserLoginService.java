package kr.co.mvc.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import kr.co.mvc.user.dao.UserLoginDAO;
import kr.co.mvc.user.vo.UserFindVO;

@Component
public class UserLoginService {

	@Autowired
	private UserLoginDAO loginDAO;
	
	public String searchUserId(UserFindVO ufVO) {
		String userId="";
	
		try {
			userId = loginDAO.selectUserId(ufVO);
			userId = userId.substring(0,userId.length()-2)+"**";
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//catch
		
		return userId;
	}//searchUserId
	
	/**
	 * 비밀번호 찾기 전, 이름과 아이디와 이메일로 사용자 인증<br>
	 * 인증되었다면 임시비밀번호 발급
	 * @param fVO
	 * @return
	 * @throws DataAccessException
	 */
	public String setTempPassword(UserFindVO ufVO) {
		String joinDate = null;
		String tempPw = null;
		
		try {
			joinDate = loginDAO.selectUserRecord(ufVO);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//catch
		
		if(joinDate != null) {//조회 결과가 있다면 임시 비밀번호 반환
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
			    
			    tempPw = sb.toString();
		}//end if
		return tempPw;
	}//setTempPassword
	
	
	/**
	 * 임시비밀번호로 테이블 업데이트
	 * @param ufVO
	 * @return
	 */
	public int changeUserPassword(UserFindVO ufVO) {
		int cnt = 0;
		try {
			cnt = loginDAO.updateUserPassword(ufVO);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//end catch
		return cnt;
	}//changeUserPassword
	
}//UserLoginService
