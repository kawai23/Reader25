package com.kh.Reader25.member.model.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.Reader25.member.model.vo.Member;

@Repository("mDAO")
public class MemberDAO {

	//public Member selectMember(SqlSessionTemplate sqlSession, String id) {
		// TODO Auto-generated method stub
		//return sqlSession.selectOne("memberMapper.selectMember", id);
	//}

	public String searchId(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.searchId", map);
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public Member selectMember(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.selectOne", m);
	}

	public int userIdCheck(SqlSessionTemplate sqlSession, String user_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.userIdCheck", user_id);
	}

	public int checkIdDup(SqlSessionTemplate sqlSession, String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.checkIdDup", id);
	}

	public int checkEmailDup(SqlSessionTemplate sqlSession, String email) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.checkEmailDup", email);
	}

	public int changePw(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.update("memberMapper.changePw", map);
	}

	public int updatePwd(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.update("memberMapper.updatePwd", map);
	}

	public int UpdateMember(SqlSessionTemplate sqlSession, Member m) {
	
		
		System.out.println(m);
		
		System.out.println(sqlSession.update("memberMapper.UpdateMember", m));
		
		return sqlSession.update("memberMapper.UpdateMember", m);
	}
	
	



}
