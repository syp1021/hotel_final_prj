package kr.co.mvc.admin.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import kr.co.mvc.admin.vo.ManagerVO;

@Component
public class LoginDAO {

	@Autowired(required = false)
	private JdbcTemplate jt;

	/**
	 * 관리자 로그인 수행
	 * @param mngVO
	 * @return
	 */
	public boolean selectManagerInfo(ManagerVO mngVO) throws DataAccessException{
		boolean flag = false;

		if(mngVO != null && !"".equals(mngVO.getId())) {
			StringBuilder selectLogin = new StringBuilder();
			selectLogin.append("select mg_id").append(" from manager").append(" where mg_id=? and pass=?");
			String mg_id = jt.queryForObject(selectLogin.toString(),
					new Object[] { mngVO.getId(), mngVO.getPassword() }, String.class);
			if(!"".equals(mg_id)) {
				flag = true;
			}//end if
		} // endif
		
		return flag;
	}// selectManagerInfo

}// class
