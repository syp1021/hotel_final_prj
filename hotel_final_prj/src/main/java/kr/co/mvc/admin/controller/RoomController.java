package kr.co.mvc.admin.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.mvc.admin.service.ImgUploadService;
import kr.co.mvc.admin.service.RoomService;
import kr.co.mvc.admin.vo.ImgFormVO;
import kr.co.mvc.admin.vo.OtherImgVO;
import kr.co.mvc.admin.vo.RoomVO;

@Controller
public class RoomController {

	@Autowired
	private RoomService roomSev;
	
	@Autowired
	private ImgUploadService imgSev;

	/**
	 * 객실관리 메인
	 * @param rName
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "search_room.do", method = {GET,POST})
	public String searchRoomInfo(String rName, Model model) {
		// 페이지 요청 시 temp 폴더 정리
	    if(imgSev.searchImgList() != null && imgSev.searchImgList().size() != 0) {
	    	imgSev.removeTempImg(null);
	   	}//end if
		
	    model.addAttribute("rName", rName);
	    
	    //객실메인 상단부에 나타날 전체 객실 조회
	    model.addAttribute("roomList", roomSev.searchRoomInfo(null, null));
	     
	    //특정객실 조회
	    if(rName != null || !("".equals(rName))) {
	    	model.addAttribute("rmVO", roomSev.searchRoomInfo(rName,null));
	    	model.addAttribute("imgList", roomSev.searchOtherImg(rName,null));
	    }//end if

	    return "admin/admin_room/admin_room_main";
	}// searchRoomInfo
	
	/**
	 * 객실추가 메인
	 * @return
	 */
	@RequestMapping(value = "add_room_form.do", method = {GET,POST})
	public String addRoomForm() {
		//페이지 요청 시 temp 폴더 정리
		if(imgSev.searchImgList() != null && imgSev.searchImgList().size() != 0) {
			imgSev.removeTempImg(null);
		}//end if
		
		return "admin/admin_room/admin_room_add";
	}//addRoomForm
	
	
	/**
	 * 객실추가 process
	 * @param rmVO
	 * @param imgFrmVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "add_room_process.do", method = POST)
	public String addRoomProcess(RoomVO rmVO, ImgFormVO imgFrmVO, Model model) {
		//default return page : 객실추가페이지
		String returnPage="forward:add_room_form.do";
		List<RoomVO> dupList = roomSev.searchRoomInfo(rmVO.getRoomName(),null);

		if(dupList != null) {
			if(!dupList.isEmpty()) {
				model.addAttribute("dupRNameChk", true);
				model.addAttribute("rmVO", rmVO);
			}//end if
		}//end if
		
		//중복 객실명이 없어야 insert 진행
		if(dupList == null || dupList.isEmpty()) {
			int lastRoomNo = roomSev.searchLastRoomNo();
			returnPage="forward:search_room.do";
			if((roomSev.addRoom(rmVO, lastRoomNo, imgFrmVO))&&(roomSev.addOtherImg(rmVO, imgFrmVO))) {
					imgSev.moveImgtoRoomImg();
					imgSev.removeTempImg(null);
					model.addAttribute("insertResult", true);
			} else {
				model.addAttribute("insertResult", false);
			}//end else
		}//end else
		return returnPage;
	}//addRoomProcess
	
	/**
	 * 객실정보수정 메인
	 * @param selectedRName
	 * @param imgFrmVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "change_room_form.do", method = {GET,POST})
	public String changeRoomForm(String selectedRName, ImgFormVO imgFrmVO, Model model) {
		// 페이지 요청 시 temp 폴더 정리
		if(imgSev.searchImgList() != null && imgSev.searchImgList().size() != 0) {
			imgSev.removeTempImg(null);
		}//end if
		
		if(selectedRName != null && !"".equals(selectedRName)) {
			model.addAttribute("selectedRName",selectedRName);
			//조회한 객실정보
			List<RoomVO> rList = roomSev.searchRoomInfo(selectedRName,null);
			//조회한 기타 이미지 리스트
			List<OtherImgVO> otherImgList = roomSev.searchOtherImg(selectedRName,null);
			for(RoomVO rVO : rList) {
				model.addAttribute("rVO", rVO);
			}//end for
			model.addAttribute("otherImgList", otherImgList);
			
			//DB에 등록된 메인/기타이미지를 temp폴더로 이동
			List<String> imgList = new ArrayList<String>();
			if(rList != null && !rList.isEmpty()) {
				for(RoomVO rmVO : rList) {
				imgList.add(rmVO.getImg());
				}//end for
			}//end if
			if(otherImgList != null && !otherImgList.isEmpty()) {
				for(OtherImgVO otherImg : otherImgList) {
					imgList.add(otherImg.getImgSrc());
				}//end for
			}//end if
			imgSev.moveImgtoTemp(imgList);
		}//end if
		
		return "admin/admin_room/admin_room_change";
	}//changeRoomForm
	
	
	/**
	 * 객실상태변경
	 * @param rmVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "change_roomStatus_process.do", method = GET)
	public String changeRoomStatusProcess(RoomVO rmVO, Model model) {
		if(rmVO != null && !"".equals(rmVO.getrStatus()) && !"".equals(rmVO.getRoomNum())){
			int cnt = roomSev.changeRoomStatus(rmVO);
			if(cnt == 1) {
				model.addAttribute("updateStatusResult", true);
			}else {
				model.addAttribute("updateStatusResult", false);
			}//endelse
		}//end if
		return "forward:search_room.do";
	}//changeRoomStatusProcess 
	
	
	/**
	 * 객실정보수정
	 * @param rmVO
	 * @param imgFrmVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "change_room_process.do", method = POST)
	public String changeRoomProcess(RoomVO rmVO, ImgFormVO imgFrmVO, Model model) {
		if(rmVO != null && !"".equals(rmVO.getRoomNum())){
			//중복이름객실 체크
			List<String> rNamelist = roomSev.searchDupRoomName(rmVO);
			
			if(rNamelist.isEmpty()) {
				//객실 수정 전, 기존 메인이미지,기타이미지명 수집
				List<String> dbImgList = new ArrayList<String>();
				//메인이미지
				List<RoomVO> list = roomSev.searchRoomInfo(null, rmVO.getRoomNum());
				for(RoomVO rVO : list) {
					dbImgList.add(rVO.getImg());
				}//end for
				//기타이미지
				List<OtherImgVO> otherList = roomSev.searchOtherImg(null, rmVO.getRoomNum());
				if(otherList != null && !otherList.isEmpty()) {
					for(OtherImgVO imgVO : otherList) {
						dbImgList.add(imgVO.getImgSrc());
					}//end for
				}//end if
				
				//객실 수정 프로세스
				//수정 전 rmVO 세팅
				rmVO.setImg(imgFrmVO.getMainImg());
				rmVO.setPrice(rmVO.getPrice().replace(",",""));				
				
				model.addAttribute("updateRoomResult", false);
				boolean flag1 = roomSev.changeRoom(rmVO);
				boolean flag2 = roomSev.removeAllOtherImg(rmVO);
				boolean flag3 = roomSev.addOtherImg(rmVO, imgFrmVO);
				if(flag1 && flag2 && flag3) {
					//객실수정 완료 후 파라미터설정 및 roomImg 폴더 정리
					model.addAttribute("updateRoomResult", true);
					imgSev.moveImgtoRoomImg();
					imgSev.removeRoomImg(dbImgList, imgFrmVO);
				}//end if
			}else {
				model.addAttribute("dupRNameChk", true);
			}//end else
		}//end if
		
		return "forward:search_room.do";
	}//changeRoomProcess 
	
}//class

