package kr.co.anolja.user.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.anolja.repository.domain.User;
import kr.co.anolja.user.service.UserService;

@Controller
@SessionAttributes("user")
@RequestMapping("/user/*")
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
		String path = req.getContextPath();
		System.out.println(path);
		service.registUser(user, path);
		rttr.addFlashAttribute("msg", "가입 시 사용한 이메일 인증을 부탁 드립니다.");
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "emailConfirm", method = RequestMethod.GET)
	public String emailConfirm(String email, Model model) throws Exception {
		service.authUser(email);
		model.addAttribute("email", email);
		return "user/emailConfirm";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public void loginGet() {}
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginPost(User user, Model model) throws Exception {
		User temp = service.loginUser(user);
		
		logger.info(temp.getId() + " : " + temp.getPass());
		
		if (temp != null && temp.getAuthStatus() == 1) {
			model.addAttribute("msg", "로그인 완료");
			model.addAttribute("user", temp);
		} else if (temp != null && temp.getAuthStatus() == 0) {
			model.addAttribute("msg", "메일 인증 후 로그인이 가능합니다.");
			return "index";
		}
		
		return "main/main";
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
}
