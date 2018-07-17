package kr.co.anolja.repository.domain;

public class Game {
	private int ano;
	private String answer;
	private static String questionNo;
	private static String questionuser;
	
	public static String getQuestionNo() {
		return questionNo;
	}
	public static void setQuestionNo(String questionNo) {
		Game.questionNo = questionNo;
	}
	public static String getQuestionuser() {
		return questionuser;
	}
	public static void setQuestionuser(String questionuser) {
		Game.questionuser = questionuser;
	}
	public int getAno() {
		return ano;
	}
	public void setAno(int ano) {
		this.ano = ano;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
}
