package kr.co.anolja.game.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.anolja.game.service.GameService;

@Controller
public class GameController {
	
	@Autowired
	private GameService service;

	@RequestMapping("/game")
    public ModelAndView chat(ModelAndView mav) {
		mav.setViewName("game/game");
		
		// 현재 세션 사용자의 정보
//		User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		System.out.println("user name: " + user.getUsername());
//		
//		mav.addObject("userid", user.getUsername());
        return mav;
    }
	
	@ResponseBody
	@RequestMapping("/gameAnswer")
	public String selectAnswer() {
		return service.selectAnswer();
	}
}
