package kr.co.anolja.stastics.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StasticsController {	
	@RequestMapping("/bgsearch")
	public ModelAndView search(ModelAndView mav) {
		mav.setViewName("stastics/bgsearch");
		
		return mav;
	}
	@RequestMapping("/bgsearchresult")
	public ModelAndView searchResult(ModelAndView mav) {
		mav.setViewName("stastics/bgsearchresult");
		
		return mav;
	}

}
