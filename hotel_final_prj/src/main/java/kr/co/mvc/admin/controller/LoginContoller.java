package kr.co.mvc.admin.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import kr.co.mvc.admin.service.LoginService;
import kr.co.mvc.admin.vo.ManagerVO;;


@Controller
@SessionAttributes("mg_id")
public class LoginContoller {
	@Autowired
	private LoginService loginSev;
	
	/**
	 * 관리자 로그인 화면 
	 * @return
	 */
	@RequestMapping(value = "admin_login_form.do", method = {GET,POST})
	public String moveAdminLoginForm() {
		return "/admin/common/admin_login";
	}// moveAdminLoginForm

	/**
	 * 관리자 로그인 수행
	 * @param mngVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "admin_login.do", method = POST)
	public String adminLoginProcess(ManagerVO mngVO, Model model) {
		String returnPage = "forward:admin_login_form.do";
		boolean loginFlag = false;
		loginFlag = loginSev.searchManagerInfo(mngVO);
		
		if(loginFlag) {
			returnPage = "forward:admin_main.do";
			model.addAttribute("mg_id",mngVO.getId());
		}else {
			model.addAttribute("loginResult", loginFlag);
		}//endelse
		
		return returnPage;
	}//adminLogin

	/**
	 * 관리자 로그아웃 수행
	 * @param ss
	 * @return
	 */
	@RequestMapping(value = "admin_logout.do")
	public String adminLogOutProcess(SessionStatus ss) {
		loginSev.adminLogout(ss);
		return "admin/common/admin_logout_view";
	}//adminLogOut

}// class
