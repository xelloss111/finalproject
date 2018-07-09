package kr.co.anolja.game.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class GameController {

	@RequestMapping(value = "/game", method = RequestMethod.GET)
    public String gameMain() {
        return "view/game/game";
    }
	
	@RequestMapping(value = "/gameChat.do", method = RequestMethod.GET)
	public void gameChat() {}
	
}
