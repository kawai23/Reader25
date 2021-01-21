package com.kh.Reader25.discuss.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.Reader25.board.model.service.BoardService;
import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.common.Pagination;
import com.kh.Reader25.discuss.model.exception.DiscussException;
import com.kh.Reader25.discuss.model.service.DiscussService;
import com.kh.Reader25.discuss.model.vo.Discuss;
import com.kh.Reader25.discuss.model.vo.Reply;
import com.kh.Reader25.member.model.service.MemberService;
import com.kh.Reader25.member.model.vo.Member;

@SessionAttributes("loginUser")

@Controller
public class DiscussController {
	
	@Autowired
	private DiscussService dService;

	//포인트 관련
	@Autowired
	private MemberService mService;
	
	@Autowired
	private BoardService bService;
	
	// 토론방 전체 페이지(+검색포함)
	@RequestMapping("discuss.di")
	public ModelAndView discussList(@RequestParam(value="page", required=false) Integer page, ModelAndView mv,@RequestParam(value="text", required=false) String text, @RequestParam(value="type", required=false) Integer type) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		Map<String, Object> s = new HashMap<String, Object>();
		s.put("text", text);
		s.put("type", type);
		
		int listCount = dService.getListCount(s);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		ArrayList<Discuss> dList = dService.selectList(pi,s);
		ArrayList<Attachment> atList = dService.selectatList();
		if(dList != null) {
			mv.addObject("dList", dList)
				.addObject("pi", pi)
				.addObject("atList", atList)
				.setViewName("discussList");
		}else {
			throw new DiscussException("토론방 전체 조회에 실패하였습니다.");
		}
		return mv;
	}
	
	// 토론방 글쓰기 페이지로 이동
	@RequestMapping("discussWrite.di")
	public String discussWriteForm() {
		return "discussWriteForm";
	}
	
	// 토론방 작성
	@RequestMapping("discussInsert.di")
	public String discussInsert(@ModelAttribute Discuss d, @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request, HttpSession session) {
		d.setdWriter(((Member)(request.getSession().getAttribute("loginUser"))).getId());
		
		//System.out.println("잘받아오나?"+d);
		Attachment at = null;
		if(uploadFile != null && !uploadFile.isEmpty()) {
			at = saveFile(uploadFile, request);
			d.setAtcNo(1);
		}
		// <p>태그 삭제하기
		d.setdContent(d.getdContent().replace("<p>", ""));
		d.setdContent(d.getdContent().replace("</p>", ""));
		
		int result = dService.insertDiscuss(d, at);
		
		if(result >0) {
			//포인트 관련
			int point = pointChange(session);
			//System.out.println("point"+point);
			
			return "redirect:discuss.di";
		} else {
			throw new DiscussException("토론방 작성에 실패하였습니다.");
		}
	}
	
	public int pointChange(HttpSession session) {
		Member login = (Member)session.getAttribute("loginUser");
		String id = login.getId();	
		int point = 150;
		String message = "토론방 글 작성!";
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("point", point);
		map.put("pCon", message);
		
		int pointUpU = mService.upPointUser(map);
		int pointUp = bService.upPoint(map);
		
		int rankCheck = mService.muchPoint(id);
		
		
		if(rankCheck>=0 && rankCheck<=1000) {
			int rank = 1;
				
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
			
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		} else if(rankCheck>1000 && rankCheck<=3000) {
			int rank = 2;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
		
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		} else if(rankCheck>3000 && rankCheck<=7000) {
			int rank = 3;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
				
			int rankChange=mService.changeRank(cap);
			System.out.println("rankChange"+rankChange);
			return rankChange;
		} else if(rankCheck>7000 && rankCheck<=10000) {
			int rank = 4;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
				
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		} else {
			int rank = 0;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
				
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		}
		
	}
	
	// 토론방 상세페이지 이동
	@RequestMapping("dDetail.di")
	public ModelAndView discussDetailForm(@RequestParam("dNo") int dNo, @RequestParam("page") int page, ModelAndView mv) {
		Discuss discuss = dService.selectDiscuss(dNo);
		Attachment at = null;
		if(discuss != null) {
			if(discuss.getAtcNo() != 0) {
				at = dService.selectAt(discuss.getAtcNo());
			}
			mv.addObject("d", discuss).addObject("page", page).addObject("at", at).setViewName("discussDetail");
		} else {
			throw new DiscussException("토론방 상세보기 실패하였습니다.");
		}
		return mv;
	}
	
	// 토론방 수정 페이지로 이동
	@RequestMapping("dUpdateForm.di")
	public ModelAndView discussUpdate(@RequestParam("dNo") int dNo ,@RequestParam("page") int page, ModelAndView mv) {
		Discuss d = dService.selectDiscuss(dNo);
		Attachment at = null;
		if(d.getAtcNo() != 0) {
			at = dService.selectAt(d.getAtcNo());
		}
		mv.addObject("d", d).addObject("page", page).addObject("at", at).setViewName("discussUpdateForm");
		return mv;
	}
	
	// 토론방 수정
	@RequestMapping("dUpdate.di")
	public ModelAndView discussupdate(@ModelAttribute Discuss d, @ModelAttribute Attachment at, @RequestParam("page") int page,
			@RequestParam ("reloadFile") MultipartFile reloadFile, HttpServletRequest request, ModelAndView mv) {
		if(reloadFile != null && !reloadFile.isEmpty()) {
			int atcno = 0;
			if(at.getAtcName() != null) {
				deleteFile(at.getAtcName(), request);
				atcno = d.getAtcNo();
			}
			Attachment att  = saveFile(reloadFile, request);
			if(atcno>0) {
				att.setAtcNo(atcno);
			}
			int result = dService.updateAtno(att, atcno);
			if(result<0) {
				throw new DiscussException("토론방 파일 수정에 실패하였습니다.");
			}
		}
		int result = dService.updateDiscuss(d);
		
		if(result > 0) {
			mv.addObject("dNo", d.getdNo()).addObject("page", page).setViewName("redirect:dDetail.di");
		} else {
			throw new DiscussException("토론방 수정에 실패하였습니다.");
		}
		return mv;
	}
	// 토론방 삭제
	@RequestMapping("dDelete.di")
	public String disucssDelete(@RequestParam("dNo") int dNo) {
		int result = dService.deleteDiscuss(dNo);
		if(result > 0) {
			return "redirect:discuss.di";
		} else {
			throw new DiscussException("토론방 삭제에 실패하였습니다.");
		}
	}
	
	// 댓글 작성
	@RequestMapping("addReply.di")
	@ResponseBody
	public String addReply(@ModelAttribute Reply r) {
		int result = dService.insertReply(r);
		if(result > 0) {
			return "success";
		} else {
			throw new DiscussException("댓글 작성에 실패하였습니다.");
		}
	}
	
	// 댓글 리스트 불러오기
	@RequestMapping("rList.di")
	public void selectRList(@RequestParam("dNo") int dNo, @RequestParam("cho") int cho, HttpServletResponse response) {
		Map<String, Integer> d = new HashMap<String, Integer>();
		d.put("dNo", dNo);
		d.put("cho", cho);
		ArrayList<Reply> rList = dService.selectRList(d); 
		response.setContentType("application/json; charset=UTF-8");
		Gson gson = new Gson();
		try {
			gson.toJson(rList, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 댓글 삭제
	@RequestMapping("rDelete.di")
	@ResponseBody
	public String rDelete(@ModelAttribute Reply r) {
		System.out.println(r);
		int result = dService.rDelete(r);
		if(result > 0) {
			return "success";
		} else {
			throw new DiscussException("댓글 삭제에 실패햐였습니다.");
		}
	}
	
	// 댓글 수정
	@RequestMapping("rUpdate.di")
	public void UpdatsRelpy(@ModelAttribute Reply r, @RequestParam("check") String check, @RequestParam("dNo") int dNo, HttpServletResponse response) {
		if(!check.equals("패스")) {
			Map<String, Object> d = new HashMap<String, Object>();
			d.put("dNo", dNo);
			d.put("check", check);
			d.put("PCN", r.getrWhether());
			dService.changePCN(d);
		}
		int result = dService.rUpdate(r);
		
	}
	// 파일 저장
	public Attachment saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdir();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String originFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) 
								+ "." + originFileName.substring(originFileName.lastIndexOf(".") + 1);
		String renamePath = folder + "\\" + renameFileName;
		Attachment at = new Attachment();
		at.setAtcOrigin(originFileName);
		at.setAtcName(renameFileName);
		at.setAtcPath(savePath);
		at.setAtcLevel(0);
		try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return at;
	}
	// 파일 삭제
	public void deleteFile(String fileName, HttpServletRequest request) { //기존 파일 삭제
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";
		
		File f = new File(savePath + "\\" + fileName);
		if(f.exists()) {
			f.delete();
		}
	}
}
