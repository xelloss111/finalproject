package kr.co.anolja.repository.mapper;

import kr.co.anolja.repository.domain.User;

public interface UserMapper {
	void registUser(User user);
	void createAuthKey(User user);
	void authUser(String email);
	User selectOneUser(String id);
	User getIdperUser(String id);
	User getEmailperUser(String email);
	void changePassword(User user);
	void registProfileImage(User user);
	void removeProfileImage(String id);
	void updateUserEmail(User user);
}
