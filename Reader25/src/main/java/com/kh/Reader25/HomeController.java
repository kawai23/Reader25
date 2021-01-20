package com.kh.Reader25;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.Reader25.board.model.exception.BoardException;
import com.kh.Reader25.board.model.service.BoardService;
import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.board.model.vo.Comments;
import com.kh.Reader25.discuss.model.service.DiscussService;
import com.kh.Reader25.discuss.model.vo.Discuss;
import com.kh.Reader25.member.model.vo.Member;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private BoardService bService;
	@Autowired
	private DiscussService dService;
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
	public String recd() {
		int value = 30;
		ArrayList<Board> result = bService.recd(value);
		System.out.println(result);
		return null;
	}
	@RequestMapping("about.ab")
	public String aboutViewPage() {
		return "about";
	}
	@RequestMapping("statistic.ad")
	public String statisticPage() {
		return "statistic";
	}
}
