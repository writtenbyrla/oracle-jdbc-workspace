package com.youtube.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.youtube.model.vo.Member;
import com.youtube.model.vo.Subscribe;

public interface MemberDAOTemplate {
	
	Connection getConnect() throws SQLException;
	void closeAll(PreparedStatement st, Connection conn) throws SQLException;
	void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException;

	// Member
	// 회원가입
	int register(Member member) throws SQLException;
	
	// 로그인
	Member login(String id, String password) throws SQLException;
	
	// Subscribe
	// 구독 추가
	int addSubscribe(Subscribe subscribe) throws SQLException;
	
	// 구독 취소
	int deleteSubscribe(int subsCode) throws SQLException;
	
	// 내가 구독한 채널 목록 보기
	ArrayList<Subscribe> mySubscribeList(String memberId) throws SQLException;
}
