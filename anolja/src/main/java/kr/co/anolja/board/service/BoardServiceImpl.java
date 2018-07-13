package kr.co.anolja.board.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.anolja.repository.domain.Board;
import kr.co.anolja.repository.domain.BoardFile;
import kr.co.anolja.repository.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;

	@Override
	public void boardDelete(int no) throws Exception {
		boardMapper.boardDelete(no);
	}

	@Override
	public void boardWrite(Board board) throws Exception {
		boardMapper.boardWrite(board);
	}

	@Override
	public Board boardDetail(int no) throws Exception {
		return boardMapper.boardDetail(no);
	}

	@Override
	public void boardUpdate(Board board) throws Exception {
		boardMapper.boardUpdate(board);
	}

	@Override
	public List<Board> boardList() throws Exception {
		return boardMapper.boardList();
	}

	@Override
	public void boardInsert(Board board, BoardFile boardFile) throws Exception {
		boardMapper.boardInsert(board);
		int a = board.getbNo();
		// 그룹bNO값을 board에 있는 bNo값으로 업데이트
		
		
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
