package kr.co.mvc.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.mvc.user.service.UserReservationService;
import kr.co.mvc.user.vo.RoomVO;
import kr.co.mvc.user.vo.UserCardVO;
import kr.co.mvc.user.vo.UserMemberVO;
import kr.co.mvc.user.vo.UserReservationVO;
import kr.co.mvc.user.vo.UserRoomVO;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
public class UserReservationController {

	@Autowired
	private UserReservationService resService;
	
	@RequestMapping(value="user/user_room/room_intro.do", method=GET)
	public String reserve_intro(Model model, String rName, String rStatus) {
		int i = 0;
		model.addAttribute("roomList", resService.searchAllRooms(null, "Y"));
		model.addAttribute("newLineChar", "\n");
		model.addAttribute("imgVOList", resService.searchOtherImgs(rName, rStatus));
		model.addAttribute("cnt", resService.roomCnt(rName, rStatus));
		
		return "user/user_room/room_intro";
	}//reserve_intro
	
	@RequestMapping(value="user/user_room/ajax_room_date.do",  method = POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String ajaxReq(String start_date, String end_date, String adult,String child) {
		
		if("".equals( adult)) {
			adult="0";
		}
		if("".equals( child)) {
			child="0";
		}

		String jsonObj = resService.searchAvaileReserve(start_date, end_date,  Integer.parseInt( adult), Integer.parseInt(child));
		
		return jsonObj;
	}//ajaxReq
	
	
	@RequestMapping(value="user/user_room/room_reserve.do", method = POST)
	public String reserve_01Reserve(String start_date, String end_date,String adult, String child, String[] rev_room_num, Model model) throws ParseException {
		/*if( rev_room_num != null) {
			for(String i :rev_room_num ) {
				System.out.println("roo0------:" + i);
			}
		}*/
		
		if("".equals( adult)) {
			adult="0";
		}
		if("".equals( child)) {
			child="0";
		}
		
		Date sdFormat = new SimpleDateFormat("yyyy.MM.dd").parse(start_date);//
		Date edFormat = new SimpleDateFormat("yyyy.MM.dd").parse(end_date);
		long diffDays = (edFormat.getTime() - sdFormat.getTime() )/1000/(24*60*60);
		

		model.addAttribute("paramSd", start_date);
		model.addAttribute("paramEd", end_date);
		model.addAttribute("paramAdult", adult);
		model.addAttribute("paramChild", child);
		model.addAttribute("paramRoomNo", rev_room_num);
		model.addAttribute("diffDays", diffDays);
		
		List<UserRoomVO> listRom =new ArrayList<UserRoomVO>();
		UserRoomVO urVO=null;
		String paramR_no = null;
		
		for( String room_no: rev_room_num ) {
			urVO=resService.searchRoomInfo(Integer.parseInt(room_no));//�迭���ȣ �ϳ��� �־ ���ϳ��� ��ȸ�ؼ�
			listRom.add( urVO );//��ȸ�� ���ϳ��� ����Ʈ�� �ִ´�.
		}//end for
		
		//for�� ����Ǹ� ����Ʈ���� ���డ���� ��� ���� ����.
		model.addAttribute("searchRoom",  listRom );//��� ���� �𵨿� �־ JSP���� ����� �� �ֵ��� ���ش�.
		model.addAttribute("room_no", rev_room_num);
		
		
		return "user/user_room/room_reserve";
	}//reserve_01Reserves
	
	
	
	@RequestMapping(value="user/user_room/room_reserve2.do", method = POST)
	public String reserve_02check(String sd, String ed, String adult, String child, int room_no, Model model) throws ParseException, NumberFormatException, SQLException {
		Date sdFormat = new SimpleDateFormat("yyyy.MM.dd").parse(sd);//
		Date edFormat = new SimpleDateFormat("yyyy.MM.dd").parse(ed);
		long diffDays = (edFormat.getTime() - sdFormat.getTime() )/1000/(24*60*60);

		
		if("".equals( adult)) {
			adult="0";
		}
		if("".equals( child)) {
			child="0";
		}
		
		UserRoomVO rVO = resService.searchRoomInfo(room_no);
		int cnt = resService.searchImgCnt(room_no);
		int price = rVO.getPrice();
		int tax = (int) (price*0.21);
		int totalP = (int)(price+tax);
		int daysPrice = price*(int)diffDays;
		int daysTax = tax*(int)diffDays;
		int daysTotal = (daysPrice + daysTax);
				
		model.addAttribute("paramSd", sd);
		model.addAttribute("paramEd", ed);
		model.addAttribute("paramAdult", adult);
		model.addAttribute("paramChild", child);
		model.addAttribute("diffDays", diffDays);
		model.addAttribute("rv", rVO);
		model.addAttribute("price", price);
		model.addAttribute("daysP", daysPrice);
		model.addAttribute("daysTax", daysTax);
		model.addAttribute("daysTotal", daysTotal);
		model.addAttribute("cnt", cnt);
		model.addAttribute("imgs", resService.searchSubImgs(room_no));
		

		return "user/user_room/room_reserve2";
	}//reserve_02check
	
	
	@RequestMapping(value="user/user_room/room_reserve3_card.do", method=POST)
	public String reserve_03card(String sd, String ed, String adult, String child, int room_no, long diffDays, String addReq, String id, Model model) throws UnsupportedEncodingException, GeneralSecurityException, SQLException {

		
		// üũ�ο��� ���ϱ� (res_no�� ����)
		String year = sd.substring(0, 4);
		String month = sd.substring(5,7);
		String day = sd.substring(8,10);
		
		
		// ��ѹ� 0���� ���ڸ� �����
		String zeroRoomNo = String.format("%02d", room_no);
		String zeroDiffDays = String.format("%03d", diffDays);
		
		//�����ȣ ���� (����� - �ڼ�(3�ڸ�) -R��ѹ�)
		String strResNo = year + month + day + "-" + zeroDiffDays + "R" + zeroRoomNo;
		
		
		UserRoomVO rVO = resService.searchRoomInfo(room_no);
		UserMemberVO mVO = resService.DecryptSelectMemInfo(id);
		String savedFlag = resService.searchCardFlag(id);
		
		int price = rVO.getPrice();
		int tax = (int) (price*0.21);
		int totalP = (int)(price+tax);
		int daysPrice = price*(int)diffDays;
		int daysTax = tax*(int)diffDays;
		int daysTotal = (daysPrice + daysTax);
		
		model.addAttribute("paramSd", sd);
		model.addAttribute("paramEd", ed);
		model.addAttribute("paramAdult", adult);
		model.addAttribute("paramChild", child);
		model.addAttribute("diffDays", diffDays);
		model.addAttribute("addReq", addReq);
		model.addAttribute("rv", rVO);
		model.addAttribute("daysP", daysPrice);
		model.addAttribute("daysTax", daysTax);
		model.addAttribute("daysTotal", daysTotal);
		model.addAttribute("mv", mVO);
		model.addAttribute("saveFlag", savedFlag);
		model.addAttribute("strResNo", strResNo);
		
		 if( !savedFlag.equals("0")){//����� ������� ī�� ������ �ִٹ�
			 // ������� ī�� ���� ��������
			UserCardVO cVO = resService.searchCardInfo(id);
			String savedCard_no = cVO.getCard_no(); 
			String savedMM = cVO.getVal_mm();
			String savedYY = cVO.getVal_yy();
			String savedCompany = cVO.getCompany();
			model.addAttribute("savedCard_no", savedCard_no);
			model.addAttribute("savedMM", savedMM);
			model.addAttribute("savedYY", savedYY);
			model.addAttribute("savedCompany", savedCompany);
		} //end if
		
		return "user/user_room/room_reserve3_card";
	}//reserve_03card
	
	
	
	
	@RequestMapping(value="user/user_room/room_reserve4_final.do", method=POST)
	public String reserve_04final(String sd, String ed, String adult, String child, int room_no, long diffDays, String addReq,
					String resNo, String card_no, String cardCompany, String val_MM, String val_YY,
					String saveYN, String ccYN, String piYN, String saveFlag, String id, Model model) throws UnsupportedEncodingException, GeneralSecurityException, SQLException {
	
		
		
		UserRoomVO rVO = resService.searchRoomInfo(room_no);
		model.addAttribute("rv", rVO);
		
		int price = rVO.getPrice();
		int tax = (int) (price*0.21);
		int totalP = (int)(price+tax);
		int daysPrice = price*(int)diffDays;
		int daysTax = tax*(int)diffDays;
		int daysTotal = (daysPrice + daysTax);
		
		UserMemberVO mVO = resService.DecryptSelectMemInfo(id);
		model.addAttribute("mv", mVO);
		
		
		model.addAttribute("paramSd", sd);
		model.addAttribute("paramEd", ed);
		model.addAttribute("paramAdult", adult);
		model.addAttribute("paramChild", child);
		model.addAttribute("diffDays", diffDays);
		model.addAttribute("addReq", addReq);
		model.addAttribute("daysP", daysPrice);
		model.addAttribute("daysTax", daysTax);
		model.addAttribute("daysTotal", daysTotal);
		
		model.addAttribute("strResNo", resNo);
		model.addAttribute("room_no", room_no);
		model.addAttribute("card_no ", card_no);
		model.addAttribute("cardCompany ", cardCompany);
		model.addAttribute("val_MM ", val_MM);
		model.addAttribute("val_YY ", val_YY);
		model.addAttribute("paramCardSave ", saveYN);
		model.addAttribute("paramCcAgree ", ccYN);
		model.addAttribute("paramPiAgree ", piYN);
		model.addAttribute("saveFlag ", saveFlag);
		
		//���� insert ���� --------------------
		UserReservationVO rsVO = new UserReservationVO();
		rsVO.setRes_no(resNo);
		rsVO.setId(id);
		rsVO.setRoom_no(room_no);
		rsVO.setAdult(Integer.parseInt(adult));
		rsVO.setChild(Integer.parseInt(child));
		rsVO.setChkin_date(sd);
		rsVO.setChkout_date(ed);
		rsVO.setAdd_req(addReq);
		rsVO.setCc_agree(ccYN);
		rsVO.setPi_agree(piYN);
		rsVO.setCard_no(card_no);
		rsVO.setCompany(cardCompany);
		System.out.println("���� controller : " + rsVO + " / id : " + id);
		resService.addReservation(rsVO);
		//--------------------------------------���� insert ��
				
		// ī�������� üũ��, ���� ī�������� ���� �����
		if ( saveYN.equals("Y") && saveFlag.equals("0")){
		 // ī������ insert
			UserCardVO cardVO = new UserCardVO();
			cardVO.setCard_no(card_no);
			cardVO.setCompany(cardCompany);
			cardVO.setId(id);
			cardVO.setRes_no(resNo);
			cardVO.setVal_mm(val_MM);
			cardVO.setVal_yy(val_YY);
			//ī������ �߰�
			System.out.println("ī�������߰� : " + cardVO+ " / id : " + id);
			resService.addCardInfo(cardVO);
		}//end if
		
		// ī�������� üũ��, ���� ī�������� �ִ� �����
		if ( saveYN.equals("Y") && !saveFlag.equals("0")){
			// ī������ ����
			UserCardVO cardVO = new UserCardVO();
			cardVO.setCard_no(card_no);
			cardVO.setId(id);
			//ī������ ����
			System.out.println("ī���������� : " + cardVO);
			resService.modifyCardInfo(cardVO);
		}//end if
		
		
		
		
		
		
	return "user/user_room/room_reserve4_final";
	}//reserve_04final
	
}//class
