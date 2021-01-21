package com.kh.Reader25.visit.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.Reader25.visit.model.vo.Visitor;

@Repository("vDAO")
public class VisitorDAO {

	public int insertVisitor(SqlSessionTemplate sqlSession,Visitor v) throws Exception{
		return sqlSession.insert("visitorMapper.insertVisitor",v);
	}

	public int getVisitTodayCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("visitorMapper.getVisitTodayCount");
	}

	public int getVisitTotalCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("visitorMapper.getVisitTotalCount");
	}

	public int getVisitMonthCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("visitorMapper.getVisitMonthCount");
	}

	public List<Map<String,String>> getDayVisitor(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("visitorMapper.getDayVisitor");
	}

	public List<Map<String, String>> getMonthVisitor(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("visitorMapper.getMonthVisitor");
	}


}
