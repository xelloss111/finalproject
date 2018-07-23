package kr.co.anolja.note.service;

import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import kr.co.anolja.repository.domain.Note;

public interface NoteService {
	public void sendNote(Note note);
	public List<Note> printGetIdList(Note note);
	public List<Note> printSendIdList(String sessionId);
	public void deleteNote(String[] list);
}


