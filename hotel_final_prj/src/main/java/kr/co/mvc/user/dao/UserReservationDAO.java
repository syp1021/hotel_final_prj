package kr.co.mvc.user.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import kr.co.mvc.admin.vo.OtherImgVO;
import kr.co.mvc.admin.vo.RoomVO;
import kr.co.mvc.user.vo.ImagesVO;
import kr.co.mvc.user.vo.UserCardVO;
import kr.co.mvc.user.vo.UserMemberVO;
import kr.co.mvc.user.vo.UserReservationVO;
import kr.co.mvc.user.vo.UserRoomVO;


@Component
public class UserReservationDAO {

	@Autowired(required = false)
	private JdbcTemplate jt;
	
	/**
	 * 등록된 모든 room 상세정보 조회
	 * @param rName
	 * @param rStatus
	 * @return
	 * @throws DataAccessException
	 */
	public List<RoomVO> selectRoomInfo(String rName, String rStatus) throws DataAccessException {
		List<RoomVO> roomList = null;

		StringBuilder select = new StringBuilder("select * from room");
		
		//파라미터가 들어왔을 때 조건문 추가 
		if(rName!=null && rStatus !=null){
			select.append("		where	r_name='")
					.append(rName)
					.append("'	and	")
					.append("r_status='")
					.append(rStatus)
					.append("'");
		}//end if
		
		if (rName != null && rStatus == null) { 
			select.append("		where	r_name='")
			.append(rName)
			.append("'");
		} // end if
		
		if (rName == null && rStatus != null) { 
			select.append("		where	r_status='")
			.append(rStatus)
			.append("'");
		} // end if

		roomList = jt.query(select.toString(), new selectRoomInfo());



		//room_no대로 정렬
		if(roomList!=null) {
		Collections.sort(roomList, new CompareRNoAsc());
		}
		
		return roomList;
	}// selectRoomInfo
	
	/**
	 * List<RoomVO>에서 room no 순서대로 정렬하는 inner Class
	 * @author user
	 */
	public class CompareRNoAsc implements Comparator<RoomVO> {
		@Override
		public int compare(RoomVO o1, RoomVO o2) {
			return o1.getRoomNum().compareTo(o2.getRoomNum());
		}
	}// class
	
	/* selectRoomInfo에서 조회된 객실 정보를 담을 inner class
	 * @author user
	 */
	public class selectRoomInfo implements RowMapper<RoomVO> {
		public RoomVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			RoomVO rmVO = new RoomVO();
			rmVO.setrStatus(rs.getString("r_status"));
			rmVO.setRoomNum(rs.getString("room_no"));
			rmVO.setRoomName(rs.getString("r_name"));
			rmVO.setMainDesc(rs.getString("description"));
			rmVO.setType(rs.getString("bed_type"));
			rmVO.setRoomSize(rs.getString("r_size"));
			rmVO.setView(rs.getString("r_view"));
			rmVO.setChkIn(rs.getString("chkin_time"));
			rmVO.setChkOut(rs.getString("chkout_time"));
			rmVO.setSpecialServ(rs.getString("service"));
			rmVO.setGeneralAmn(rs.getString("amnt_gen"));
			rmVO.setBathAmn(rs.getString("amnt_bath"));
			rmVO.setOtherAmn(rs.getString("amnt_other"));
			rmVO.setMoreInfo(rs.getString("more_info"));
			rmVO.setImg(rs.getString("main_img"));
			rmVO.setInputDate(rs.getString("input_date"));
			String price = new DecimalFormat("#,###").format(rs.getInt("price"));
			rmVO.setPrice(price);
			rmVO.setGuestNum(rs.getString("max_guest"));
			
			return rmVO;
		}// mapRow

	}// selectRes
	

