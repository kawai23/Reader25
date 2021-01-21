package com.kh.Reader25.book.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.Pay;
import com.kh.Reader25.book.model.vo.Book;

@Repository("b_DAO")
public class BookDAO {
	public int getListCount(SqlSessionTemplate sqlSession, int code) {
		return sqlSession.selectOne("boardMapper.selectListCount", code);
	}

	public ArrayList<Book> selectList(SqlSessionTemplate sqlSession, PageInfo pi, int code) {
		int offset = pi.getBoardLimit() * (pi.getCurrentPage() -1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("bookMapper.selectList", code, rowBounds);
	}

	public int getPayListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("bookMapper.getPayList");
	}

	public ArrayList<Pay> selectPayList(SqlSessionTemplate sqlSession,PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1)* pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("bookMapper.selectPayList", null, rowBounds);
	}

	public int insertBook(SqlSessionTemplate sqlSession, Book book) {
		
		return sqlSession.insert("bookMapper.insertBook", book);
	}
}
