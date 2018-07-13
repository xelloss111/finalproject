package kr.co.anolja.board.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.anolja.board.service.BoardService;
import kr.co.anolja.repository.domain.Board;
import kr.co.anolja.repository.domain.BoardFile;

@Controller
@RequestMapping(value="/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/list")
	public String selectList(Model model) throws Exception{
		model.addAttribute("list", boardService.boardList());
		return "board/list";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String boardWrite() throws Exception{
		return "board/write";
	}
	
	@RequestMapping("/insert")
	public String boardInsert(Board board, BoardFile files) throws Exception {
		System.out.println(files);
		boardService.boardInsert(board, files);
		return "redirect:/board/detail?bNo="+board.getbNo();
	}
	
	
	@RequestMapping("/detail")
	public String boardDetail(HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("list", boardService.boardList());
		int no = Integer.parseInt(request.getParameter("bNo"));
		model.addAttribute("no", no);
		Board board = boardService.boardDetail(no);
		model.addAttribute("board", board);
		return "board/detail";
	}
	
	@RequestMapping("/delete")
	public String boardDelete(HttpServletRequest request) throws Exception{
		int no = Integer.parseInt(request.getParameter("bNo"));
		boardService.boardDelete(no);
		return "redirect:/board/list";
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