//-----------------------------------------------------------------------------	
	/**
	 * images 테이블에서 룸별 이미지 조회
	 * @param rName
	 * @return
	 * @throws DataAccessException
	 */
	public List<OtherImgVO> selectOtherImg(String rName) throws DataAccessException {
		List<OtherImgVO> imgList = null;

		StringBuilder select = new StringBuilder();

		select.append(" 	select * 	from   images")
				.append(" 	where  room_no = (select room_no")
									.append(" 	 from room	")
									.append(" 	 where r_name=?)");	
		
			imgList = jt.query(select.toString(), new Object[] {rName}, 
					new RowMapper<OtherImgVO>() {
						public OtherImgVO mapRow(ResultSet rs, int rowNum) throws SQLException  {
							OtherImgVO imgVO = new OtherImgVO();
							imgVO.setImgNo(rs.getInt("img_no"));
							imgVO.setRoomNo(rs.getInt("room_no"));
							imgVO.setImgSrc(rs.getString("img_src"));
							return imgVO;
						}//mapRow
			});

		return imgList;
	}// selectOtherImg
	
//--------------------------------------------------------------------------------------------------
	
	public List<UserRoomVO> selectAvaileReserve(String start_date, String end_date, int adult, int child)
			throws SQLException{
		
		List<UserRoomVO> rList = null;
	
				   
		//쿼리실행
		StringBuilder selectAvailReserve = new StringBuilder();
		selectAvailReserve
		.append("	select 	room_no, room.r_status, room.r_name, room.max_guest, room.description, room.price, room.main_img	")
		.append("	from room	")
		.append("	where room_no not in ")
		.append("	(select room.room_no	")
		.append("	from  room room, reservation res	")
		.append("	where (res.room_no=room.room_no)	")
		.append("	and (  (to_date(chkin_date,'yyyy.mm.dd')<=to_date(?,'yyyy.mm.dd')	")
		.append("	and to_date(chkout_date,'yyyy.mm.dd') >= to_date(?,'yyyy.mm.dd')))	")
		.append(" 	)	")
		.append("	and ((to_number(?) + nvl(to_number(?),0) ) <= room.max_guest)	")
		.append("   and(room.r_status = 'Y')"	);
		// 날짜에 해당하는 값이 없고,
		// 최대 인원수보다 작거나 같은 방
		// adult, child 파라메터를 String형으로 받아오기 때문에, 연산가능한 number로 형변환한다.
		// 어린이 0 명일때를 고려하여 nvl 사용
		
		
		rList = jt.query(selectAvailReserve.toString(), new Object[] { start_date, end_date, adult, child },
				new RowMapper<UserRoomVO>() {

					@Override
					public UserRoomVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
						UserRoomVO rVO = new UserRoomVO();
						rVO.setR_name(rs.getString("r_name"));
						rVO.setRoom_no(rs.getInt("room_no"));
						rVO.setR_status(rs.getString("r_status"));
						rVO.setMax_guest(rs.getInt("max_guest"));
						rVO.setDescription(rs.getString("description"));
						rVO.setPrice(rs.getInt("price"));
						rVO.setMain_img(rs.getString("main_img"));
						return rVO;
					}
		});

		return rList;	
	}//selectAvailReserve
	
	
	/**
	 * 하나의 객실정보 얻어오기 하나의 객실정보인데 왜 List가 반환형이에요? 여러값이 있어여요 room_no = ?는 PK아니에요? 맞습닏가 그럼 조회결과는 하나가 나오죠
	 * @param room_no
	 * @return
	 * @throws SQLException
	 */
	public UserRoomVO selectRoomInfo( int room_no ) throws SQLException{

		UserRoomVO rList = null;
		
		// 3. 쿼리 실행
		String select = "select r_name, description, bed_type, max_guest, r_size, chkin_time, chkout_time, r_view, "
				+ "amnt_gen, amnt_bath, amnt_other, main_img, price from room where room_no = ?";
		
		// interface를 anonymous inner class로 생성하여 그 안에서 조회결과를 VO에 할당
		rList = jt.queryForObject(select, new Object[] { room_no }, 
				new RowMapper<UserRoomVO>() {
				public UserRoomVO mapRow(ResultSet rs, int rowNum) throws SQLException{
					UserRoomVO rv = new UserRoomVO();
						// ResultSet을 사용하여 조회결과를 VO에 저장
						rv.setR_name(rs.getString("r_name"));
						rv.setDescription(rs.getString("description"));
						rv.setBed_type(rs.getString("bed_type"));
						rv.setMax_guest(rs.getInt("max_guest"));
						rv.setR_view(rs.getString("r_view"));
						rv.setR_size(rs.getString("r_size"));
						rv.setChkin_time(rs.getString("chkin_time"));
						rv.setChkout_time(rs.getString("chkout_time"));
						rv.setAmnt_gen(rs.getString("amnt_gen"));
						rv.setAmnt_bath(rs.getString("amnt_bath"));
						rv.setAmnt_other(rs.getString("amnt_other"));
						rv.setMain_img(rs.getString("main_img"));
						rv.setPrice(rs.getInt("price"));

						// 조회결과를 저장한 dv 반환
						return rv;
					}
				});
		rList.setRoom_no(room_no);

		return rList;
	}//selectRoomInfo
	
	
	/**
	 * 룸당 등록된 사진 갯수 
	 * 캐러셀 인디케이터 설정 시 사용
	 * @param room_no
	 * @return
	 * @throws EmptyResultDataAccessException
	 * @throws IncorrectResultSizeDataAccessException
	 * @throws BadSqlGrammarException
	 */
	public int selectCountImg( int room_no ) throws EmptyResultDataAccessException, IncorrectResultSizeDataAccessException, BadSqlGrammarException{
		int cnt = 0;

		String selectCountImg = "select count(img_src) from images where room_no = ? ";
		
		cnt = jt.queryForObject(selectCountImg, new Object[] { room_no }, int.class);

		return cnt;
	}//selectCountImg
	
	/**
	 * 룸넘버로 서브이미지들 가져오기(캐러셀)
	 * @param room_no
	 * @return
	 * @throws SQLException
	 */
	public List<ImagesVO> selectSubImages( int room_no ) throws SQLException {
		List<ImagesVO> list = null;
		
		// 3. 쿼리실행
		StringBuilder selectImg = new StringBuilder();
		selectImg.append
		("	select img_src").append("	from images	");
		
		// Dynamic query
		if( room_no != 0) {
			selectImg.append("	where room_no = ?	");
		}//end if
			
		if( room_no == 0) {
			
			list = jt.query(selectImg.toString(), new SelectImg() );
		}else {
			
			list = jt.query(selectImg.toString(), new Object[] { Long.valueOf(room_no) }, new SelectImg() );
		}//end else

		return list;
	}//selectImages
	
	/////////////////////////////////////////////////
	public class SelectImg implements RowMapper<ImagesVO>{
		public ImagesVO mapRow(ResultSet rs, int rowNum) throws SQLException{
			ImagesVO iv = new ImagesVO();
			iv.setImg_src(rs.getString("img_src"));
			return iv;
		}//mapRow
	}

	
