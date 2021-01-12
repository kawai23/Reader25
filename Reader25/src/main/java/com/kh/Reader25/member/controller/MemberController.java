package com.kh.Reader25.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Locale;

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

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.Reader25.member.model.dao.NaverLoginBO;
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
	
	//네이버 로그인
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	/* NaverLoginBO */
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO){
		this.naverLoginBO = naverLoginBO;
	}

	
	//로그인 클릭시 로그인 페이지로 이동 컨트롤러
	@RequestMapping("loginView.me")
	public String login(Model model, HttpSession session) {
		
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);
		
		//네이버 
		model.addAttribute("url", naverAuthUrl);

		/* 생성한 인증 URL을 View로 전달 */
		return "Login";
	}
	
	//네이버 로그인 성공시 callback호출 메소드
		@RequestMapping(value = "/callback.me", method = { RequestMethod.GET, RequestMethod.POST })
		public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
				throws IOException {
			System.out.println("여기는 callback");
			OAuth2AccessToken oauthToken;
		    oauthToken = naverLoginBO.getAccessToken(session, code, state);
		      //로그인 사용자 정보를 읽어온다.
			apiResult = naverLoginBO.getUserProfile(oauthToken);
			model.addAttribute("result", apiResult);

		    /* 네이버 로그인 성공 페이지 View 호출 */
			return "redirect:home.do";
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
	
	
	@RequestMapping("myUpdateForm.me")
	public String myUpdateForm() {
	

		
		
		return "memberUpdate";
		

	}
	
	
	
	
	@RequestMapping("myDeleteForm.me")
	public String myDeleteForm() {
	

		
		
		return "deleteForm";
		

	}
	
	 @RequestMapping("mdelete.me")
		public ModelAndView memberDelete(@ModelAttribute Member m , SessionStatus status, ModelAndView mv) {
			
			
		 
		 System.out.println(m);
		 
		 int result = mService.memberDelete(m);
			
			
			
			if( result > 0) {
				
				status.setComplete();
				
				
				mv.addObject("msg", "회원 탈퇴 완료");
				mv.setViewName("../home");
				
				return mv ;
			}else {
				
				throw new MemberException("회원 탈퇴  실패");
			}
		 
		 
		 
			
		}
	
	@RequestMapping("myUpdate.me")
	public String myUpdate(@ModelAttribute Member m,@RequestParam("pwd") String pwd ,@RequestParam("newPwd2") String newPwd2 , @RequestParam("joinPostal") String post,
			@RequestParam("joinAddress1") String address1,
			@RequestParam("joinAddress2") String address2, HttpSession session , Model model) {
	

		
				System.out.println(m);
				System.out.println(post);
				System.out.println(address1);
				System.out.println(address2);
				
				//Member member = mService.memberLogin((Member) session.getAttribute("loginUser"));
				
				Member member = (Member) session.getAttribute("loginUser");
				
				
				
				if(bcrypt.matches(pwd, member.getPwd())) {
				
					
					m.setAddress(post+"/" + address1+"/" +address2 );
					
					m.setPwd(bcrypt.encode(newPwd2));
					
					m.setId(member.getId());
				
				
					
					System.out.println("비밀번호 일치 == " + m);
					
					int result = mService.UpdateMember(m);
					
					System.out.println( m);
					System.out.println( result);
					
					if( result > 0) {
						
						
						member = mService.memberLogin(m);
						
						model.addAttribute("loginUser", m);
						
						
						
						return "redirect:myUpdateForm.me";
					}else {
						
						throw new MemberException("회원 정보 수정  실패");
					}
					
				
				
				
			}else {
				
				throw new MemberException("기존의 비밀번호가 틀림");
			}
			
					
				
				
				
				


	}
	

	

}
