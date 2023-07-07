package com.youtube.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.youtube.model.vo.CommentLike;
import com.youtube.model.vo.VideoComment;
import com.youtube.model.vo.VideoLike;

public interface CommentLikeDAOTemplate {
	
	Connection getConnect() throws SQLException;
	void closeAll(PreparedStatement st, Connection conn) throws SQLException;
	void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException;
	
	// VideoLike
	// 영상 좋아요 추가
	int addLike(VideoLike like) throws SQLException;
	
	// 좋아요 취소
	int deleteLike(int likeCode) throws SQLException;
	
	// VideoComment
	// 댓글 추가
	int addComment(VideoComment comment) throws SQLException;
	
	// 댓글 수정
	int updateComment(VideoComment comment) throws SQLException;
	
	// 댓글 삭제
	int deleteComment(int commentCode) throws SQLException;
	
	// 비디오 1개 보기에 따른 댓글들 보기
	ArrayList<VideoComment> videoCommentList(int videoCode) throws SQLException;
	
	// CommentLike
	// 댓글 좋아요 추가
	int addCommentLike(CommentLike like) throws SQLException;
	
	// 댓글 좋아요 취소
	int deleteCommentLike(int likeCode) throws SQLException;
	
}
