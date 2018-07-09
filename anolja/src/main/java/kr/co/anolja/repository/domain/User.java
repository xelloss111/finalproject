package kr.co.anolja.repository.domain;

import java.util.Date;

public class User {
	private String id;
	private String pass;
	private String email;
	private int gameVictory;
	private String authKey;
	private int authStatus;
	private Date regDate;
	
	public String getAuthKey() {
		return authKey;
	}
	public void setAuthKey(String authKey) {
		this.authKey = authKey;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getGameVictory() {
		return gameVictory;
	}
	public void setGameVictory(int gameVictory) {
		this.gameVictory = gameVictory;
	}
	public int getAuthStatus() {
		return authStatus;
	}
	public void setAuthStatus(int authStatus) {
		this.authStatus = authStatus;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
}