//--------------------------------------------------------------------------------
	/**
	 * id로 회원정보 조회하기
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public UserMemberVO selectMemAllInfo (String id) throws SQLException{
		UserMemberVO mv = null;
		
		String selectMem = "select * from member where id = ?";
		
		// interface를 anonymous inner class로 생성하여 그 안에서 조회결과를 VO에 할당
		mv = jt.queryForObject(selectMem, new Object[] { id }, 
			new RowMapper<UserMemberVO>() {
				public UserMemberVO mapRow(ResultSet rs, int rowNum) throws SQLException{
					UserMemberVO mv = new UserMemberVO();
					mv.setId(rs.getString("id"));
					mv.setEmail(rs.getString("email"));
					mv.setPass(rs.getString("pass"));
					mv.setEname_fst(rs.getString("ename_fst"));
					mv.setEname_lst(rs.getString("ename_lst"));
					mv.setKname(rs.getString("kname"));
					mv.setBirth_year(rs.getString("birth_year"));
					mv.setTel(rs.getString("tel"));
					mv.setReq_agree(rs.getString("req_agree"));
					mv.setOpt_agree(rs.getString("opt_agree"));
					// 조회결과를 반환
					return mv;
				}
			});
		return mv;
	}//selectMemInfo
	
	
	/**
	 * 조회정보가 없으면 검색이 안되므로, 그때 쓸 플래그
	 * @param card_no
	 * @return
	 * @throws SQLException
	 */
	public UserCardVO selectSavedCard (String id) throws SQLException{
		UserCardVO cdVO = null;

		String checkFlag = "select nvl(max(card_no), '0') card_no from  card_info where id = ?";
		
		// interface를 anonymous inner class로 생성하여 그 안에서 조회결과를 VO에 할당
		cdVO = jt.queryForObject(checkFlag, new Object[] {id},
				new RowMapper<UserCardVO>() {
				@Override
					public UserCardVO mapRow(ResultSet rs, int rowNum) throws SQLException {
					UserCardVO cdVO = new UserCardVO();
					cdVO.setCard_no(rs.getString("card_no"));
					return cdVO;
				}
			});

		return cdVO;
	}//checkSavedCard
	
	
	/**
	 * 사용자 id로 기존의 저장된 카드 정보 가져오기
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public UserCardVO selectCardInfo ( String id) throws SQLException{
		
		UserCardVO cVO = null;
		
		String selectCard = "select card_no, company, val_mm, val_yy from card_info where id = ?";
		
		// interface를 anonymous inner class로 생성하여 그 안에서 조회결과를 VO에 할당
		cVO = jt.queryForObject(selectCard, new Object[] {id},
				new RowMapper<UserCardVO>() {
					@Override
					public UserCardVO mapRow(ResultSet rs, int rowNum) throws SQLException {
						UserCardVO cVO = new UserCardVO();
						cVO.setCard_no(rs.getString("card_no"));
						cVO.setCompany(rs.getString("company"));
						cVO.setVal_mm(rs.getString("val_mm"));
						cVO.setVal_yy(rs.getString("val_yy"));

						return cVO;
					}
				});
		
	
		return cVO;
	}//selectCardInfo
	
	
	/**
	 * 예약추가
	 * @param rsVO
	 * @throws DataAccessException
	 */
	public void insertRes ( UserReservationVO rsVO ) throws DataAccessException{

		String insertRes = "insert into reservation (res_no, id, room_no, adult, child, "
				+ "chkin_date, chkout_date, add_req, cc_agree, pi_agree, res_date, res_status, card_no, company)"
				+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate, 'Y', ?, ? )";
		System.out.println(rsVO);
		// 쿼리문 수행
		int cnt = jt.update(insertRes, rsVO.getRes_no(), rsVO.getId(), rsVO.getRoom_no(), rsVO.getAdult(),
				rsVO.getChild(), rsVO.getChkin_date(), rsVO.getChkout_date(), rsVO.getAdd_req(), rsVO.getCc_agree(),
				rsVO.getPi_agree(), rsVO.getCard_no(), rsVO.getCompany());

	}//insertRes
	
	
	/**
	 * 카드정보추가
	 * @param cardVO
	 * @return
	 * @throws DataAccessException
	 */
	public void  insertCardInfo (UserCardVO cardVO) throws DataAccessException{

		String insertCard = "insert into card_info (card_no, company, val_mm, val_yy, id, res_no) values( ?, ?, ?, ?, ?, ?)";

		int cnt = jt.update(insertCard, cardVO.getCard_no(), cardVO.getCompany(), cardVO.getVal_mm(), cardVO.getVal_yy(), cardVO.getId(), cardVO.getRes_no() );

	}//insertCard
	
	
	/**
	 * 사용자의 id로 카드번호 업데이트
	 * @param cVO
	 * @return
	 * @throws DataAccessException
	 */
	public void updateCard ( UserCardVO cardVO ) throws DataAccessException{

		String updateCard = "update card_info set card_no = ? where id = ?";
		int cnt = jt.update(updateCard, cardVO.getCard_no(), cardVO.getId() );

	}//updateCard
	
}//class
