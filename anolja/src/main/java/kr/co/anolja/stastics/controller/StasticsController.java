package kr.co.anolja.stastics.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.anolja.common.constant.GameMode;
import kr.co.anolja.common.constant.Season;
import kr.co.anolja.stastics.service.StasticsService;

@Controller
public class StasticsController {	
	
	@Autowired
	private StasticsService stasticsService; 
	
	@RequestMapping("/sendname")
	public String sendStat(HttpServletRequest request, RedirectAttributes rttr) {
        
		String userName =  request.getParameter("userName");
		
		rttr.addAttribute("userName",userName);
		
		return "redirect:/bgsearchresult";
	}
	
	@RequestMapping("/bgsearchresult")
	public ModelAndView searchResult(@RequestParam(value ="userName")String userName,ModelAndView mav) {
		mav.addObject("characterName",userName);
	
		Map<String,Object> soloInfo = stasticsService.getSeasonInfo(stasticsService.getAccountId(userName), Season.season6, GameMode.solo);
		Map<String,Object> duoInfo = stasticsService.getSeasonInfo(stasticsService.getAccountId(userName), Season.season6, GameMode.duo);
		Map<String,Object> squadInfo = stasticsService.getSeasonInfo(stasticsService.getAccountId(userName), Season.season6, GameMode.squad);
		
		System.out.println("리스트정보:"+stasticsService.getMatchId(stasticsService.getAccountId(userName)));
		
		List<Map<String,Object>> ulist = stasticsService.getMatchUserInfoList(stasticsService.getMatchId(stasticsService.getAccountId(userName)), userName);
		System.out.println(ulist.toString());
		
//		System.out.println("최후의 리스트:"+list.toString());
//		List<Map<String,Object>> list = stasticsService.getMatchInfoList(stasticsService.getMatchId(stasticsService.getAccountId(userName)));
//		System.out.println(list.toString());
		mav.addObject("ulist",ulist);
		
		mav.addObject("solo",soloInfo);
		mav.addObject("duo",duoInfo);
		mav.addObject("squad",squadInfo);
		
		mav.setViewName("stastics/bgsearchresult");
		
		return mav;
	}
	
	@RequestMapping("/getseasoninfo")
	@ResponseBody
	public List<Map<String,Object>> getSeasonInfo(HttpServletRequest req){
		
		String userName = req.getParameter("characterName");
		String season = req.getParameter("season");
		
		Map<String,Object> soloInfo = stasticsService.getSeasonInfo(stasticsService.getAccountId(userName), season, GameMode.solo);
		Map<String,Object> duoInfo = stasticsService.getSeasonInfo(stasticsService.getAccountId(userName), season, GameMode.duo);
		Map<String,Object> squadInfo = stasticsService.getSeasonInfo(stasticsService.getAccountId(userName), season, GameMode.squad);
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		
		list.add(soloInfo);
		list.add(duoInfo);
		list.add(squadInfo);
		
		return list;
	}
	
	

}
