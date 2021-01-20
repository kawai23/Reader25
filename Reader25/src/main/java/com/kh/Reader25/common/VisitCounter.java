package com.kh.Reader25.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.kh.Reader25.visit.model.dao.VisitorDAO;
import com.kh.Reader25.visit.model.vo.Visitor;

public class VisitCounter implements HttpSessionListener{
	@Autowired
	private VisitorDAO vDAO;
	
	@Autowired 
	private SqlSessionTemplate sqlSession;
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		System.out.println("리스너시작!!!!!!!!!!!!!!!!!!!!!!!");
		HttpSession session = se.getSession();
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		Visitor v = new Visitor();
		v.setVisit_ip(request.getRemoteAddr());
		v.setVisit_agent(request.getHeader("User-Agent")); //브라우저 정보
		v.setVisit_refer(request.getHeader("referer")); //접 속 전 사이트 정보
		
		System.out.println(v);
		
		try {
			vDAO.insertVisitor(sqlSession, v); //전체 방문자수 증가 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int todayCount = vDAO.getVisitTodayCount(sqlSession);
		int totalCount = vDAO.getVisitTotalCount(sqlSession);
		
		session.setAttribute("totalCount", totalCount);
		session.setAttribute("todayCount", todayCount);
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		System.out.println("리스너 종료!!!");
	}
}
