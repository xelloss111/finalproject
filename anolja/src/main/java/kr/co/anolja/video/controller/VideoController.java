package kr.co.anolja.video.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.anolja.repository.domain.Video;
import kr.co.anolja.video.service.VideoService;

@Controller
@RequestMapping("/*")
public class VideoController {
	
	@Autowired
	private VideoService service;
	
	//메뉴 첫 화면 video List 띄우기. 로그인한 계정의 저장소 리스트 가져오기
	@RequestMapping(value="video")
	public String home(Model model, HttpSession session) throws Exception {
		
		String userId =(String)session.getAttribute("id");
		model.addAttribute("tankList", service.selectUserTankId(userId));
		
		return "video/video";
	}
	
	//리스트에 원하는 동영상 저장하기
	@RequestMapping(value="videoSave")
	@ResponseBody
	public void videoList(Video video) {
		System.out.println(video);
		service.insert(video);
	}
	
	//특정 저장소 선택 시 리스트 불러오기
	@RequestMapping(value="viewTankList")
	@ResponseBody
	public List<Video> viewTankList(Model model, HttpSession session, String tankId) throws Exception {
		
		String userId =(String)session.getAttribute("id");
		List<Video> list = service.selectMyTank(userId, tankId);
		model.addAttribute("tankList", list);
		
		return list;
	}
	
}
