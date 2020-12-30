package com.kh.Reader25.member.model.service;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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


	



}
