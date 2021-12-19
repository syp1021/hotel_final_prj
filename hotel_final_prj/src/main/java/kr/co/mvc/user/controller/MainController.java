package kr.co.mvc.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

import kr.co.mvc.user.service.MainService;

@Controller
public class MainController {
	
	@Autowired
	private MainService mainService;

	@RequestMapping(value="user/user_main/Hotel_Ritz_Seoul.do", method=GET)
	public String main(Model model) {
		model.addAttribute("mainRooms", mainService.searchMainRooms());
		
		return "user/user_main/Hotel_Ritz_Seoul";
	}//main
	
	@RequestMapping(value="user/user_room/room_date.do", method=GET)
	public String reserDate() {
		return "user/user_room/room_date";
	}//diningHTML
	
	@RequestMapping(value="user/user_main/dining.do", method=GET)
	public String diningHTML() {
		return "user/user_main/dining";
	}//diningHTML
	
	@RequestMapping(value="user/user_main/drive.do", method=GET)
	public String driveHTML() {
		return "user/user_main/drive";
	}//diningHTML
	
	@RequestMapping(value="user/user_main/specialOffer.do", method=GET)
	public String spcialHTML() {
		return "user/user_main/specialOffer";
	}//diningHTML
	
	@RequestMapping(value="user/user_main/wedding.do", method=GET)
	public String weddingHTML() {
		return "user/user_main/wedding";
	}//diningHTML
	
	
	
}//class
