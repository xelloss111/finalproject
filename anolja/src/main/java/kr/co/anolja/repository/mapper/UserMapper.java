package kr.co.anolja.repository.mapper;

import kr.co.anolja.repository.domain.User;

public interface UserMapper {
	void registUser(User user);
	void createAuthKey(User user);
	void authUser(String email);
	User selectOneUser(User user);
	User getIdperUser(String id);
	User getEmailperUser(String email);
}
