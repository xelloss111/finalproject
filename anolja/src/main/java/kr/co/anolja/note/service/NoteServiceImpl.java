package kr.co.anolja.note.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anolja.repository.domain.Note;
import kr.co.anolja.repository.mapper.NoteMapper;

@Service
public class NoteServiceImpl implements NoteService{
	@Autowired
	NoteMapper noteMapper;
	
	public void sendNote(Note note) {
		noteMapper.sendNote(note);
	}
	
	public List<Note> printSendIdList(String sessionId) {
		List<Note> sendIdList =  noteMapper.printSendList(sessionId);
		
		return sendIdList;
	}
	
	public List<Note> printGetIdList(Note note){
		List<Note> getIdList = noteMapper.printGetList(note);
		
		return getIdList;
	}
	
	public void deleteNote(String[] list) {
		for(int i=0;i<list.length;i++) {
			int deleteNum = Integer.parseInt(list[i]);
			
			noteMapper.deleteNote(deleteNum);
		}
	}
	
	
}
