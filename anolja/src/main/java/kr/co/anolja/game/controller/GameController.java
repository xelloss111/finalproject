package kr.co.anolja.game.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.anolja.common.handler.GameChatHandler;

@Controller
public class GameController {

	@RequestMapping("/game")
    public String chat(Model model, RedirectAttributes rttr, HttpSession session) {
		if (session.getAttribute("id") == null) {
			rttr.addFlashAttribute("msg", "로그인 후 이용가능합니다.");
			return "redirect:/main";
		}
		
//		for (int i = 0; i < WebSocketHandler.chatList.size(); i++) {
//			System.out.println("컨트롤러: "+WebSocketHandler.chatList.get(i));
//		}
		model.addAttribute("chatList", GameChatHandler.chatList);
		
        return "game/game";
    }
}
