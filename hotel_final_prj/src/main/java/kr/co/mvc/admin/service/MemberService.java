package kr.co.mvc.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import kr.co.mvc.admin.dao.MemberDAO;
import kr.co.mvc.admin.vo.MemberPagingVO;
import kr.co.mvc.admin.vo.MemberVO;

@Component
public class MemberService {
	
	@Autowired
	private MemberDAO memDAO;
	
/**
 * ����ȸ�� ��ȸ
 * @param id
 * @return
 */
public List<MemberVO> searchActiveMember(MemberPagingVO mpVO) {
	List<MemberVO> list =null;
	try {
		list = memDAO.selectActiveMember(mpVO); 
	}catch(DataAccessException dae) {
		dae.printStackTrace();
	}//end catch
	return list;
}//searchActiveMember

/**
 * ���������̼ǿ� ����� ��ü ���ڵ� �� ����
 * @param id
 * @param status
 * @return
 */
public int searchAllMemberCnt(String id, String status) {
	int allMemCnt = 0;
	try {
		allMemCnt = memDAO.selectAllMemberCnt(id, status); 
	}catch(DataAccessException dae) {
		dae.printStackTrace();
	}//end catch
	return allMemCnt;
}//selectAllMemberCnt

/**
 * Ż��ȸ�� ��ȸ
 * @param id
 * @return
 */
public List<MemberVO> searchInactiveMember(MemberPagingVO mpVO) {
	List<MemberVO> list =null;
	try {
		list = memDAO.selectInactiveMember(mpVO); 
	}catch(DataAccessException dae) {
		dae.printStackTrace();
	}//end catch
	return list;
}//searchInactiveMember


/**
 * Ư��ȸ�� ��ȸ
 * @param id
 * @return
 */
public List<MemberVO> searchOneMemberInfo(String id) {
	List<MemberVO> list =null;
	try {
		list = memDAO.selectOneMemberInfo(id); 
	}catch(DataAccessException dae) {
		dae.printStackTrace();
	}//end catch
	return list;
}//searchOneMemberInfo


/**
 * ȸ�� ���� (flag N�� ����)
 * @param id
 * @return
 */
public int removeMember(String id) {
	int cnt = 0;
	try {
		cnt = memDAO.deleteMember(id); 
	}catch(DataAccessException dae) {
		dae.printStackTrace();
	}//end catch
	return cnt;
}//removeMember
	
}//class
