package kr.co.anolja.video.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.anolja.repository.domain.Video;

@Controller
@RequestMapping("/*")
public class VideoController {
	
	@RequestMapping(value="video", method = RequestMethod.GET)
	public String home() {
		
		return "video/video";
	}
	
	@RequestMapping(value="videoList")
	@ResponseBody
	public Video videoList(Video video) {
		
		Video v = video;		
		return v;
	}
}
