package com.kh.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.model.vo.Book;
import com.kh.model.vo.Member;
import com.kh.model.vo.Rent;

import config.ServerInfo;

public class BookDAO implements BookDAOTemplate {

	private Properties p = new Properties();
	
	// 드라이버 로딩
	public BookDAO() {
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

	// 전체 책 조회
	public ArrayList<Book> printBookAll() throws SQLException {
		Connection conn = getConnect();

		PreparedStatement st = conn.prepareStatement(p.getProperty("printBookAll"));
		
		ResultSet rs = st.executeQuery();
		
		ArrayList<Book> bookList = new ArrayList<>();
		
		while(rs.next()) {
			bookList.add(new Book(rs.getInt("bk_no"), rs.getString("bk_title"), rs.getString("bk_author")));		
		}
		
		closeAll(rs, st,conn);
		
		return bookList;
	}

	// 책 등록
	public int registerBook(Book book) throws SQLException {
		Connection conn = getConnect();

		PreparedStatement st = conn.prepareStatement(p.getProperty("registerBook"));
		
		st.setString(1, book.getBkTitle());
		st.setString(2, book.getBkAuthor());
		
		int result = st.executeUpdate();
		
		closeAll(st, conn);
		
		// 반환값 타입이 int인 경우 st.executeUpdate() 때문
		return result;
	}

	// 책 삭제
	public int sellBook(int no) throws SQLException {
		
		Connection conn = getConnect();

		PreparedStatement st = conn.prepareStatement(p.getProperty("sellBook"));
		
		st.setInt(1, no);
		
		int result = st.executeUpdate();
		
		closeAll(st, conn);
		
		// 반환값 타입이 int인 경우 st.executeUpdate() 때문
		return result;
	}

	// 회원가입
	public int registerMember(Member member) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerMember"));

		st.setString(1, member.getMemberId());
		st.setString(2, member.getMemberPwd());
		st.setString(3, member.getMemberName());

		int result = st.executeUpdate();

		closeAll(st, conn);

		return result;
	}

	// 로그인
	public Member login(String id, String password) throws SQLException {
		
		Connection conn = getConnect();

		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		
		
		st.setString(1, id);
		st.setString(2, password);
		
		ResultSet rs = st.executeQuery();
		Member member = null;
		
		if(rs.next()) {
		member = new Member();
		member.setMemberNo(rs.getInt("member_no"));
		member.setMemberId(rs.getString("member_id"));
		member.setMemberPwd(rs.getString("member_pwd"));
		member.setMemberName(rs.getString("member_name"));
		member.setStatus(rs.getString("status").charAt(0));
		member.setEnrollDate(rs.getDate("enroll_date"));
		}

		closeAll(rs, st, conn);
		return member;
	}
		



	// 회원탈퇴
	public int deleteMember(String id, String password) throws SQLException {
		Connection conn = getConnect();

		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteMember"));
		
		st.setString(1, id);
		st.setString(2, password);
		
		int result = st.executeUpdate();

		closeAll(st, conn);

		return result;
	}

	
	// 책 대여
	public int rentBook(Rent rent) throws SQLException {
		Connection conn = getConnect();
		
		PreparedStatement st = conn.prepareStatement(p.getProperty("rentBook"));
		
		st.setInt(1, rent.getMember().getMemberNo());
		
		
		st.setInt(2, rent.getBook().getBkNo());
		
		
		
		int result = st.executeUpdate();

		closeAll(st, conn);

		return result;
	}

	// 대여 취소
	public int deleteRent(int no) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteRent"));
		
		st.setInt(1, no);

		int result = st.executeUpdate();
		closeAll(st, conn);

		return result;
	}

	// 내가 대여한 책 조회
	public ArrayList<Rent> printRentBook(String id) throws SQLException {
		// while문 안에서 Rent rent = new Rent();
		// setter 사용
		// rest.setBook(new Book(rs.getString("bk_title"), rs.getString("bk_author"))
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("printRentBook"));
		
		st.setString(1, id);
		
		ResultSet rs = st.executeQuery();
		
		ArrayList<Rent> rentList = new ArrayList<>();
		
		
		while(rs.next()){
			Rent rent = new Rent();
			rent.setRentNo(rs.getInt("rent_no"));
			rent.setRentDate(rs.getDate("rent_date"));
			rent.setBook(new Book(rs.getString("bk_title"), rs.getString("bk_author")));
			rentList.add(rent);
		}
		
		closeAll(rs, st,conn);
		return rentList;
	}

}
