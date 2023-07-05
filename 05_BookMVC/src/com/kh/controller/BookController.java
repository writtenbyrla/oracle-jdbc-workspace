package com.kh.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.kh.model.dao.BookDAO;
import com.kh.model.vo.Book;
import com.kh.model.vo.Member;
import com.kh.model.vo.Rent;

public class BookController {

	private BookDAO dao = new BookDAO();
	private Member member = new Member();
	
	public ArrayList<Book> printBookAll(){
		
		try {
			return dao.printBookAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean registerBook(Book book) {
		book = new Book(book.getBkTitle(), book.getBkAuthor());
		try {
			if(dao.registerBook(book)==1) {
				dao.registerBook(book);
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
				
	
	public boolean sellBook(int no) {
		try {
			dao.sellBook(no);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
	
	public boolean registerMember(Member member) {
		
		try {
			member = new Member(member.getMemberId(), member.getMemberPw(), member.getMemberName());
			dao.registerMember(member);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return false;
	}
	
	public Member login(String id, String password) {
		
		member.setMemberId(id);
		member.setMemberPw(password);
		
		try {
			if(dao.login(id, password)!=null) {
				return dao.login(id, password);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean deleteMember() { // status n인 경우
		// member 변수 로그인때 담아놔서 매개변수 따로 안받음
		
		try {
			
			dao.deleteMember(member.getMemberId(), member.getMemberPw());
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	public boolean rentBook(int no) { 
		

		
		return false;
	}
	
	public boolean deleteRent(int no) {
		
		
		
		return false;
	}
	
	public ArrayList<Rent> printRentBook(){ // 멤버 아이디 확인
		return null;
	}
}
