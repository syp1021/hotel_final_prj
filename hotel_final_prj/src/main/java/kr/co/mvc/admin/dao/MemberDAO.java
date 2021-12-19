package kr.co.mvc.admin.dao;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import kr.co.mvc.admin.vo.ChkInDateVO;
import kr.co.mvc.admin.vo.MemberPagingVO;
import kr.co.mvc.admin.vo.MemberVO;
import kr.co.sist.util.cipher.DataDecrypt;

@Component
public class MemberDAO {

	@Autowired(required = false)
	private JdbcTemplate jt;

	/**
	 * 정상회원 조회
	 * 
	 * @param id
	 * @param startNum
	 * @param endNum
	 * @return
	 * @throws DataAccessException
	 */
	public List<MemberVO> selectActiveMember(MemberPagingVO mpVO) throws DataAccessException {
		List<MemberVO> list = null;

		String id = mpVO.getId();
		
		StringBuilder selectMember = new StringBuilder();
		selectMember.append(
				"	select 	id,kname,birth_year,tel,email,ename_fst,ename_lst, to_char(join_date,'yyyy.mm.dd') join_date, r_num")
				.append("	from (").append("		select 	row_number() over(order by join_date desc)r_num,")
				.append("				id,kname,birth_year,tel,email,ename_fst,ename_lst,join_date")
				.append("		from 	member		where   m_status='Y' ");

		if (id != null && !"".equals(id)) {// id가 들어왔으면 조건 추가
			selectMember.append("	and	id='").append(id).append("'");
		} // end if

		selectMember.append(") where r_num between ? and ?");

		list = jt.query(selectMember.toString(), new Object[] {mpVO.getStartNum(),mpVO.getEndNum()}, new RowMapper<MemberVO>() {
			@Override
			public MemberVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberVO mVO = new MemberVO();
				try {
					DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");
					mVO.setId(rs.getString("id"));
					mVO.setKname(dd.decryption(rs.getString("kname")));
					mVO.setBirth_year(dd.decryption(rs.getString("birth_year")));
					mVO.setTel(dd.decryption(rs.getString("tel")));
					mVO.setEmail(dd.decryption(rs.getString("email")));
					mVO.setEname_fst(dd.decryption(rs.getString("ename_fst")));
					mVO.setEname_lst(dd.decryption(rs.getString("ename_lst")));
					mVO.setJoin_date(rs.getString("join_date"));
					mVO.setrNum(rs.getString("r_num"));
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				} catch (GeneralSecurityException e) {
					e.printStackTrace();
				} // end catch
				return mVO;
			}// mapRow
		});
		return list;
	}// selectActiveMember

	/**
	 * 탈퇴회원 조회
	 * @param id
	 * @param startNum
	 * @param endNum
	 * @return
	 * @throws DataAccessException
	 */
	public List<MemberVO> selectInactiveMember(MemberPagingVO mpVO) throws DataAccessException {
		List<MemberVO> list = null;

		String id = mpVO.getId();
		
		StringBuilder selectMember = new StringBuilder();

		selectMember.append("	select 	id,kname, to_char(out_date,'yyyy.mm.dd') out_date, r_num ")
				.append("	from (")
				.append("		select 	row_number() over(order by out_date desc)r_num,")
				.append("				id,kname,out_date")
				.append("		from 	member		where   m_status= 'N' ");

		if (id != null && !"".equals(id)) {// id가 들어왔으면 조건 추가
			selectMember.append("	and	id='").append(id).append("'");
		} // end if

		selectMember.append(") where r_num between ? and ?");

		list = jt.query(selectMember.toString(), new Object[] { mpVO.getStartNum(), mpVO.getEndNum() }, new RowMapper<MemberVO>() {

			@Override
			public MemberVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberVO mVO = new MemberVO();
				try {
					DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");
					mVO.setId(rs.getString("id"));
					mVO.setKname(dd.decryption(rs.getString("kname")));
					mVO.setOut_date(rs.getString("out_date"));
					mVO.setrNum(rs.getString("r_num"));
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				} catch (GeneralSecurityException e) {
					e.printStackTrace();
				} // end catch
				return mVO;
			}// mapRow
		});
		return list;
	}// selectInactiveMember

	/**
	 * 페이지네이션에 사용할 전체 레코드 조회
	 * 
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int selectAllMemberCnt(String id, String status) throws DataAccessException {
		int allMemCnt = 0;

		StringBuilder selectMember = new StringBuilder();
		selectMember.append("		select 	count(id)").append("		from 	member		where   m_status=?");

		if (id != null && !"".equals(id)) {// id가 들어왔으면 조건 추가
			selectMember.append("	and	id='").append(id).append("'");
		} // end if
		allMemCnt = jt.queryForObject(selectMember.toString(), new Object[] { status }, Integer.class);

		return allMemCnt;
	}// selectAllMemberCnt
	
	/**
	 * 특정 ID의 정보 조회
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public List<MemberVO> selectOneMemberInfo(String id) throws DataAccessException {
		List<MemberVO> list = null;

		StringBuilder selectOneMember = new StringBuilder();
		selectOneMember.append("	select 	id,kname,birth_year,tel,email,ename_fst,ename_lst,m_status,")
				.append("to_char(join_date,'yyyy.mm.dd') join_date, to_char(out_date,'yyyy.mm.dd') out_date")
				.append("		from 	member		where   id='")
				.append(id)
				.append("'");

		list = jt.query(selectOneMember.toString(), new RowMapper<MemberVO>() {
			@Override
			public MemberVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberVO mVO = new MemberVO();
				try {
					DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");
					mVO.setId(rs.getString("id"));
					mVO.setKname(dd.decryption(rs.getString("kname")));
					mVO.setBirth_year(dd.decryption(rs.getString("birth_year")));
					mVO.setTel(dd.decryption(rs.getString("tel")));
					mVO.setEmail(dd.decryption(rs.getString("email")));
					mVO.setEname_fst(dd.decryption(rs.getString("ename_fst")));
					mVO.setEname_lst(dd.decryption(rs.getString("ename_lst")));
					mVO.setM_status(rs.getString("m_status"));
					mVO.setJoin_date(rs.getString("join_date"));
					mVO.setOut_date(rs.getString("out_date"));
					mVO.setrNum("1");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				} catch (GeneralSecurityException e) {
					e.printStackTrace();
				} // end catch
				return mVO;
			}// mapRow
		});
		return list;
	}//selectOneMemberInfo
	
	
	/**
	 * 회원 삭제 (flag N로 변경)
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int deleteMember(String id) throws DataAccessException {
		int cnt = 0;

		String deleteMember = "update member set 	m_status='N', out_date=sysdate	where id=?";
		cnt = jt.update(deleteMember, id);

		return cnt;
	}// deleteMember

}// class
