package kr.co.anolja.stastics.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.anolja.stastics.service.StasticsService;

@Controller
public class StasticsController {	
	/*
	@Autowired
	private StasticsService stasticsService; 
	*/
	@RequestMapping("/sendstat")
	public ModelAndView sendStat(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("/bgsearchresult");
		
		request.getAttribute("userName");
		
		System.out.println("userName");
		
		return mav;
	}
	
	@RequestMapping("/bgsearchresult")
	public ModelAndView searchResult(ModelAndView mav) {
		mav.setViewName("stastics/bgsearchresult");
		
		return mav;
	}

}
