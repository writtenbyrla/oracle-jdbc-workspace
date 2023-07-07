package com.youtube;

import java.util.Scanner;

import com.youtube.controller.YouTubeController;
import com.youtube.model.vo.Channel;
import com.youtube.model.vo.Member;

public class Application {

	private Scanner sc = new Scanner(System.in);
	private YouTubeController yc = new YouTubeController();
	
	public static void main(String[] args) {
		
		Application app = new Application();
//		app.register();
//		app.login();
		app.addChannel();
//		app.updateChannel();
//		app.deleteChannel();
//		app.myChannel();
	}
	
	// 회원가입
	public void register() {
		System.out.print("아이디 입력 : ");
		String id = sc.nextLine();
		System.out.print("비밀번호 입력 : ");
		String password = sc.nextLine();
		System.out.print("닉네임 입력 : ");
		String nickname = sc.nextLine();
		
		Member member = new Member();
		member.setMemberId(id);
		member.setMemberPassword(password);
		member.setMemberNickName(nickname);
		if(yc.register(member)) {
			System.out.println("회원가입에 성공하셨습니다.");
		} else {
			System.out.println("회원가입에 실패하였습니다.");
		}
	}
	
	// 로그인
	public void login() {
		System.out.print("아이디 입력 : ");
		String id = sc.nextLine();
		System.out.print("비밀번호 입력 : ");
		String password = sc.nextLine();

		Member member = yc.login(id, password);
		if(member!=null) {
			System.out.println(member.getMemberNickName() + "님, 환영합니다!");
		} else {
			System.out.println("로그인에 실패했습니다.");
		}
	}
	
	// 채널 추가
	public void addChannel() {
		yc.login("user1", "1234");
		System.out.print("채널명 : ");
		String title = sc.nextLine();
		
		Channel channel = new Channel();
		channel.setChannelName(title);
		
		if(yc.addChannel(channel)) {
			System.out.println("채널이 추가되었습니다.");
		} else {
			System.out.println("채널 추가에 실패하였습니다.");
		}
	}

	public void updateChannel() {
		yc.login("user1", "1234");
		myChannel();
		System.out.print("변경할 채널명 : ");
		String title = sc.nextLine();
		
		Channel channel = new Channel();
		channel.setChannelName(title);
		
		if(yc.updateChannel(channel)) {
			System.out.println("채널이 수정되었습니다.");
		} else {
			System.out.println("채널 수정에 실패하였습니다.");
		}	
	}
	
	public void deleteChannel() {
		yc.login("user1", "1234");
		myChannel();
		if(yc.deleteChannel()) {
			System.out.println("채널 삭제 완료");
		} else {
			System.out.println("채널 삭제 실패");
		}
	}
	
	// 내 채널 보기
	public void myChannel() {
		yc.login("user1", "1234");
		Channel channel = yc.myChannel();
		System.out.println(channel.getChannelName() + " / " + channel.getMember().getMemberNickName());
	}
	
}
