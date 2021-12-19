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
	 * 오늘의 예약
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "admin_main.do", method = {GET,POST})
	public String searchTodayRes(String page, Model model) {

		// 현재일자 설정
		Calendar cal = Calendar.getInstance();
		int nowYear = cal.get(Calendar.YEAR);
		int nowMonth = cal.get(Calendar.MONTH) + 1;
		int nowDay = cal.get(Calendar.DAY_OF_MONTH);
		// 오늘을 체크인 일자로 투입하여 VO 생성
		ChkInDateVO date = new ChkInDateVO();
		date.setYear(String.valueOf(nowYear));
		date.setMonth(String.valueOf(nowMonth));
		date.setDay(String.format("%02d", nowDay));
		
		//요청 시 page가 없으면 1page로 setting
		if(page == null || "".equals(page)) {
			page = "1";
		}//end if
		
		int currentPage = pageSev.setCurrentpage(page);

		//페이지네이션 작업
		pageSev.setPageScale(10);
		model.addAttribute("totalPage", pageSev.getTotalPage(resSev.selectAllResCnt(date)));
		model.addAttribute("currentPage", currentPage);
		
		//요청 페이지 넘버에 따른 조회 범위 구하기
		int startNum = pageSev.getStartNum(currentPage);
		int endNum = pageSev.getEndNum(startNum);
		
		model.addAttribute("todayList", resSev.searchRes(date, startNum, endNum));
		model.addAttribute("today", date);

		return "admin/common/admin_main";
	}// searchTodayRes
	
	/**
	 * 예약관리 메인
	 * @param date
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "search_res_list.do", method = {GET,POST})
	public String searchRes(ChkInDateVO date, String page, Model model) {
		//요청 시 page가 없으면 1page로 setting
		if(page == null || "".equals(page)) {
			page = "1";
		}//end if

		int currentPage = pageSev.setCurrentpage(page);
		
		//페이지네이션 작업
		pageSev.setPageScale(10);
		model.addAttribute("totalPage", pageSev.getTotalPage(resSev.selectAllResCnt(date)));
		model.addAttribute("currentPage", currentPage);
		
		//요청 페이지 넘버에 따른 조회 범위 구하기
		int startNum = pageSev.getStartNum(currentPage);
		int endNum = pageSev.getEndNum(startNum);
		
		//예약 조회 작업
		model.addAttribute("resList", resSev.searchRes(date, startNum, endNum));
		
		return "admin/admin_reservation/admin_reservation_main";
	}// searchRes
	
	
	/**
	 * 예약삭제
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
		
		//예약관리 메인으로 이동
		return "forward:search_res_list.do";
	}// removeRes

	 
	/**
	 * 예약수정 form
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
	 * 예약수정
	 * @param resNum
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "change_res_process.do", method = POST)
	public String chagneResProcess(ReservationUpdateVO ruVO, HttpServletRequest request,Model model) {
		boolean chkResult = true; 
		
		//검증 실패 시 예약 변경 화면으로 이동
		String returnPage ="forward:change_res_form.do?resNum="+ruVO.getResNo(); 
		
		//객실 최대 수용 인원과 숙박기간 중복여부 체크
		int maxGuest = resSev.searchMaxGuest(ruVO);
		int totalGuest = ruVO.getAdult() + ruVO.getChild();
		List<String> resList = resSev.searchStayDateList(ruVO);
		
		if(totalGuest > maxGuest) {
			chkResult = false;
			model.addAttribute("msg", ruVO.getrName() +"의 최대 수용인원은 " + maxGuest+"명 입니다.");
		} else if (!(resList.isEmpty())) {
			chkResult = false;
			model.addAttribute("msg", "해당기간 중 다른 예약이 존재합니다.");
		}//end if 
		
		//검증 통과 시 예약변경 수행 및 예약조회 화면으로 이동
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
