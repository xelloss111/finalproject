package kr.co.anolja.stastics.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
		
		String userAccount = stasticsService.getAccountId(userName);
		
		if(userAccount.equals("입력하신 아이디와 일치하는 아이디가 없습니다.")) {
			mav.addObject("errAlert", userAccount);
			mav.setViewName("stastics/bgsearch");
			
			return mav;
		}
	
		Map<String,Object> soloInfo = stasticsService.getSeasonInfo(userAccount, Season.season6, GameMode.solo);
		Map<String,Object> duoInfo = stasticsService.getSeasonInfo(userAccount, Season.season6, GameMode.duo);
		Map<String,Object> squadInfo = stasticsService.getSeasonInfo(userAccount, Season.season6, GameMode.squad);
		
		//System.out.println("리스트정보:"+stasticsService.getMatchId(userAccount));
		
		List<Map<String,Object>> ulist = stasticsService.getMatchUserInfoList(stasticsService.getMatchId(userAccount), userName);
		System.out.println("매치기록:"+ulist.toString());
		
		//각해 당 게임 모드에 맞는 매치기록만 뽑아낸다. API에 접근 하는 메소드가 아닌 가공용 메소드
		List<Map<String,Object>> soloMatchInfo= stasticsService.getMatchInfoForEachMode(ulist,"solo");
		List<Map<String,Object>> duoMatchInfo= stasticsService.getMatchInfoForEachMode(ulist,"duo");
		List<Map<String,Object>> squadMatchInfo= stasticsService.getMatchInfoForEachMode(ulist,"squad");
		System.out.println("솔로매치인포:"+soloMatchInfo.toString());
		System.out.println("듀오매치인포:"+duoMatchInfo.toString());
		System.out.println("스쿼드매치인포:"+squadMatchInfo.toString());
		
		mav.addObject("soloMatchInfo",soloMatchInfo);
		mav.addObject("duoMatchInfo",duoMatchInfo);
		mav.addObject("squadMatchInfo",squadMatchInfo);
	
		
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
		String userAccount = stasticsService.getAccountId(userName);
		System.out.println(userName);
		System.out.println(season);
		
		Map<String,Object> soloInfo = stasticsService.getSeasonInfo(userAccount, season, GameMode.solo);
		Map<String,Object> duoInfo = stasticsService.getSeasonInfo(userAccount, season, GameMode.duo);
		Map<String,Object> squadInfo = stasticsService.getSeasonInfo(userAccount, season, GameMode.squad);
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		
		System.out.println("솔로인포:"+soloInfo);
		System.out.println("듀오인포:"+duoInfo);
		System.out.println("스쿼드인포:"+squadInfo);
		
		
		list.add(soloInfo);
		list.add(duoInfo);
		list.add(squadInfo);
		
		return list;
	}
	
	

}
