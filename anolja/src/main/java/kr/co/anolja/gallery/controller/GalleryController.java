package kr.co.anolja.gallery.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.anolja.gallery.service.GalleryService;
import kr.co.anolja.repository.domain.Gallery;

@Controller
@RequestMapping("/gallery")
public class GalleryController {
	
	@Autowired
	GalleryService service;
	
	@RequestMapping("/list")
	public String gallery(Gallery gallery, Model model) throws Exception {
		model.addAttribute("list", service.selectGallery());
		return "gallery/list";
	}
	
	@RequestMapping("/listView")
	public void viewGallery(HttpServletResponse res) throws Exception {
		service.viewGallery(res);
	}
	
	@ResponseBody
	@RequestMapping("/insert")
	public String insertGallery(@RequestParam("id") String id, @RequestParam("answer") String answer,
			@RequestParam("canvasInfo") String fileInfo) throws Exception {
		service.insertGallery(id, answer, fileInfo);
		return "gallery:notice:[축하합니다]\n 모든 참여자들의 추천으로 ["+id+"]님의 그림이 명예의 전당에 올랐습니다!";
	}
}
