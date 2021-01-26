package com.kh.Reader25;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.Reader25.board.model.service.BoardService;
import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.common.Pagination;
import com.kh.Reader25.discuss.model.service.DiscussService;
import com.kh.Reader25.discuss.model.vo.Discuss;
import com.kh.Reader25.member.model.service.MemberService;
import com.kh.Reader25.visit.model.service.VisitorService;
import com.kh.Reader25.visit.model.vo.Visitor;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private BoardService bService;
	@Autowired
	private DiscussService dService;
	@Autowired
	private VisitorService vService;
	@Autowired
	private MemberService mService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping("/home.do")
	public String home(Locale locale, Model model) {
		
		ArrayList<Board> review = bService.review();
		ArrayList<Discuss> discuss = dService.discuss();
		ArrayList<Board> tiw = bService.tiw();
		ArrayList<Board> views = bService.views();
		System.out.println(review);
		model.addAttribute("review", review);
		model.addAttribute("discuss", discuss);
		model.addAttribute("tiw", tiw);
		model.addAttribute("views", views);
		return "home";
	}
	
	@RequestMapping( value = "/recod.do")
	@ResponseBody
	public void recod(HttpServletResponse response) {
		int value = 30;
		ArrayList<Board> result = bService.recod(value);
		response.setContentType("application/json; charset=UTF-8");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		try {
			gson.toJson(result, response.getWriter());
		} catch (JsonIOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping( value = "/recow.do")
	@ResponseBody
	public void recow(HttpServletResponse response) {
		int value = 30;
		ArrayList<Board> result = bService.recow(value);
		response.setContentType("application/json; charset=UTF-8");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		try {
			gson.toJson(result, response.getWriter());
		} catch (JsonIOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping( value = "/recom.do")
	@ResponseBody
	public void recom(HttpServletResponse response) {
		int value = 30;
		ArrayList<Board> result = bService.recom(value);
		System.out.println(result);
		response.setContentType("application/json; charset=UTF-8");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		try {
			gson.toJson(result, response.getWriter());
		} catch (JsonIOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("about.ab")
	public String aboutViewPage() {
		return "about";
	}
	@RequestMapping("statistic.ad")
	public ModelAndView statisticPage(@RequestParam(value="dayStart", required=false) String dayStart, 
								@RequestParam(value="page", required=false) Integer page,
								ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		// 오늘 날짜
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yy/MM");
		Date time = new Date();
		String today = sdf.format(time);
		String month = sdf2.format(time);
		
		List<Map<String,String>> dayList = vService.getDayVisitor(today);
		List<Map<String, String>> monthList = vService.getMonthVisitor(month);
		int monthCount = vService.getVisitMonthCount();
		
		int listCount = mService.getMemListCount();
		
		List<Map<String, String>> enrollList = mService.getEnrollList(today);
		// 값가공
		String dayStr = "['Day','방문자수','회원가입수']";
		for(int i = 0; i < dayList.size(); i++) {
			if(i != dayList.size()) {
				dayStr += ",";
			}
			if(enrollList.size() <= i) {
				dayStr += "['" + dayList.get(i).get("day") +"'," + dayList.get(i).get("count") + ",0]";
			}else {
				dayStr += "['" + dayList.get(i).get("day") +"'," + dayList.get(i).get("count") + ","+ enrollList.get(i).get("count")+"]";
			}
		}
		String monthStr = "['Month','Count']";
		for(int i = 0; i < monthList.size(); i++) {
			if(i != monthList.size()) {
				monthStr += ",";
			}
			monthStr += "['" + monthList.get(i).get("month") +"'," + monthList.get(i).get("count") + "]";
		}
		PageInfo pi = Pagination.getPageInfo1(currentPage, listCount);
		ArrayList<Visitor> visitList = vService.selectListVisitor(pi);
		
		
		mv.addObject("dayStr", dayStr);
		mv.addObject("monthStr", monthStr);
		mv.addObject("monthCount", monthCount);
		mv.addObject("visitList", visitList);
		mv.addObject("pi", pi);
		
		mv.setViewName("statistic");
		
		return mv;
	}
	// 일별 방문자 현황 그래프
	@RequestMapping("dayCount.ad")
	public void getDayCount(@RequestParam("dayStart") String dayStart, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		
		// 값 가공
		String[] dayArr = dayStart.split("-");
		String day = "";
		day += dayArr[0].substring(2);
		for(int i = 1; i < dayArr.length; i++) {
			day += dayArr[i];
			if(i != dayArr.length-1) {
				day += "/";
			}
		}
		HashMap<String, Object> map = new HashMap<String,Object>();
		
		List<Map<String,String>> dayList = vService.getDayVisitor(day);
		List<Map<String,String>> enrollList = mService.getEnrollList(day);
		
		for(int i = 0; i < enrollList.size(); i++) {
			
			System.out.println(enrollList.get(i));
		}
		
		map.put("dayList", dayList);
		map.put("enrollList", enrollList);
		
		Gson gson = new Gson();
		try {
			gson.toJson(map, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//월별 방문자 현황 그래프
	@RequestMapping("monthCount.ad")
	public void getMonthCount(@RequestParam("monthStart") String monthStart, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		
		// 값 가공
		String[] monthArr = monthStart.split("-");
		String month = "";
		month += monthArr[0].substring(2);
		for(int i = 1; i < monthArr.length; i++) {
			month += monthArr[i];
			if(i != monthArr.length-1) {
				month += "/";
			}
		}
		List<Map<String,String>> monthList = vService.getMonthVisitor(month);
		
		Gson gson = new Gson();
		try {
			gson.toJson(monthList, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
