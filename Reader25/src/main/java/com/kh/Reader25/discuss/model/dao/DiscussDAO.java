package com.kh.Reader25.discuss.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.discuss.model.vo.Discuss;

@Repository("dDAO")
public class DiscussDAO {

	
	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("DiscussMapper.ListCount");
	}

	public ArrayList<Discuss> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = pi.getBoardLimit() * (pi.getCurrentPage() -1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("DiscussMapper.selectList", null, rowBounds);
	}


	public int insertDAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("DiscussMapper.insertDAttachment", at);
	}

	public int insertDiscuss(SqlSessionTemplate sqlSession, Discuss d) {
		return sqlSession.insert("DiscussMapper.insertDiscuss", d);
	}

	public Discuss selectDiscussDetail(SqlSessionTemplate sqlSession, int dNo) {
		return sqlSession.selectOne("DiscussMapper.selectDiscuss", dNo);
	}

	public ArrayList<Attachment> selectAtList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("DiscussMapper.selectAtList");
	}

	public Attachment selectAt(SqlSessionTemplate sqlSession, int atcNo) {
		return sqlSession.selectOne("DiscussMapper.selectAt", atcNo);
	}

	public int updateDiscuss(SqlSessionTemplate sqlSession, Discuss d) {
		return sqlSession.update("DiscussMapper.updateDiscuss", d);
	}

	public int updateAtno(SqlSessionTemplate sqlSession, Attachment att) {
		return sqlSession.update("DiscussMapper.updateAt", att);
	}

	public int deleteDisucss(SqlSessionTemplate sqlSession, int dNo) {
		return sqlSession.update("DiscussMapper.deleteDiscuss", dNo);
	}
}
