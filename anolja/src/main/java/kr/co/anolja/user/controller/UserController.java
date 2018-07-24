package kr.co.anolja.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.anolja.common.CurrentUser;
import kr.co.anolja.repository.domain.User;
import kr.co.anolja.user.service.UserService;

@Controller
@RequestMapping("/user/*")
@SessionAttributes({"id", "currentUser"})
public class UserController {

	@Autowired
	private UserService service;
	
	private static final Logger logger = 
			LoggerFactory.getLogger(UserController.class);
	
//	@RequestMapping(value = "signup", method = RequestMethod.POST)
	@RequestMapping(value = "signup")
	@ResponseBody
	public String signupPost(User user, Model model, RedirectAttributes rttr,
			HttpServletRequest req) throws Exception {
		logger.info("회원 가입 중....");
		logger.info(user.toString());
		String path = req.getServerName() + ":" + req.getServerPort() + "" + req.getContextPath();
		service.registUser(user, path);
//		rttr.addFlashAttribute("msg", "가입 시 사용한 이메일 인증을 부탁 드립니다.");
		
		return "/";
	}
	
	@RequestMapping(value = "emailConfirm", method = RequestMethod.GET)
	public String emailConfirm(String email, Model model) throws Exception {
		service.authUser(email);
		model.addAttribute("email", email);
		return "user/emailConfirm";
	}
	
//	@RequestMapping(value = "login", method = RequestMethod.POST)
	@RequestMapping(value = "login")
	@ResponseBody
	public String loginPost(User user, Model model) throws Exception {
		User temp = service.loginUser(user);
		
		if (temp == null) return "아이디 또는 패스워드가 잘못되었습니다.";
		
		logger.info(temp.getId() + " : " + temp.getPass() + " : " + temp.getAuthStatus());
		
		String msg = "";
		if (temp.getAuthStatus() == 0) {
			msg = "가입된 메일 인증 후 로그인이 가능합니다";
		} else {
			model.addAttribute("id", temp.getId());
			msg = "/";
		}
		
		return msg;
	}
	
	@RequestMapping(value = "idCheck", method = RequestMethod.POST)
	@ResponseBody
	public User idCheck(@RequestParam(value="id") String id) throws Exception {
		logger.info(id);
		return service.getId(id);
	}
	
	@RequestMapping(value = "emailCheck")
	@ResponseBody
	public User emailCheck(@RequestParam(value="email") String email) throws Exception {
		logger.info(email);
		return service.getEmail(email);
	}
	
	@RequestMapping(value = "findId", method = RequestMethod.POST)
	@ResponseBody
	public String findId(@RequestParam(value="email") String email) throws Exception {
		User temp = service.findId(email);
		
		if (temp != null) {
			return temp.getId();
		} else {
			return "email에 해당하는 ID가 존재하지 않습니다.";
		}
	}
	
	@RequestMapping(value = "findPass")
	@ResponseBody
	public String findPass(User user, HttpServletRequest req) throws Exception {
		String path = req.getServerName() + ":" + req.getServerPort() + "" + req.getContextPath();
		String result = service.findPass(user, path);
		return result;
	}
	
	@RequestMapping(value = "changePass", method = RequestMethod.GET)
	public String changePassGet(String email, Model model) throws Exception {
		model.addAttribute("email", email);
		return "user/changePass";
	}
	
	@RequestMapping(value = "changePass", method = RequestMethod.POST)
	@ResponseBody
	public String changePassPost(User user) throws Exception {
		String result = service.changePass(user);
		return result;
	}
	
	@RequestMapping(value = "logout", method = RequestMethod.POST)
	@ResponseBody
	public String logoutPost(@ModelAttribute String id, SessionStatus sessionStatus) throws Exception {
		sessionStatus.setComplete();
		return "/main";
	}
	
	@RequestMapping(value = "registProfileImage")
	@ResponseBody
	public String registProfileImage(@RequestParam("id") String id, MultipartFile attach) throws Exception {
		if (id == null || attach == null) return "일시적인 오류로 프로필 이미지 등록 실패\n다시 시도하세요";
		service.registProfileImage(id, attach);
		return "프로필 이미지 등록 완료";
	}
	
	@RequestMapping(value = "registProfileBase64Image")
	@ResponseBody
	public String registProfileBase64Image(@RequestParam("id") String id, 
			@RequestParam("fileInfo") String fileInfo) throws Exception {
		if (id == null || fileInfo == null) return "일시적인 오류로 프로필 이미지 등록 실패\n다시 시도하세요";
		service.registProfileBase64Image(id, fileInfo);
		return "프로필 이미지 등록 완료";
	}
	
	@RequestMapping(value = "viewProfileImage")
	public void viewProfileImage(String id, HttpServletResponse res) throws Exception {
		service.profileImageView(id, res);
	}
	
	@RequestMapping(value = "removeProfileImage")
	@ResponseBody
	public String removeProfileImage(String id) throws Exception {
		service.profileImageRemove(id);
		return "프로필 이미지 삭제 완료";
	}
	
	@RequestMapping(value = "getUserInfo")
	@ResponseBody
	public User getUserInfo(String id) throws Exception {
		return service.getUserInfo(id);
	}
	
	@RequestMapping(value = "updateUserEmail")
	@ResponseBody
	public String updateUserEmail(User user) throws Exception {
		service.updateUserEmail(user);
		return "email 주소가 정상 변경되었습니다.";
	}
	
	@RequestMapping(value = "passwordCheck", method = RequestMethod.POST)
	@ResponseBody
	public String passwordCheck(User user) throws Exception {
		return service.checkPass(user);
	}
	
	@RequestMapping(value = "secessionUser", method = RequestMethod.POST)
	@ResponseBody
	public String secessionUser(String id, SessionStatus sessionStatus) throws Exception {
		sessionStatus.setComplete();
		service.deleteUserInfo(id);
		return "/main";
	}
}