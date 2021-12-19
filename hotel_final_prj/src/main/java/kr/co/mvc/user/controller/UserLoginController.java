package kr.co.mvc.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.mvc.user.service.UserLoginService;
import kr.co.mvc.user.vo.UserFindVO;
import kr.co.mvc.user.vo.UserLoginVO;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import org.eclipse.jdt.internal.compiler.classfmt.ExternalAnnotationProvider.IMethodAnnotationWalker;
import org.springframework.beans.factory.annotation.Autowired;


@Controller
public class UserLoginController {

	@Autowired(required=false)
	private UserLoginService uLogService;
	
	/**
	 * 사용자 로그인 화면
	 * @return
	 */
	@RequestMapping(value = "user/user_login/user_login.do", method = {GET,POST})
	public String userLoginForm() {
		return "/user/user_login/user_login";
	}//userLoginForm
	
	
	@RequestMapping(value = "user/user_login/user_login_process.do", method = POST)
	public String userLoginProcess(UserLoginVO uVO, Model model) {
		return "/user/user_login/user_login_result";
	}//userLoginProcess
	
	
	/**
	 * 아이디, 비밀번호 찾기 요청
	 * @return
	 */
	@RequestMapping(value = "user/user_login/user_find_form.do", method = GET)
	public String userFindForm() {
		return "/user/user_login/user_find_main";
	}//userFindForm
	
	/**
	 * 아이디 찾기
	 * @param ufVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "user/user_login/user_find_id.do", method = POST)
	public String userFindId(UserFindVO ufVO, Model model) {
		model.addAttribute("kname", ufVO.getId_kname());
		model.addAttribute("userId", uLogService.searchUserId(ufVO));
		return "/user/user_login/user_find_id_result";
	}//userFindForm
	
	/**
	 * 비밀번호 찾기
	 * @param ufVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "user/user_login/user_find_password.do", method = POST)
	public String userFindPW(UserFindVO ufVO, Model model) {
			String tempPw = uLogService.setTempPassword(ufVO);
			ufVO.setTemp_pw(tempPw);
			
			int updateCnt = 0;
			if(tempPw != null ) {
				updateCnt = uLogService.changeUserPassword(ufVO);
				if(updateCnt == 1) {
					model.addAttribute("tempPass", tempPw);
				}
			}//end if
		
		return "/user/user_login/user_find_pw_result";
	}//userFindPW
	
	
}//
