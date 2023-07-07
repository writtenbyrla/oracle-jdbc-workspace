package com.youtube.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.youtube.model.vo.Channel;

public interface ChannelDAOTemplate {
	
	Connection getConnect() throws SQLException;
	void closeAll(PreparedStatement st, Connection conn) throws SQLException;
	void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException;
	
	// 채널 추가, 수정, 삭제, 내 채널 보기
	int addChannel(Channel channel) throws SQLException;
	
	// 채널 수정
	int updateChannel(Channel channel) throws SQLException;
	
	// 채널 삭제
	int deleteChannel(int channelCode) throws SQLException;
	
	// 내 채널 보기
	Channel myChannel(String memberId) throws SQLException;
	
}
