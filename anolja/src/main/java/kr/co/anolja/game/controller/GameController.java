package kr.co.anolja.game.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.anolja.game.service.GameService;

@Controller
public class GameController {
	
	@Autowired
	private GameService service;

	@RequestMapping("/game")
    public String chat(RedirectAttributes rttr, HttpSession session) {
		if (session.getAttribute("id") == null) {
			rttr.addFlashAttribute("msg", "로그인 후 이용가능합니다.");
			return "redirect:/main";
		}
        return "game/game";
    }
	
	@ResponseBody
	@RequestMapping("/gameAnswer")
	public String selectAnswer() {
		return service.selectAnswer();
	}
}
