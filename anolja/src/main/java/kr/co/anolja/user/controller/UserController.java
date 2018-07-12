package kr.co.anolja.user.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

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

import kr.co.anolja.repository.domain.User;
import kr.co.anolja.user.service.UserService;

@Controller
@RequestMapping("/user/*")
@SessionAttributes("id")
public class UserController {

	@Autowired
	private UserService service;
	
	private static final Logger logger = 
			LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping(value = "signup", method = RequestMethod.POST)
	public String signupPost(User user, Model model, RedirectAttributes rttr,
			HttpServletRequest req) throws Exception {
		logger.info("회원 가입 중....");
		logger.info(user.toString());
		String path = req.getServerName() + ":" + req.getServerPort() + "" + req.getContextPath();
		service.registUser(user, path);
		rttr.addFlashAttribute("msg", "가입 시 사용한 이메일 인증을 부탁 드립니다.");
		
		return "redirect:/main";
	}
	
	@RequestMapping(value = "emailConfirm", method = RequestMethod.GET)
	public String emailConfirm(String email, Model model) throws Exception {
		service.authUser(email);
		model.addAttribute("email", email);
		return "user/emailConfirm";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
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
			return "/";
		}
		
		return msg;
	}
	
	@RequestMapping(value = "idCheck", method = RequestMethod.POST)
	@ResponseBody
	public User idCheck(@RequestParam(value="id") String id) throws Exception {
		logger.info(id);
		return service.getId(id);
	}
	
	@RequestMapping(value = "emailCheck", method = RequestMethod.POST)
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
	public String findPass(@RequestParam(value="email") String email, HttpServletRequest req) throws Exception {
		String path = req.getServerName() + ":" + req.getServerPort() + "" + req.getContextPath();
		String result = service.findPass(email, path);
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
	public String registProfileImage(MultipartFile attach) throws Exception {
		System.out.println("사용자가 올린 파일 정보 : " + attach.getOriginalFilename());
		try {
			// 실제 서버 저장하기
			attach.transferTo(new File("c:/java-lec/upload", attach.getOriginalFilename()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	
}
