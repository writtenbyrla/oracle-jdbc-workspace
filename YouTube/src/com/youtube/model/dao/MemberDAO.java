package com.youtube.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.youtube.model.vo.Member;
import com.youtube.model.vo.Subscribe;

import config.ServerInfo;

public class MemberDAO implements MemberDAOTemplate{

	private Properties p = new Properties();
	
	// 드라이버 로딩
	public MemberDAO() {
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			Class.forName(ServerInfo.DRIVER_NAME);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	// 디비 연결
	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		return conn;
	}

	// 자원반납1
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		st.close();
		conn.close();
	}

	// 자원반납2
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
		closeAll(st, conn); // 자원반납1 불러옴
		rs.close(); // rs 추가
	}

	// 회원가입
	@Override
	public int register(Member member) throws SQLException {
		Connection conn = getConnect();

		PreparedStatement st = conn.prepareStatement(p.getProperty("register"));
		
		st.setString(1, member.getMemberId());
		st.setString(2, member.getMemberPassword());
		st.setString(3, member.getMemberNickName());
			
		int result = st.executeUpdate();
		
		closeAll(st, conn);
		return result;
		
	}

	// 로그인
	@Override
	public Member login(String id, String password) throws SQLException {
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		
		st.setString(1, id);
		st.setString(2, password);
		
		ResultSet rs = st.executeQuery();
		
		Member member = null;
		
		if(rs.next()) {
		member = new Member();
		member.setMemberId(rs.getString("member_id"));
		member.setMemberPassword(rs.getString("member_password"));
		member.setMemberNickName(rs.getString("member_nickname"));
//		member.setMemberEmail(rs.getString("member_email"));
//		member.setMemberPhone(rs.getString("member_phone"));
//		member.setMemberGender(rs.getString("member_gender"));
//		member.setMemberAutority(rs.getString("member_autority"));
		}

		closeAll(rs, st, conn);
		return member;
	}

	// 구독 추가
	@Override
	public int addSubscribe(Subscribe subscribe) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("addsubscribe"));
		
		st.setString(1, subscribe.getMember().getMemberId());
		st.setInt(2, subscribe.getChannel().getChannelCode());
		
		int result = st.executeUpdate();
		
		closeAll(st, conn);
		
		return result;
	}

	// 구독 삭제
	@Override
	public int deleteSubscribe(int subsCode) throws SQLException {
		return 0;
	}

	// 내 구독 보기
	@Override
	public ArrayList<Subscribe> mySubscribeList(String memberId) throws SQLException {
		return null;
	}


}
