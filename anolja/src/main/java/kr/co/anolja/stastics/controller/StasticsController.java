package kr.co.anolja.stastics.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.anolja.stastics.service.StasticsService;

@Controller
public class StasticsController {	
	
	@Autowired
	private StasticsService stasticsService; 
	
	@RequestMapping("/sendname")
	public String sendStat(HttpServletRequest request, RedirectAttributes rttr) {
        
		String userName =  request.getParameter("userName");
		
		rttr.addAttribute("userName",userName);
		
		System.out.println(userName);
		
		return "redirect:/bgsearchresult";
	}
	
	@RequestMapping("/bgsearchresult")
	public ModelAndView searchResult(@RequestParam(value ="userName")String userName,ModelAndView mav) {
		System.out.println("Result");
		System.out.println("Name:"+ userName);
	
		Map<String,Object> soloInfo = stasticsService.getSeasonInfo(stasticsService.getAccountId(userName), Season.season6, GameMode.solo);
		Map<String,Object> duoInfo = stasticsService.getSeasonInfo(stasticsService.getAccountId(userName), Season.season6, GameMode.duo);
		Map<String,Object> squadInfo = stasticsService.getSeasonInfo(stasticsService.getAccountId(userName), Season.season6, GameMode.squad);
		
		System.out.println(soloInfo);
		System.out.println(duoInfo);
		System.out.println(squadInfo);
		
		mav.addObject("solo",soloInfo);
		mav.addObject("duo",duoInfo);
		mav.addObject("squad",squadInfo);
		
		mav.setViewName("stastics/bgsearchresult");
		
		return mav;
	}

}
