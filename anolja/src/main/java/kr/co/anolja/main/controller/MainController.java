package kr.co.anolja.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/*")
public class MainController {
	@RequestMapping(value="main", method = RequestMethod.GET)
	public String home(String msg, Model model) {
		// 회원 가입 후 전달되는 메시지 출력 관련
		if (msg != null) {
			model.addAttribute("msg", msg);
		}
		return "main/main";
	}
}
