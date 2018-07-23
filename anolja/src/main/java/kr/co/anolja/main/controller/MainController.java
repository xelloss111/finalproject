package kr.co.anolja.main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.anolja.gallery.service.GalleryService;
import kr.co.anolja.main.service.MainService;
import kr.co.anolja.repository.domain.Board;

@Controller
@RequestMapping("/*")
public class MainController {
	
	@Autowired
	private MainService service;
	@Autowired
	private GalleryService gService;
	
	@RequestMapping(value="main", method = RequestMethod.GET)
	public String home(String msg, Model model) {
		// 회원 가입 후 전달되는 메시지 출력 관련
		if (msg != null) {
			model.addAttribute("msg", msg);
		}
		//게시글 최신글 리스트 (뎁스0)
		List<Board> boardList = service.boardList();
		model.addAttribute("boardList", boardList);
		
		//갤러리
		model.addAttribute("list", gService.selectGallery());
		
		return "main/main";
	}

	
}