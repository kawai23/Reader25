package com.kh.Reader25;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.Reader25.board.model.service.BoardService;
import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.discuss.model.service.DiscussService;
import com.kh.Reader25.discuss.model.vo.Discuss;

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
		
		ArrayList<Board> test = bService.review_d();
		ArrayList<Discuss> test2 = dService.test2();
		model.addAttribute("test", test);
		model.addAttribute("test2", test2);
		return "home";
	}
	
}
