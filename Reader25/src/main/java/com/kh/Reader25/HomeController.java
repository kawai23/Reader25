package com.kh.Reader25;

import java.io.IOException;
import java.util.ArrayList;
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
import com.kh.Reader25.discuss.model.service.DiscussService;
import com.kh.Reader25.discuss.model.vo.Discuss;
import com.kh.Reader25.visit.model.service.VisitorService;

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
		model.addAttribute("review", review);
		model.addAttribute("discuss", discuss);
		model.addAttribute("tiw", tiw);
		model.addAttribute("views", views);
		return "home";
	}
	
	@RequestMapping( value = "/recod.do")
	@ResponseBody
	public void recd(HttpServletResponse response) {
		int value = 30;
		ArrayList<Board> result = bService.recd(value);
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
	public ModelAndView statisticPage(@RequestParam(value="month", required=false) Integer month, 
								@RequestParam(value="page", required=false) Integer page,
								ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		List<Map<String,String>> dayList = vService.getDayVisitor();
		List<Map<String, String>> monthList = vService.getMonthVisitor();
		int monthCount = vService.getVisitMonthCount();
		
		// 값가공
		String dayStr = "";
		for(int i = 0; i < dayList.size(); i++) {
			if(i != dayList.size()) {
				dayStr += ",";
			}
			dayStr += "['" + dayList.get(i).get("day") +"'," + dayList.get(i).get("count") + "]";
		}
		String monthStr = "";
		for(int i = 0; i < monthList.size(); i++) {
			if(i != monthList.size()) {
				monthStr += ",";
			}
			monthStr += "['" + monthList.get(i).get("month") +"'," + monthList.get(i).get("count") + "]";
		}
		
		mv.addObject("dayList", dayList);
		mv.addObject("dayStr", dayStr);
		mv.addObject("monthList", monthList);
		mv.addObject("monthStr", monthStr);
		mv.addObject("monthCount", monthCount);
		
		mv.setViewName("statistic");
		
		return mv;
	}
}
