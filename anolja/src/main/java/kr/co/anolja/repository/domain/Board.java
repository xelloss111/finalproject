package kr.co.anolja.repository.domain;

import java.util.Date;

public class Board {
	private String anonymousId;
	private String pass;
	private int bNo;
	private int groupBno;
	private int groupBlist;
	private int depth;
	private String title;
	private String content;
	private Date regDate;
	private int viewCnt;
	
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
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public int getGroupBno() {
		return groupBno;
	}
	public void setGroupBno(int groupBno) {
		this.groupBno = groupBno;
	}
	public int getGroupBlist() {
		return groupBlist;
	}
	public void setGroupBlist(int groupBlist) {
		this.groupBlist = groupBlist;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	
	// 페이징
	
	private int pageNo = 1;

	public int getBegin() {
		return (pageNo -1) * 10 + 1;
	}
	public int getEnd() {
		return pageNo * 10;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
}
