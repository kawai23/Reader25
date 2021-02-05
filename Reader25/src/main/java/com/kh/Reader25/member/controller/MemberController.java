package com.kh.Reader25.member.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
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

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.Reader25.board.model.service.BoardService;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.common.Pagination;
import com.kh.Reader25.member.model.dao.KakaoController;
import com.kh.Reader25.member.model.dao.MemberDAO;
import com.kh.Reader25.member.model.dao.NaverLoginBO;
import com.kh.Reader25.member.model.exception.MemberException;
import com.kh.Reader25.member.model.service.MemberService;
import com.kh.Reader25.member.model.vo.Member;

@SessionAttributes("loginUser")

@Controller
public class MemberController {
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	//포인트 관련
	@Autowired
	private BoardService bService;
	
	//메일 발송 관련
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private MemberDAO mDAO;
	
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
		String kakaoUrl = KakaoController.getAuthorizationUrl(session);
		
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
				
		//네이버 
		model.addAttribute("naver_url", naverAuthUrl);
		// 카카오 로그인 
		model.addAttribute("kakao_url", kakaoUrl);

		/* 생성한 인증 URL을 View로 전달 */
		return "Login";
	}
	
	//네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @ModelAttribute Member m, @RequestParam String code, 
			@RequestParam String state, HttpSession session) throws IOException, ParseException {
		
		ModelAndView mav = new ModelAndView(); 
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		
		apiResult = naverLoginBO.getUserProfile(oauthToken); //String형식의 json데이터
		
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		
		JSONObject response_obj = (JSONObject)jsonObj.get("response");
		
		String id = (String)response_obj.get("id");
		String gender = (String)response_obj.get("gender");
		String email = (String)response_obj.get("email");
		String phone = (String)response_obj.get("mobile");
		String name = (String)response_obj.get("name");
		String pwd="123";
		
		m.setEmail(email);
		m.setName(name);
		m.setId(id);
		m.setPwd(pwd);
		m.setPhone(phone);
		m.setGender(gender);
		
		int isUsable = mService.checkIdDup(id) == 0 ? 0 : 1;
			
			if(isUsable==0) {
				
				String encPwd = bcrypt.encode(m.getPwd());
				m.setPwd(encPwd);
				
				int result = mService.insertNMember(m);
				
				if(result != 0) {					
					Member loginUser = mService.memberLogin(m);
					//아이디만 일치했을때에 대한 멤버 정보가 있음
									
					model.addAttribute("loginUser", loginUser);
					
					return "redirect:home.do";
				} else {
					mav.setViewName("Login"); 
				}
			} else {
				Member loginUser = mService.memberLogin(m);
				//아이디만 일치했을때에 대한 멤버 정보가 있음
								
				model.addAttribute("loginUser", loginUser);
				return "redirect:home.do";
			}			
			return "redirect:home.do";
			
		
	}
	

	//카카오 로그인 성공시 컨트롤러
	@RequestMapping(value = "/kakaologin.do", produces = "application/json", method = { RequestMethod.GET, RequestMethod.POST }) 
	public String kakaoLogin(@ModelAttribute Member m, @RequestParam("code") String code, Model model,
			HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) throws Exception { 
		ModelAndView mav = new ModelAndView(); 
		// 결과값을 node에 담아줌 
		JsonNode node = KakaoController.getAccessToken(code); 
		// accessToken에 사용자의 로그인한 모든 정보가 들어있음 
		JsonNode accessToken = node.get("access_token"); 
		// 사용자의 정보 
		JsonNode userInfo = KakaoController.getKakaoUserInfo(accessToken); 
		String email = null; 
		String name = null; 
		String kgender = null; 
		String kbirthDay = null; 
		String kage = null; 
		String kimage = null; 
		String id = null; 
		String pwd="123";
		String phone="010-0000-0000";
		String gender="F";
		// 유저정보 카카오에서 가져오기 Get properties 
		JsonNode properties = userInfo.path("properties"); 
		JsonNode kakao_account = userInfo.path("kakao_account"); 
		id = userInfo.path("id").asText();
		email = kakao_account.path("email").asText(); 
		name = properties.path("nickname").asText(); 
		kimage = properties.path("profile_image").asText(); 
		kgender = kakao_account.path("gender").asText(); 
		kbirthDay = kakao_account.path("birthday").asText(); 
		kage = kakao_account.path("age_range").asText(); 
				
		m.setEmail(email);
		m.setName(name);
		m.setId(id);
		m.setPwd(pwd);
		m.setPhone(phone);
		m.setGender(gender);
		
		int isUsable = mService.checkIdDup(id) == 0 ? 0 : 1;
		
		if(isUsable==0) {
			
			String encPwd = bcrypt.encode(m.getPwd());
			m.setPwd(encPwd);
			System.out.println(m);
			int result = mService.insertKMember(m);
			
			if(result != 0) {
				
				Member loginUser = mService.memberLogin(m);
				//아이디만 일치했을때에 대한 멤버 정보가 있음
								
				model.addAttribute("loginUser", loginUser);
				return "redirect:home.do";
			} else {
				return "redirect:home.do"; 
			}
		} else {
			Member loginUser = mService.memberLogin(m);
			//아이디만 일치했을때에 대한 멤버 정보가 있음
							
			model.addAttribute("loginUser", loginUser);
			return "redirect:home.do";
		}
	}


		
	//회원가입 후 로그인 컨트롤러
	@RequestMapping("login.me")
	public String login(Member m, Model model, HttpSession session) {
			//m:입력한 아이디, 비번 //model:디비에 있는 데이터

		Member loginUser = mService.memberLogin(m);
			//아이디만 일치했을때에 대한 멤버 정보가 있음
						
		if(bcrypt.matches(m.getPwd(), loginUser.getPwd())) {
			model.addAttribute("loginUser", loginUser);
			return "redirect:home.do";
		} else {
			throw new MemberException("로그인에 실패했습니다.");
		}		
	}
	
	// 로그아웃용 컨트롤러 (@SessionAttributes을 사용했을 때 가능)
	@RequestMapping("logout.me")
	public String logout(SessionStatus status, HttpSession session) {
		status.setComplete(); // 모든걸 다 없애줌
		session.invalidate();
				
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
								@RequestParam("joinAddress2") String address2, HttpSession session) {
		
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
		String result = mService.searchId(map);

		return result;
	}
	
	//메일 발송 관련 컨트롤러
	// 이메일 난수 만드는 메서드
	private String init() {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;

		do {
			num = ran.nextInt(75) + 48;
			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			} else {
				continue;
			}

		} while (sb.length() < size);
		if (lowerCheck) {
			return sb.toString().toLowerCase();
		}
		return sb.toString();
	}

	// 난수를 이용한 키 생성
	private boolean lowerCheck;
	private int size;

	public String getKey(boolean lowerCheck, int size) {
		this.lowerCheck = lowerCheck;
		this.size = size;
		return init();
	}
	
	// 비밀번호 찾기
	@RequestMapping(value = "pwSearch.me", method = RequestMethod.POST)
	@ResponseBody
	public String passwordSearch(@RequestParam("inputId_2")String user_id,
			@RequestParam("inputEmail_2")String user_email, HttpServletRequest request) {

		String key = getKey(false, 6);
		String encNewPwd = bcrypt.encode(key);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_id", user_id);
		map.put("key", encNewPwd);
		
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = "<h2>안녕하세요 '"+ user_id +"' 님</h2><br><br>" 
				+ "<p>비밀번호 찾기를 신청해주셔서 임시 비밀번호를 발급해드립니다.</p>"
				+ "<p>임시로 발급 드린 비밀번호는 <h2 style='color : blue'>'" + key +"'</h2>이며 로그인 후 마이페이지에서 비밀번호를 변경해주시면 됩니다.</p><br>"
				+ "<h3><a href='http://localhost:8105/Reader25'>Reader25 홈페이지 접속 (클릭!) </a></h3><br><br>"
				+ "Reader25에 향한 무한한 관심과 사랑 감사드립니다.";
		try {
			mail.setSubject("[Reader25] 임시 비밀번호가 발급되었습니다", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(user_email));
			mailSender.send(mail);
		} catch (MessagingException e) { 
			e.printStackTrace();
		}
		int result = mService.changePw(map);
		if(result > 0) {
			return key;
		} else {
			return null;
		}
	}

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
	public ModelAndView adminMemberListView(ModelAndView mv, @RequestParam(value="page", required=false) Integer page,
											@RequestParam(value="page2", required=false) Integer page2) {
		// 페이징
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int currentPage2 = 1;
		if(page2 != null) {
			currentPage2 = page;
		}
		
		int listCount = mService.getMemListCount();
		int listCount2 = mService.getMemDeleteListCount();
		PageInfo pi = Pagination.getPageInfo3(currentPage, listCount);
		PageInfo pi2 = Pagination.getPageInfo3(currentPage2, listCount2);
		ArrayList<Member> memList = mService.selectMemberList(pi);
		ArrayList<Member> delList = mService.selectdeletMemberList(pi2);
		List<Map<String,String>> genderMap = mService.selectGender();
		List<Map<String,String>> rankMap = mService.getRankCount();
		
		// 값 가공하기
		String genderArr = "['Gender','회원수']";
		for(int i = 0; i < genderMap.size(); i++) {
			if(i != genderMap.size()) {
				genderArr += ",";
			}
			
			genderArr += "['" + genderMap.get(i).get("gender") +"'," + genderMap.get(i).get("count") + "]";
		}
		String rankArr = "['Rank','회원수']";
		for(int i = 0; i < rankMap.size(); i++) {
			if(i != rankMap.size()) {
				rankArr += ",";
			}
			
			rankArr += "['" + rankMap.get(i).get("rank") +"'," + rankMap.get(i).get("count") + "]";
		}
		if(memList != null && delList != null) {
			mv.addObject("memList", memList)
			  .addObject("pi", pi)
			  .addObject("pi2", pi2)
			  .addObject("delList", delList)
			  .addObject("rankArr", rankArr)
			  .addObject("genderArr", genderArr);
			mv.setViewName("memberList");
			return mv;
		}else {
			throw new MemberException("관리자창에서 회원리스트를 조회하는데 실패하였습니다.");
		}
	}
	//관리자 :회원 삭제
	@RequestMapping("deleteAll.me")
	public String deleteMemberList(@RequestParam("idArr") String[] idArr) {
		int result = mService.deleteMemberList(idArr);
		if(result > 0) {
			return "redirect:admin.ad";
		}else {
			throw new MemberException("관리자에서 회원 삭제에 실패하였습니다.");
		}
	}
	//관리자 : 회원복구
	@RequestMapping("recoveryAll.me")
	public String recoveryMemberList(@RequestParam("idArr") String[] idArr) {
		int result = mService.reMemberList(idArr);
		if(result > 0) {
			return "redirect:admin.ad";
		}else {
			throw new MemberException("관리자창에서 계정 복구에 실패하였습니다.");
		}
	}
	

	
	@RequestMapping("myUpdateForm.me")
	public String myUpdateForm() {
	

		
		
		return "memberUpdate";
		

	}
	
	
	
	
	@RequestMapping("myDeleteForm.me")
	public String myDeleteForm() {
	

		
		
		return "deleteForm";
		

	}
	
	@RequestMapping("myLikeForm.me")
	public String myLikeForm() {
	

		
		
		return "myLikeList";
		

	}
	
	 @RequestMapping("mdelete.me")
		public ModelAndView memberDelete(@ModelAttribute Member m , SessionStatus status, ModelAndView mv) {
			
		 
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
	

				//Member member = mService.memberLogin((Member) session.getAttribute("loginUser"));
				
				Member member = (Member) session.getAttribute("loginUser");
				
				
				
				if(bcrypt.matches(pwd, member.getPwd())) {
				
					
					m.setAddress(post+"/" + address1+"/" +address2 );
					
					m.setPwd(bcrypt.encode(newPwd2));
					
					m.setId(member.getId());
				
				
										
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