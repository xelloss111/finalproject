package kr.co.anolja.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.anolja.board.service.BoardService;
import kr.co.anolja.repository.domain.Board;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/list")
	public String selectList(Model model) throws Exception{
		model.addAttribute("list", boardService.boardList());
		return "board/list";
	}
	
	@RequestMapping("/write")
	public String boardWrite(Board board, Model model, HttpServletRequest request) throws Exception{
		return "board/write";
	}
	
	@RequestMapping("/insert")
	public String boardInsert(Board board) throws Exception {
		System.out.println(board.getAnonymousId());
		boardService.boardInsert(board);
		return "redirect:/list";
	}
	
	
	@RequestMapping("/board/detail")
	public String boardDetail(HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("list", boardService.boardList());
		int no = Integer.parseInt(request.getParameter("bNo"));
		Board board = boardService.boardDetail(no);
		model.addAttribute("board", board);
		return "board/detail";
	}
	
	@RequestMapping("/board/delete")
	public String boardDelete(HttpServletRequest request) throws Exception{
		int no = Integer.parseInt(request.getParameter("bNo"));
		boardService.boardDelete(no);
		return "redirect:/list";
	}
	
	@RequestMapping("/updateForm")
	public String boardUpdate(HttpServletRequest request, Model model) throws Exception {
		int no = Integer.parseInt(request.getParameter("bNo"));
		model.addAttribute("board",boardService.boardDetail(no));
		return "board/update";
	}
	
	@RequestMapping("/board/update")
	public String boardUpdate(Board board) throws Exception {
		boardService.boardUpdate(board);
		return "board/list";
	}
	
}
