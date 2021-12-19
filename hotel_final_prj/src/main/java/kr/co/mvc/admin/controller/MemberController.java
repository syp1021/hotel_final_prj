package kr.co.mvc.admin.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.mvc.admin.service.MemberService;
import kr.co.mvc.admin.service.PagenationService;
import kr.co.mvc.admin.vo.MemberPagingVO;
import kr.co.mvc.admin.vo.MemberVO;

@Controller
public class MemberController {
	@Autowired
	private MemberService memSev;

	@Autowired
	private PagenationService pageSev;

	/**
	 * 회원관리 메인 <br>
	 * (정상/탈퇴/특정회원 조회)
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "search_member.do", method = { GET, POST })
	public String searchActiveMember(MemberPagingVO mpVO, Model model) {
		String id = mpVO.getId();
		String page = mpVO.getPage();
		String mStatus = mpVO.getM_status();

		// 요청 시 page가 없으면 1page로 setting
		if (page == null || "".equals(page)) {
			page = "1";
		} // end if
		// 처음 요청 시 기본값 정상회원으로 setting
		if (mStatus == null || "".equals(mStatus)) {
			mStatus = "Y";
		} // end if

		// 공통 페이지 네이션 작업
		int currentPage = pageSev.setCurrentpage(page);
		
		pageSev.setPageScale(10);
		model.addAttribute("currentPage", currentPage);

		// 회원 구분별 조회 시
		if (id == null || "".equals(id)) {
			// 요청 페이지 넘버에 따른 조회 범위 구하기
			int startNum = pageSev.getStartNum(currentPage);
			mpVO.setStartNum(startNum);
			mpVO.setEndNum(pageSev.getEndNum(startNum));
			model.addAttribute("totalPage", pageSev.getTotalPage(memSev.searchAllMemberCnt(id, mStatus)));
			model.addAttribute("radioValue", mStatus);
			
			if ("Y".equals(mStatus)) {
				model.addAttribute("acitveMemList", memSev.searchActiveMember(mpVO));
			} else {
				model.addAttribute("inacitveMemList", memSev.searchInactiveMember(mpVO));
			} // end else
		} // end if

		// 특정 ID 조회
		if (id != null && !"".equals(id)) {
			model.addAttribute("id", id);
			
			String oneMStatus = null;
			List<MemberVO> memberInfo = memSev.searchOneMemberInfo(id);
			for(MemberVO mVO : memberInfo) {
				oneMStatus = mVO.getM_status();
			}//end for
			
			model.addAttribute("radioValue", oneMStatus);
			model.addAttribute("totalPage", pageSev.getTotalPage(memSev.searchAllMemberCnt(id, oneMStatus)));
			
			if ("Y".equals(oneMStatus)) {
				model.addAttribute("acitveMemList", memberInfo);
			} else {
				model.addAttribute("inacitveMemList", memberInfo);
			} // end else
			
		} // end if

		return "/admin/admin_member/admin_member_main";
	}// searchActiveMember


	/**
	 * 회원삭제
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "delete_member.do", method = POST)
	public String deleteMember(String delId, Model model) {
		int cnt = memSev.removeMember(delId);
		if (cnt == 1) {
			model.addAttribute("delResult", true);
		} else {
			model.addAttribute("delResult", false);
		} // else
		return "forward:search_active_member.do";
	}// deleteMember

}// class
