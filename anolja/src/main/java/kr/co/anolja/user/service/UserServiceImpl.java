package kr.co.anolja.user.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.anolja.common.MailHandler;
import kr.co.anolja.common.MailTempKey;
import kr.co.anolja.repository.domain.User;
import kr.co.anolja.repository.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {
	
	private static final Logger logger = 
			LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired // 매퍼 자동 주입
	private UserMapper mapper;
	
	@Autowired // 메일 방송 객체 자동 주입
	private JavaMailSender mailSender;
	
	@Autowired // 암호화 처리 객체 자동 주입
	private BCryptPasswordEncoder passwordEncoder;
	
	@Transactional
	@Override
	public void registUser(User user, String path) throws Exception {
		// 스프링 시큐리티의 BCryptPasswordEncoder 객체로 패스워드 암호화 처리
		String encPassword = passwordEncoder.encode(user.getPass());
		user.setPass(encPassword);
		logger.info("암호화된 패스워드 : " + user.getPass());
		
		// 사용자 DB 등록
		mapper.registUser(user);
		String key = new MailTempKey().getKey(50, false);
		
		// 인증키 DB 등록
		user.setAuthKey(key);
		mapper.createAuthKey(user);
		
		// 인증 메일 발송
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[anolja 서비스 이메일 인증]");
		sendMail.setText(new StringBuffer().append("<h1>메일인증</h1>").append("<a href='http://" + path + "/user/emailConfirm?email=")
				.append(user.getEmail()).append("&key=").append(key).append("' target='_blank'>이메일 인증 확인</a>").toString());
		sendMail.setFrom("anoljamanager@gmail.com", "anolja 관리자");
		sendMail.setTo(user.getEmail());
		sendMail.send();
	}
	
	@Override
	public void authUser(String email) throws Exception {
		mapper.authUser(email);
	}

	@Override
	public User loginUser(User user) throws Exception {
		User temp = mapper.selectOneUser(user.getId());
		// 스프링 시큐리티의 BCryptPasswordEncoder 객체의 matches 메서드로 패스워드 체크
		boolean passCheck = passwordEncoder.matches(user.getPass(), temp.getPass());
		
		if (temp != null && passCheck == true) {
			return temp;
		} else {
			return null;
		}
	}

	@Override
	public User getId(String id) throws Exception {
		User temp = mapper.getIdperUser(id);
		
		if (temp != null) {
			return temp;
		} else {
			return null;
		}
	}

	@Override
	public User getEmail(String email) throws Exception {
		User temp = mapper.getEmailperUser(email);
		if (temp != null) {
			return temp;
		} else {
			return null;
		}
	}
}
