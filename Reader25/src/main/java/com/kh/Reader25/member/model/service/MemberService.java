package com.kh.Reader25.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.member.model.vo.Member;

public interface MemberService {

	//Member memberLogin(String id);

	String searchId(HashMap<String, String> map);

	int insertMember(Member m);

	Member memberLogin(Member m);

	int checkIdDup(String id);

	int checkEmailDup(String email);

	int changePw(HashMap<String, String> map);

	int updatePwd(HashMap<String, String> map);

	int UpdateMember(Member m);

	int memberDelete(Member m);

	ArrayList<Member> selectMemberList(PageInfo pi);

	int getMemListCount();

	int getMemDeleteListCount();

	ArrayList<Member> selectdeletMemberList(PageInfo pi2);

	int deleteMemberList(String[] idArr);

	int reMemberList(String[] idArr);

	int insertKMember(Member m);

	Member memberKLogin(Member m);

	int insertNMember(Member m);

	int upPointUser(HashMap<String, Object> map);

	int muchPoint(String id);

	int changeRank(HashMap<String, Object> cap);


	List<Map<String, String>> getEnrollList(String today);

	int downPointUser(HashMap<String, Object> cap);

	List<Map<String, String>> selectGender();

	List<Map<String, String>> getRankCount();

	int changePoint(Member m);

	





}
