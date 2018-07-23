package kr.co.anolja.board.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.anolja.repository.domain.Board;
import kr.co.anolja.repository.domain.BoardFile;
import kr.co.anolja.repository.domain.Comment;
import kr.co.anolja.repository.domain.PageResult;
import kr.co.anolja.repository.mapper.BoardMapper;
import kr.co.anolja.repository.mapper.CommentMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private CommentMapper commentMapper;

	@Override
	public void boardDelete(int no) throws Exception {
		boardMapper.boardDelete(no);
	}

	@Override
	public void boardWrite(Board board) throws Exception {
		boardMapper.boardWrite(board);
	}

	@Override
	public Board boardDetail(int bNO) throws Exception {
		System.out.println("찍히니 : " + bNO);
		boardMapper.updateViewCnt(bNO);
		return boardMapper.boardDetail(bNO);
	}

	@Override
	public void boardUpdate(Board board) throws Exception {
		boardMapper.boardUpdate(board);
	}

	@Override
	public void boardInsert(Board board, BoardFile boardFile) throws Exception {
		
		boardMapper.boardInsert(board);
		// 그룹bNO값을 board에 있는 bNo값으로 업데이트
		boardMapper.boardUpdateNo(board.getbNo());
		
		if(boardFile.getFiles()[0].getSize() != 0) {
			for (MultipartFile file : boardFile.getFiles()) {
				String oriName = file.getOriginalFilename();
				
				//파일이 있을때만 실행
				boardFile.setbNo(board.getbNo());
				long fileSize = file.getSize();
				System.out.println(file.getOriginalFilename());
				String ext = "";
				int index = file.getOriginalFilename().lastIndexOf(".");
				ext = file.getOriginalFilename().substring(index);
				
				String saveFileName = "board -" + UUID.randomUUID().toString() + ext;
				
				file.transferTo(new File("c:/pilseong/upload/" + saveFileName));
				
				boardFile.setPath("c:/pilseong/upload/");
				boardFile.setFileSize((int) fileSize);
				boardFile.setOriName(oriName);
				boardFile.setSysName(saveFileName);
				boardMapper.boardInsertFile(boardFile);
			}
		}
	
	}
	
	@Override
	public List<Comment> selectCommentByNo(int no){
		return commentMapper.selectCommentByNo(no);
	}

	@Override
	public void insertComment(Comment comment) {
		commentMapper.insertComment(comment);
	}

	@Override
	public void deleteComment(Comment comment) {
		commentMapper.deleteComment(comment);
	}

	@Override
	public void updateComment(Comment comment) {
		commentMapper.updateComment(comment);
	}


	@Override
	public Map<String, Object> boardList(int pageNo) throws Exception{
//		board.setPageNo(board.getPageNo());
//		board.setPageNo(pageNo != null ? Integer.parseInt(sPageNo) : 1);
		
		Map<String, Object> map = new HashMap<>();
		List<Board> list = boardMapper.boardList((pageNo - 1) * 10);
		int count = boardMapper.selectBoardCount();
		map.put("list", list);
		map.put("pageResult", new PageResult(pageNo, count));
		return map;
	}

	@Override
	public void boardReply(Board board, BoardFile boardFile) throws Exception {
		boardMapper.updateReplyBoard(board);
		
		boardMapper.boardReply(board);
		
		if(boardFile.getFiles()[0].getSize() != 0) {
			for (MultipartFile file : boardFile.getFiles()) {
				String oriName = file.getOriginalFilename();
				
				//파일이 있을때만 실행
				boardFile.setbNo(board.getbNo());
				long fileSize = file.getSize();
				System.out.println(file.getOriginalFilename());
				String ext = "";
				int index = file.getOriginalFilename().lastIndexOf(".");
				ext = file.getOriginalFilename().substring(index);
				
				String saveFileName = "board -" + UUID.randomUUID().toString() + ext;
				
				file.transferTo(new File("c:/pilseong/upload/" + saveFileName));
				
				boardFile.setPath("c:/pilseong/upload/");
				boardFile.setFileSize((int) fileSize);
				boardFile.setOriName(oriName);
				boardFile.setSysName(saveFileName);
				boardMapper.boardInsertFile(boardFile);
			}
		}
	}

	@Override
	public List<Board> searchBoard(String board) {
		return boardMapper.searchBoard(board);
	}
	

	
	
	
	

}
