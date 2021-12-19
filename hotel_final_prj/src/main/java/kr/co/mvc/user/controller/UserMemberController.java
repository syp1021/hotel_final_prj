package kr.co.mvc.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.SQLException;

import kr.co.mvc.user.service.UserMemberService;
import kr.co.mvc.user.vo.UserMemberVO;

@Controller
public class UserMemberController {

	
	@Autowired(required=false)
	private UserMemberService mService;
	 
	
	@RequestMapping(value = "user/user_login/user_signup.do", method = GET)
	public String signUpForm() {
		return "user/user_login/user_signup";
	}//
	
	
	@RequestMapping(value = "user/user_login/sign_id_dup.do", method = GET)
	public String idDuplicatio(Model model, String id) throws Exception {
		model.addAttribute("resultId", mService.searchID(id));
		return "user/user_login/sign_id_dup";
	}//idDuplication
	
	
	@RequestMapping(value = "user/user_login/sign_email_dup.do", method = GET)
	public String emailDuplication(Model model, String email) throws SQLException {
		model.addAttribute("resultEmail", mService.searchEmail(email));
		return "user/user_login/sign_email_dup";
	}//emailDuplication
	
	
	@RequestMapping(value = "user/user_login/user_signup_result.do", method = POST)
	public String MemberAdd( UserMemberVO mVO, Model model ) {
		try {
			mService.addMember(mVO);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		}
		return "user/user_login/user_signup_result";
	}//MemberAdd
	
}//class
