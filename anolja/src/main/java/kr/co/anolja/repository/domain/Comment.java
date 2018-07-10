package kr.co.anolja.repository.domain;

import java.util.Date;

public class Comment {
	private int bNo;
	private int cNo;
	private String anonymousId;
	private String pass;
	private int groupCno;
	private int groupClist;
	private int depth;
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
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public int getGroupCno() {
		return groupCno;
	}
	public void setGroupCno(int groupCno) {
		this.groupCno = groupCno;
	}
	public int getGroupClist() {
		return groupClist;
	}
	public void setGroupClist(int groupClist) {
		this.groupClist = groupClist;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
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
