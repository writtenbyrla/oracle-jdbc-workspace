package com.youtube.controller;

import java.sql.SQLException;

import com.youtube.model.dao.ChannelDAO;
import com.youtube.model.dao.MemberDAO;
import com.youtube.model.vo.Channel;
import com.youtube.model.vo.Member;

public class YouTubeController {

	private Member member = new Member();
	private Channel channel = new Channel();
	private MemberDAO memberDao = new MemberDAO();
	private ChannelDAO channelDao = new ChannelDAO();
	
	// 회원가입
	public boolean register(Member member) {
		
		try {
			if(memberDao.register(member)==1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 로그인
	public Member login (String id, String password) {
		try {
			member = memberDao.login(id, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return member;
	}
	
	// 채널 추가
	public boolean addChannel(Channel channel) {
		try {
			channel.setMember(member);
			if(channelDao.addChannel(channel)==1) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 채널 수정
	public boolean updateChannel(Channel channel) {
//		myChannel();
		try {
			channel.setChannelCode(this.channel.getChannelCode());
			if(channelDao.updateChannel(channel)==1) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	

	// 채널 삭제
	public boolean deleteChannel() {
		myChannel();
		try {
			if(channelDao.deleteChannel(this.channel.getChannelCode())==1) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	

	// 내 채널 보기
	public Channel myChannel() {
		
		try {
			channel = channelDao.myChannel(this.member.getMemberId());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return channel;
	}

	
}
