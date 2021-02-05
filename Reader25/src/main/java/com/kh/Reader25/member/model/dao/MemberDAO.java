package com.kh.Reader25.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.Reader25.board.model.vo.PageInfo;
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
	
		
		
		
		return sqlSession.update("memberMapper.UpdateMember", m);
	}

	public int memberDelete(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.memberDelete", m);
	}

	public ArrayList<Member> selectMemberList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("memberMapper.selectMemberList", null, rowBounds);
	}

	public int getMemListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.getMemListCount");
	}

	public int getMemDeleteListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.getMemDeleteListCount");
	}

	public ArrayList<Member> selectdeleteMemberList(SqlSessionTemplate sqlSession, PageInfo pi2) {
		int offset = (pi2.getCurrentPage()- 1)* pi2.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi2.getBoardLimit());
		return (ArrayList)sqlSession.selectList("memberMapper.selectdeleteMemberList", null, rowBounds);
	}

	public int deleteMemberList(SqlSessionTemplate sqlSession, String[] idArr) {
		int result = 0;
		for(String id: idArr) {
			result += sqlSession.update("memberMapper.deleteMemberList", id);
		}
		if(result == idArr.length) {
			result = 1;
		}else {
			result = 0;
		}
		return result;
	}

	public int reMemberList(SqlSessionTemplate sqlSession, String[] idArr) {
		int result = 0;
		for(String id: idArr) {
			result += sqlSession.update("memberMapper.recoveryMemberList", id);
		}
		if(result == idArr.length) {
			result = 1;
		}else {
			result = 0;
		}
		return result;
	}

	public int insertKMember(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return sqlSession.insert("memberMapper.insertKMember", m);
	}

	public Member memberKLogin(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.memberKLogin", m);
	}

	public int insertNMember(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return sqlSession.insert("memberMapper.insertNMember", m);
	}
	
	public int upPointUser(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.update("memberMapper.upPointUser", map);
	}

	public int muchPoint(SqlSessionTemplate sqlSession, String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.muchPoint", id);
	}

	public int changeRank(SqlSessionTemplate sqlSession, HashMap<String, Object> cap) {
		// TODO Auto-generated method stub
		return sqlSession.update("memberMapper.changeRank", cap);
	}

	public List<Map<String, String>> getEnrollList(SqlSessionTemplate sqlSession, String today) {
		return sqlSession.selectList("memberMapper.getEnrollList", today);
	}

	public int downPointUser(SqlSessionTemplate sqlSession, HashMap<String, Object> cap) {
		// TODO Auto-generated method stub
		return sqlSession.update("memberMapper.downPointUser", cap);
	}

	public List<Map<String, String>> selectGender(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("memberMapper.getGender");
	}

	public List<Map<String, String>> getRankCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("memberMapper.getRankCount");
	}

	public int changePoint(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.changePoint", m);
	}

	public Integer selectRank(SqlSessionTemplate sqlSession, String userid) {
		return sqlSession.selectOne("memberMapper.selectRank", userid);
	}
	


}