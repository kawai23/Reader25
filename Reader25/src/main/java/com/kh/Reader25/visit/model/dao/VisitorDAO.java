package com.kh.Reader25.visit.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.Reader25.board.model.vo.PageInfo;
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

	public List<Map<String,String>> getDayVisitor(SqlSessionTemplate sqlSession, String today) {
		return sqlSession.selectList("visitorMapper.getDayVisitor", today);
	}

	public List<Map<String, String>> getMonthVisitor(SqlSessionTemplate sqlSession, String month) {
		return sqlSession.selectList("visitorMapper.getMonthVisitor", month);
	}

	public ArrayList<Visitor> selectListVisitor(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1)* pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("visitorMapper.selectListVisitor", null, rowBounds);
	}


}
