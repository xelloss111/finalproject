package kr.co.anolja.user.service;

import kr.co.anolja.repository.domain.User;

public interface UserService {
	public void registUser(User user, String path) throws Exception;
	public void authUser(String email) throws Exception;
	public User loginUser(User user) throws Exception;
	public User getId(String id) throws Exception;
	public User getEmail(String email) throws Exception;
}
