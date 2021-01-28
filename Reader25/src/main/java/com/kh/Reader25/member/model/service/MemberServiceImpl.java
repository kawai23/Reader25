package com.kh.Reader25.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.member.model.dao.MemberDAO;
import com.kh.Reader25.member.model.vo.Member;

@Service("mService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO mDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	//@Override
	//public Member memberLogin(String id) {
		// TODO Auto-generated method stub
		//return mDAO.selectMember(sqlSession, id);
	//}

	@Override
	public String searchId(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return mDAO.searchId(sqlSession, map);
	}

	@Override
	public int insertMember(Member m) {
		// TODO Auto-generated method stub
		return mDAO.insertMember(sqlSession, m);
	}

	@Override
	public Member memberLogin(Member m) {
		// TODO Auto-generated method stub
		return mDAO.selectMember(sqlSession, m);
	}

	@Override
	public int checkIdDup(String id) {
		// TODO Auto-generated method stub
		return mDAO.checkIdDup(sqlSession, id);
	}

	@Override
	public int checkEmailDup(String email) {
		// TODO Auto-generated method stub
		return mDAO.checkEmailDup(sqlSession, email);
	}

	@Override
	public int changePw(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return mDAO.changePw(sqlSession, map);
	}

	@Override
	public int updatePwd(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return mDAO.updatePwd(sqlSession, map);
	}

	@Override
	public int UpdateMember(Member m) {
		// TODO Auto-generated method stub
		return mDAO.UpdateMember(sqlSession, m);
	}

	@Override
	public int memberDelete(Member m) {
		// TODO Auto-generated method stub
		return mDAO.memberDelete(sqlSession, m);
	}

	@Override
	public ArrayList<Member> selectMemberList(PageInfo pi) {
		return mDAO.selectMemberList(sqlSession, pi);
	}

	@Override
	public int getMemListCount() {
		return mDAO.getMemListCount(sqlSession);
	}

	@Override
	public int getMemDeleteListCount() {
		return mDAO.getMemDeleteListCount(sqlSession);
	}

	@Override
	public ArrayList<Member> selectdeletMemberList(PageInfo pi2) {
		return mDAO.selectdeleteMemberList(sqlSession, pi2);
	}

	@Override
	public int deleteMemberList(String[] idArr) {
		return mDAO.deleteMemberList(sqlSession, idArr);
	}

	@Override
	public int reMemberList(String[] idArr) {
		return mDAO.reMemberList(sqlSession, idArr);
	}

	@Override
	public int insertKMember(Member m) {
		// TODO Auto-generated method stub
		return mDAO.insertKMember(sqlSession, m);
	}

	@Override
	public Member memberKLogin(Member m) {
		// TODO Auto-generated method stub
		return mDAO.memberKLogin(sqlSession, m);
	}

	@Override
	public int insertNMember(Member m) {
		// TODO Auto-generated method stub
		return mDAO.insertNMember(sqlSession, m);
	}

	@Override
	public int upPointUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return mDAO.upPointUser(sqlSession, map);
	}

	@Override
	public int muchPoint(String id) {
		// TODO Auto-generated method stub
		return mDAO.muchPoint(sqlSession, id);
	}

	@Override
	public int changeRank(HashMap<String, Object> cap) {
		// TODO Auto-generated method stub
		return mDAO.changeRank(sqlSession, cap);
	}

	@Override
	public List<Map<String, String>> getEnrollList(String today) {
		return mDAO.getEnrollList(sqlSession, today);
	}

	@Override
	public int downPointUser(HashMap<String, Object> cap) {
		// TODO Auto-generated method stub
		return mDAO.downPointUser(sqlSession, cap);
	}

	@Override
	public List<Map<String, String>> selectGender() {
		return mDAO.selectGender(sqlSession);
	}



	



}
