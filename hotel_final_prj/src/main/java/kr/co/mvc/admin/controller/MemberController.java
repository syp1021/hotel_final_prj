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
	 * ȸ������ ���� <br>
	 * (����/Ż��/Ư��ȸ�� ��ȸ)
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "search_member.do", method = { GET, POST })
	public String searchActiveMember(MemberPagingVO mpVO, Model model) {
		String id = mpVO.getId();
		String page = mpVO.getPage();
		String mStatus = mpVO.getM_status();

		// ��û �� page�� ������ 1page�� setting
		if (page == null || "".equals(page)) {
			page = "1";
		} // end if
		// ó�� ��û �� �⺻�� ����ȸ������ setting
		if (mStatus == null || "".equals(mStatus)) {
			mStatus = "Y";
		} // end if

		// ���� ������ ���̼� �۾�
		int currentPage = pageSev.setCurrentpage(page);
		
		pageSev.setPageScale(10);
		model.addAttribute("currentPage", currentPage);

		// ȸ�� ���к� ��ȸ ��
		if (id == null || "".equals(id)) {
			// ��û ������ �ѹ��� ���� ��ȸ ���� ���ϱ�
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

		// Ư�� ID ��ȸ
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
	 * ȸ������
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
