package kr.co.anolja.common;

import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;


// 메일 전송 시 필요한 보내는 사람, 받는 사람 메시지 적용 등에 대한 처리 클래스
public class MailHandler {
	private JavaMailSender mailSender;
	private MimeMessage message;
	private MimeMessageHelper messageHelper;
	
	public MailHandler(JavaMailSender mailSender) throws Exception {
		this.mailSender = mailSender;
		message = this.mailSender.createMimeMessage();
		messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	}
	
	public void setSubject(String subject) throws MessagingException {
		messageHelper.setSubject(subject);
	}
	
	public void setText(String htmlContext) throws MessagingException {
		messageHelper.setText(htmlContext, true);
	}
	
	public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException {
		messageHelper.setFrom(email, name);
	}
	
	public void setTo(String email) throws MessagingException {
		messageHelper.setTo(email);
	}
	
	public void addInline(String contentId, DataSource dataSource) throws MessagingException {
		messageHelper.addInline(contentId, dataSource);
	}
	
	public void send() {
		mailSender.send(message);
	}
}
