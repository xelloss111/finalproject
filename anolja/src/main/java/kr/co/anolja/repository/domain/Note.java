package kr.co.anolja.repository.domain;

import java.util.Date;

public class Note {
	private int id;
	private String sendId;
	private String getId;
	private String title;
	private String content;
	private int status;
	private Date sendDate;
	private Date readDate;
	private int sendDel;
	private int getDel;
	
	//페이징 위한 변수
	private int pageNo;
	
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSendId() {
		return sendId;
	}
	public void setSendId(String sendId) {
		this.sendId = sendId;
	}
	public String getGetId() {
		return getId;
	}
	public void setGetId(String getId) {
		this.getId = getId;
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getSendDate() {
		return sendDate;
	}
	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	public Date getReadDate() {
		return readDate;
	}
	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}
	public int getSendDel() {
		return sendDel;
	}
	public void setSendDel(int sendDel) {
		this.sendDel = sendDel;
	}
	public int getGetDel() {
		return getDel;
	}
	public void setGetDel(int getDel) {
		this.getDel = getDel;
	}
	
	
	
	
	
	
	

}
