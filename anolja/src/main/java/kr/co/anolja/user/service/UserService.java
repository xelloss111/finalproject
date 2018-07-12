package kr.co.anolja.user.service;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import kr.co.anolja.repository.domain.User;

public interface UserService {
	public void registUser(User user, String path) throws Exception;
	public void authUser(String email) throws Exception;
	public User loginUser(User user) throws Exception;
	public User getId(String id) throws Exception;
	public User getEmail(String email) throws Exception;
	public User findId(String email) throws Exception;
	public String findPass(String email, String path) throws Exception;
	public String changePass(User user) throws Exception;
	public void registProfileImage(String id, MultipartFile attach) throws Exception;
	public void profileImageView(String id, HttpServletResponse res) throws Exception;
	public void profileImageRemove(String id) throws Exception;
	public User getUserInfo(String id) throws Exception;
}
