package kr.co.anolja.user.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.anolja.common.FileHandler;
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
		List<String> idList = mapper.getAnnonymousId();
		// 스프링 시큐리티의 BCryptPasswordEncoder 객체의 matches 메서드로 패스워드 체크
		boolean passCheck = passwordEncoder.matches(user.getPass(), temp.getPass());
		
		long loginTime = 0;
		if (temp.getLoginDate() != null) {
			loginTime = -(temp.getLoginDate().getTime() - new Date().getTime());
		}
		// 로그인 정보 처리
		if (temp.getLoginDate() == null || loginTime >= 86400000) {
			mapper.setLoginDate(temp);
		}
		
		// 익명 ID 처리
		String key = "";
		if (temp.getAnnonymousId() == null || loginTime >= 86400000) {
			key = new MailTempKey().getKey(6, false);
			for (int i = 0; i < idList.size(); i++) {
				if (key == idList.get(i)) {
					key = new MailTempKey().getKey(6, false);
					i = 0;
					continue;
				}
			}
			temp.setAnnonymousId(key);
			mapper.setAnnonymousId(temp);
		}
		
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

	@Override
	public User findId(String email) throws Exception {
		User temp = mapper.getEmailperUser(email);
		
		if (temp != null) {
			return temp;
		} else {
			return null;
		}
	}

	@Override
	public String findPass(String email, String path) throws Exception {
		User temp = mapper.getEmailperUser(email);

		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[anolja 패스워드 변경 서비스]");
		sendMail.setText(new StringBuffer().append("<h1>패스워드 변경</h1>").append("<a href='http://" + path + "/user/changePass?email=")
				.append(temp.getEmail()).append("' target='_blank'>인증 확인 후 비밀번호 변경 페이지 이동</a>").toString());
		sendMail.setFrom("anoljamanager@gmail.com", "anolja 관리자");
		sendMail.setTo(temp.getEmail());
		sendMail.send();
			
		return "비밀번호 변경을 위한 메일이 발송되었습니다.\n확인 후 비밀번호를 변경해 주세요";
	}

	@Override
	public String changePass(User user) throws Exception {
		String pass = passwordEncoder.encode(user.getPass());
		user.setPass(pass);
		mapper.changePassword(user);
		
		return "비밀번호가 정상적으로 변경되었습니다.";
	}

	@Transactional
	@Override
	public void registProfileImage(String id, MultipartFile attach) throws Exception {
		String defaultPath = "c:/java-lec/upload";
		SimpleDateFormat sdf = new SimpleDateFormat("/yyyy/MM/dd/HH");
		String detailPath = sdf.format(new Date());
		
		File dir = new File(defaultPath + detailPath);

		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		attach.transferTo(new File(defaultPath + detailPath, id + ".jpg"));
				
		User temp = new User();
		temp.setId(id);
		temp.setFilePath(detailPath);
		temp.setFileName(id + ".jpg");
		temp.setFileSize(attach.getSize());
		
		mapper.registProfileImage(temp);
	}
	
	@Override
	public void registProfileBase64Image(String id, String fileInfo) throws Exception {
		Object[] result = new FileHandler().base64Decode(id, fileInfo);
		User temp = new User();
		temp.setId(id);
		temp.setFilePath((String)result[0]);
		temp.setFileName((String)result[1]);
		temp.setFileSize((Long)result[2]);
		mapper.registProfileImage(temp);
	}

	@Override
	public void profileImageView(String id, HttpServletResponse res) throws Exception {
		User temp = mapper.selectOneUser(id);
		new FileHandler().fileViewer(temp.getFilePath(),temp.getFileName(), res);
	}

	@Override
	public void profileImageRemove(String id) throws Exception {
		User temp = mapper.selectOneUser(id);
		new FileHandler().removeFile(temp.getFilePath(),temp.getFileName());
		mapper.removeProfileImage(id);
	}

	@Override
	public User getUserInfo(String id) throws Exception {
		return mapper.selectOneUser(id);
	}

	@Override
	public void updateUserEmail(User user) throws Exception {
		mapper.updateUserEmail(user);
	}

	@Override
	public void deleteUserInfo(String id) throws Exception {
		mapper.deleteUserInfo(id);
	}

	@Override
	public String checkPass(User user) throws Exception {
		User temp = mapper.selectOneUser(user.getId());
		
		// 스프링 시큐리티의 BCryptPasswordEncoder 객체의 matches 메서드로 패스워드 체크
		boolean passCheck = passwordEncoder.matches(user.getPass(), temp.getPass());
		
		if (passCheck == true) {
			return "패스워드 확인 성공";
		} else {
			return null;
		}
	}
}
