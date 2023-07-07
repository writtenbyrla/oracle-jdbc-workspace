package com.youtube.model.vo;

public class Member {
	private String memberId;
	private String memberPassword;
	private String memberNickName;
	private String memberEmail;
	private String memberPhone;
	private String memberGender;
	private String memberAutority;
	
	public Member() {}

	public Member(String memberId, String memberPassword, String memberNickName, String memberEmail, String memberPhone,
			String memberGender, String memberAutority) {
		this.memberId = memberId;
		this.memberPassword = memberPassword;
		this.memberNickName = memberNickName;
		this.memberEmail = memberEmail;
		this.memberPhone = memberPhone;
		this.memberGender = memberGender;
		this.memberAutority = memberAutority;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberPassword() {
		return memberPassword;
	}

	public void setMemberPassword(String memberPassword) {
		this.memberPassword = memberPassword;
	}

	public String getMemberNickName() {
		return memberNickName;
	}

	public void setMemberNickName(String memberNickName) {
		this.memberNickName = memberNickName;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getMemberPhone() {
		return memberPhone;
	}

	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}

	public String getMemberGender() {
		return memberGender;
	}

	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}

	public String getMemberAutority() {
		return memberAutority;
	}

	public void setMemberAutority(String memberAutority) {
		this.memberAutority = memberAutority;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", memberPassword=" + memberPassword + ", memberNickName="
				+ memberNickName + ", memberEmail=" + memberEmail + ", memberPhone=" + memberPhone + ", memberGender="
				+ memberGender + ", memberAutority=" + memberAutority + "]";
	}

	
	
}
