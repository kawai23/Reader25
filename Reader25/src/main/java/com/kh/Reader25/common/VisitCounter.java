package com.kh.Reader25.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.kh.Reader25.visit.model.dao.VisitorDAO;
import com.kh.Reader25.visit.model.vo.Visitor;

public class VisitCounter implements HttpSessionListener{
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		SqlSessionTemplate sqlSession = getSessionService(se);
		HttpSession session = se.getSession();
		RequestAttributes ra = RequestContextHolder.currentRequestAttributes();
		ServletRequestAttributes sra = (ServletRequestAttributes)ra;
		HttpServletRequest request = sra.getRequest();
		
		Visitor v = new Visitor();
		v.setVisit_ip(request.getRemoteAddr());
		v.setVisit_agent(request.getHeader("User-Agent")); //브라우저 정보
		v.setVisit_refer(request.getHeader("referer")); //접 속 전 사이트 정보
		
		VisitorDAO vDAO = new VisitorDAO();
		try {
			vDAO.insertVisitor(sqlSession,v); //전체 방문자수 증가 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int todayCount = vDAO.getVisitTodayCount(sqlSession);
		int totalCount = vDAO.getVisitTotalCount(sqlSession);
		
		session.setAttribute("totalCount", totalCount);
		session.setAttribute("todayCount", todayCount);
	}
	private SqlSessionTemplate getSessionService(HttpSessionEvent se) {
		WebApplicationContext context = WebApplicationContextUtils
				.getWebApplicationContext(se.getSession().getServletContext());
		return  (SqlSessionTemplate) context.getBean("sqlSessionTemplate");
	}
	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
	}
}
