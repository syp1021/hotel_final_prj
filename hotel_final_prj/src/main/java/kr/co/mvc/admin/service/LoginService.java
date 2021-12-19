package kr.co.mvc.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.SessionStatus;

import kr.co.mvc.admin.dao.LoginDAO;
import kr.co.mvc.admin.vo.ManagerVO;

@Component
public class LoginService {
	@Autowired
	private LoginDAO loginDAO;
	
	/**
	 * 관리자 로그인
	 * @param mngVO
	 * @return
	 */
	public boolean searchManagerInfo(ManagerVO mngVO) {
		boolean loginFlag = false;
		try {
			loginFlag = loginDAO.selectManagerInfo(mngVO);
		}catch(DataAccessException dae) {
			dae.printStackTrace();
		}//catch
		return loginFlag;
	}//searchManagerInfo
	
	
	/**
	 * 관리자 로그아웃
	 * @param ss
	 * @return
	 */
	public void adminLogout(SessionStatus ss) {
		ss.setComplete();
	}//adminLogout
	
}//class
 