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
		if(request.getMethod() == "GET") {
			return "board/write";
		} else {
			boardService.boardWrite(board);
			return "board/list";
		}
	}
	
	@RequestMapping("/board/update")
	public String boardUpdate(Board board, Model model) throws Exception{
		boardService.boardUpdate(board);
		return null;
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
	public void boardDelete(int no) throws Exception{
		boardService.boardDelete(no);
	}
	
	
	
	
	
}
