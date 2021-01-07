package com.kh.Reader25.member.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.kh.Reader25.member.model.exception.MemberException;
import com.kh.Reader25.member.model.service.MemberService;
import com.kh.Reader25.member.model.service.MemberServiceImpl;
import com.kh.Reader25.member.model.vo.Member;

@SessionAttributes("loginUser")

@Controller
public class MemberController {
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	//로그인 클릭시 로그인 페이지로 이동 컨트롤러
	@RequestMapping("loginView.me")
	public String loginView() {
		return "Login";
	}
		
	//회원가입 후 로그인 컨트롤러
		@RequestMapping("login.me")
		public String login(Member m, Model model) {
			//m:입력한 아이디, 비번 //model:디비에 있는 데이터

			Member loginUser = mService.memberLogin(m);
			//아이디만 일치했을때에 대한 멤버 정보가 있음
			
			
			
			
			
			if(bcrypt.matches(m.getPwd(), loginUser.getPwd())) {
				model.addAttribute("loginUser", loginUser);
				return "redirect:home.do";
			} else {
				//model.addAttribute("message", "로그인에 실패하였습니다.");
				//return "../common/errorPage";
				throw new MemberException("로그인에 실패했습니다.");
			}		
		}
	
	// 로그아웃용 컨트롤러 (@SessionAttributes을 사용했을 때 가능)
	@RequestMapping("logout.me")
	public String logout(SessionStatus status) {
		status.setComplete(); // 모든걸 다 없애줌
				
		return "redirect:home.do";
	}
	
	// 아이디 찾기 페이지 이동 컨트롤러
	@RequestMapping("searchUserForm.me")
	public String searchUserFormView() {	
		return "SearchUserForm";
	}
	
	// 회원가입 페이지 이동 컨트롤러
	@RequestMapping("signUpForm.me")
	public String signUpFormView() {	
		return "SignUpForm";
	}
	
	//회원가입 컨트롤러
	@RequestMapping("minsert.me")
	public String memberInsert(@ModelAttribute Member m, @RequestParam("joinPostal") String post,
								@RequestParam("joinAddress1") String address1,
								@RequestParam("joinAddress2") String address2) {
		
		//System.out.println(m);
		//System.out.println(post);
		//System.out.println(address1);
		//System.out.println(address2);
		
		m.setAddress(post+"/"+address1+"/"+address2);
		
		String encPwd = bcrypt.encode(m.getPwd());
		m.setPwd(encPwd);
		
		int result = mService.insertMember(m);
				
		if(result > 0) {
			return "Login";
		} else {
			throw new MemberException("회원가입에 실패했습니다.");
		}
		
	}
	
	// id 중복 체크 컨트롤러
	@RequestMapping("dupid.me")
	public void idDuplicateCheck(@RequestParam("id") String id, HttpServletResponse response) {
		boolean isUsable = mService.checkIdDup(id) == 0 ? true : false;
		try {
			response.getWriter().print(isUsable);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// email 중복 체크 컨트롤러
	@RequestMapping("dupemail.me")
	public void emailDuplicateCheck(@RequestParam("email") String email, HttpServletResponse response) {
		boolean isUsable = mService.checkEmailDup(email) == 0 ? true : false;
		try {
			response.getWriter().print(isUsable);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 아이디 찾기
	@RequestMapping(value = "userSearch.me", method = RequestMethod.POST)
	@ResponseBody
	public String userIdSearch(@RequestParam("inputName_1") String user_name, 
								@RequestParam("inputPhone_1") String user_phone) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_name", user_name);
		map.put("user_phone", user_phone);
		//System.out.println(map);
		String result = mService.searchId(map);
		//System.out.println(result);

		return result;
	}
	
	// 비밀번호 찾기
	@RequestMapping(value = "pwSearch.me", method = RequestMethod.POST)
	@ResponseBody
	public String passwordSearch(@RequestParam("inputId_2")String user_id,
			@RequestParam("inputEmail_2")String user_email, HttpServletRequest request) {

		String key = "reader25";
		String encNewPwd = bcrypt.encode(key);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_id", user_id);
		map.put("key", encNewPwd);
		System.out.println(map);
		
		int result = mService.changePw(map);
		
		if(result > 0) {
			return key;
		} else {
			return null;
		}
	}
	
//	//마이페이지로 이동하는 뷰
//	@RequestMapping("mypage.me")
//	public String mypageFormView() {	
//		return "mypage";
//	}
	
	//마이페이지로 이동하는 뷰2
		@RequestMapping("mypage.me")
		public String mypageFormView() {	
			
			
			return "myPageList";
		}
		
		
		
	

	//비밀번호 변경 컨트롤러
	@RequestMapping(value = "mChangePw.me", method = RequestMethod.POST)
	@ResponseBody
	public String mChangePw(@RequestParam("inputPw")String inputPw,
			@RequestParam("newPw")String newPw, HttpSession session) {

		Member m = mService.memberLogin((Member)session.getAttribute("loginUser"));
		
		String ok = "ok";
				
		if(bcrypt.matches(inputPw, m.getPwd())) {
			String encNewPwd = bcrypt.encode(newPw);
			m.setPwd(encNewPwd);
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("id", m.getId());
			map.put("newPwd", encNewPwd);
			
			int result = mService.updatePwd(map);
			
			if(result > 0) {
				return ok;
			} else {
				throw new MemberException("비밀번호 수정에 실패했습니다.");
			}
		} else {
			throw new MemberException("기존 비밀번호가 틀렸습니다.");
		}
	}
	
	//마이페이지로 이동하는 뷰
	@RequestMapping("gobookroom.bo")
	public String myinfoFormView() {	
		return "gobookroom";
	}
	

	
	// 관리자 : 회원정보 관리
	@RequestMapping("admin.ad")
	public String adminMemberListView() {
		
		return "memberList";
	}
	
	

}
