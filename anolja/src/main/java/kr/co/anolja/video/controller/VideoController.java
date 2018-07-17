package kr.co.anolja.video.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.anolja.repository.domain.Video;
import kr.co.anolja.video.service.VideoService;

@Controller
@RequestMapping("/*")
public class VideoController {
	
	@Autowired
	private VideoService service;
	
	//메뉴 첫 화면 video List 띄우기
	@RequestMapping(value="video", method = RequestMethod.GET)
	public String home() {
		
		return "video/video";
	}
	
	//리스트에 원하는 동영상 저장하기
	@RequestMapping(value="videoSave")
	@ResponseBody
	public void videoList(Video video) {
		
		service.insert(video);

	}
}
