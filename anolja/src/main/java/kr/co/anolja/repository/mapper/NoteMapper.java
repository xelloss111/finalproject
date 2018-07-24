package kr.co.anolja.repository.mapper;

import java.util.List;

import kr.co.anolja.repository.domain.Note;

public interface NoteMapper {
	void sendNote(Note note);
	List<Note> printGetList(Note note);
	List<Note> printSendList(String sendId);
	void deleteNote(int no);
	void noteCheck(int no);
}
