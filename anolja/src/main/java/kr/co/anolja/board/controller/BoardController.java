package kr.co.anolja.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.anolja.board.service.BoardService;
import kr.co.anolja.repository.domain.Board;
import kr.co.anolja.repository.domain.BoardFile;
import kr.co.anolja.repository.domain.Comment;

@Controller
@RequestMapping(value="/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/list")
	public String selectList(Model model, @RequestParam(value="pageNo", defaultValue="1") int pageNo) throws Exception{
		model.addAttribute("result", boardService.boardList(pageNo));
		return "board/list";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String boardWrite() throws Exception{
		return "board/write";
	}
	
	@RequestMapping("/insert")
	public String boardInsert(Board board, BoardFile files) throws Exception {
		boardService.boardInsert(board, files);
		return "redirect:/board/detail?bNo="+board.getbNo();
	}
	
	
	@RequestMapping("/detail")
	public String boardDetail(Model model, int bNo,@RequestParam(value="pageNo", defaultValue="1")int pageNo) throws Exception{
		model.addAttribute("result", boardService.boardList(pageNo));
		boardService.updateViewCnt(bNo);
		Board bad = boardService.boardDetail(bNo);
		model.addAttribute("board", bad);
		return "board/detail";
	}
	
	@RequestMapping("/delete")
	public String boardDelete(HttpServletRequest request, int bNo) throws Exception{
		boardService.boardDelete(bNo);
		return "redirect:/board/list";
	}
	
	@RequestMapping("/updateForm")
	public String boardUpdate(HttpServletRequest request, Model model) throws Exception {
		int no = Integer.parseInt(request.getParameter("bNo"));
		System.out.println(no);
		Board board = boardService.boardDetail(no);
		model.addAttribute("board", board);
		return "board/update";
	}
	
	@RequestMapping("/update")
	public String boardUpdate(Board board) throws Exception {
		boardService.boardUpdate(board);
		return "board/list";
	}
	
	
	//답글 시작입니다.
	
	@RequestMapping("/boardReply")
	public String reply(Board board, BoardFile boardFile) throws Exception{
		System.out.println("찍히냐 : " + board.getbNo());
		boardService.boardReply(board, boardFile);
		return "redirect:/board/list";
	}
	
	@RequestMapping("/replyForm")
	public String replyForm(Model model, int bNo) throws Exception{
		model.addAttribute("board",boardService.boardDetail(bNo));
		return "board/replyForm";
	}
	
	
	// 댓글 시작입니다.
	@RequestMapping("/commentList")
	@ResponseBody
	public List<Comment> commentList(@RequestParam (value="bNo")int no){
		return boardService.selectCommentByNo(no);  
	}
	
	@RequestMapping("/commentRegist")
	@ResponseBody
	public List<Comment> commentRegist(Comment comment) {
		boardService.insertComment(comment);
		System.out.println("찍힘 : " + boardService.selectCommentByNo(comment.getbNo()));
		
		return boardService.selectCommentByNo(comment.getbNo());
	}
	
	@RequestMapping("/commentDelete")
	@ResponseBody
	public List<Comment> commentDelete(Comment comment) {
		boardService.deleteComment(comment);
		return boardService.selectCommentByNo(comment.getbNo());
	}
	
	@RequestMapping("/commentUpdate")
	@ResponseBody
	public List<Comment> commentUpdate(Comment comment) {
		boardService.updateComment(comment);
		return boardService.selectCommentByNo(comment.getbNo());
	}
	
	
	
	
}











































