package kr.co.anolja.repository.domain;

import java.util.Date;

public class Comment {
	private int bNo;
	private int cNo;
	private String anonymousId;
	private String content;
	private Date regDate;
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public int getcNo() {
		return cNo;
	}
	public void setcNo(int cNo) {
		this.cNo = cNo;
	}
	public String getAnonymousId() {
		return anonymousId;
	}
	public void setAnonymousId(String anonymousId) {
		this.anonymousId = anonymousId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	
}
