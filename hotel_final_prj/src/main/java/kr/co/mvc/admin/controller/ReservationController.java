package kr.co.mvc.admin.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.mvc.admin.service.PagenationService;
import kr.co.mvc.admin.service.ReservationService;
import kr.co.mvc.admin.vo.ChkInDateVO;
import kr.co.mvc.admin.vo.ReservationUpdateVO;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService resSev;

	@Autowired
	private PagenationService pageSev;
	
	/**
	 * ������ ����
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "admin_main.do", method = {GET,POST})
	public String searchTodayRes(String page, Model model) {

		// �������� ����
		Calendar cal = Calendar.getInstance();
		int nowYear = cal.get(Calendar.YEAR);
		int nowMonth = cal.get(Calendar.MONTH) + 1;
		int nowDay = cal.get(Calendar.DAY_OF_MONTH);
		// ������ üũ�� ���ڷ� �����Ͽ� VO ����
		ChkInDateVO date = new ChkInDateVO();
		date.setYear(String.valueOf(nowYear));
		date.setMonth(String.valueOf(nowMonth));
		date.setDay(String.format("%02d", nowDay));
		
		//��û �� page�� ������ 1page�� setting
		if(page == null || "".equals(page)) {
			page = "1";
		}//end if
		
		int currentPage = pageSev.setCurrentpage(page);

		//���������̼� �۾�
		pageSev.setPageScale(10);
		model.addAttribute("totalPage", pageSev.getTotalPage(resSev.selectAllResCnt(date)));
		model.addAttribute("currentPage", currentPage);
		
		//��û ������ �ѹ��� ���� ��ȸ ���� ���ϱ�
		int startNum = pageSev.getStartNum(currentPage);
		int endNum = pageSev.getEndNum(startNum);
		
		model.addAttribute("todayList", resSev.searchRes(date, startNum, endNum));
		model.addAttribute("today", date);

		return "admin/common/admin_main";
	}// searchTodayRes
	
	/**
	 * ������� ����
	 * @param date
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "search_res_list.do", method = {GET,POST})
	public String searchRes(ChkInDateVO date, String page, Model model) {
		//��û �� page�� ������ 1page�� setting
		if(page == null || "".equals(page)) {
			page = "1";
		}//end if

		int currentPage = pageSev.setCurrentpage(page);
		
		//���������̼� �۾�
		pageSev.setPageScale(10);
		model.addAttribute("totalPage", pageSev.getTotalPage(resSev.selectAllResCnt(date)));
		model.addAttribute("currentPage", currentPage);
		
		//��û ������ �ѹ��� ���� ��ȸ ���� ���ϱ�
		int startNum = pageSev.getStartNum(currentPage);
		int endNum = pageSev.getEndNum(startNum);
		
		//���� ��ȸ �۾�
		model.addAttribute("resList", resSev.searchRes(date, startNum, endNum));
		
		return "admin/admin_reservation/admin_reservation_main";
	}// searchRes
	
	
	/**
	 * �������
	 * @param date
	 * @param delResNum
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "delete_res.do", method = POST)
	public String removeRes(ChkInDateVO date, String delResNum, Model model) {

		int result = resSev.removeRes(delResNum);
		if (result == 1) {
			model.addAttribute("delResult", true);
		} else {
			model.addAttribute("delResult", false);
		}//end else
		
		//������� �������� �̵�
		return "forward:search_res_list.do";
	}// removeRes

	 
	/**
	 * ������� form
	 * @param resNum
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "change_res_form.do", method = {GET,POST})
	public String chagneResForm(String resNum, Model model) {
		if(resNum != null && !"".equals(resNum)) {
			model.addAttribute("resNum", resNum);
			model.addAttribute("ruVO", resSev.searchOneRes(resNum));
			model.addAttribute("roomList", resSev.searchAvailableRoomList());
		}//end if
		return "admin/admin_reservation/admin_reservation_change";
	}// chagneResForm

	/**
	 * �������
	 * @param resNum
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "change_res_process.do", method = POST)
	public String chagneResProcess(ReservationUpdateVO ruVO, HttpServletRequest request,Model model) {
		boolean chkResult = true; 
		
		//���� ���� �� ���� ���� ȭ������ �̵�
		String returnPage ="forward:change_res_form.do?resNum="+ruVO.getResNo(); 
		
		//���� �ִ� ���� �ο��� ���ڱⰣ �ߺ����� üũ
		int maxGuest = resSev.searchMaxGuest(ruVO);
		int totalGuest = ruVO.getAdult() + ruVO.getChild();
		List<String> resList = resSev.searchStayDateList(ruVO);
		
		if(totalGuest > maxGuest) {
			chkResult = false;
			model.addAttribute("msg", ruVO.getrName() +"�� �ִ� �����ο��� " + maxGuest+"�� �Դϴ�.");
		} else if (!(resList.isEmpty())) {
			chkResult = false;
			model.addAttribute("msg", "�ش�Ⱓ �� �ٸ� ������ �����մϴ�.");
		}//end if 
		
		//���� ��� �� ���ຯ�� ���� �� ������ȸ ȭ������ �̵�
		int result =0;
		if(chkResult) {
			result = resSev.changeRes(ruVO);
			returnPage ="forward:search_res_list.do";
			if(result == 1) {
				model.addAttribute("updateResult", true);
			} else {
				model.addAttribute("updateResult", false);
			}//end else
		}//end if

		return returnPage;
	}//chagneResProcess
	
	
}// class
