package kr.co.anolja.note.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.anolja.note.service.NoteService;
import kr.co.anolja.repository.domain.Note;

@Controller
public class NoteController {
	@Autowired
	NoteService noteService;
	
	@RequestMapping("/sendnote")
	@ResponseBody
	public void sendNoteData(Note note,HttpSession session) {
		String sendId = (String) session.getAttribute("id");
		
		note.setSendId(sendId);
		
		System.out.println("세션값:"+sendId);
		
		noteService.sendNote(note);
	}
	
	@RequestMapping("/getnotelist")
	@ResponseBody
	public List<Note> getPrintList(@RequestParam(value="notePageNo",defaultValue="0") int notePageNo,HttpSession session) {
		String getId = (String)session.getAttribute("id");
		
		System.out.println("찍힌값:"+notePageNo);
		
		Note note = new Note();
		
		note.setGetId(getId);
		note.setPageNo(notePageNo);
		
		List<Note> list = noteService.printGetIdList(note);
		
		for(Note t:list) {
			System.out.println("제목:"+t.getTitle());
		}
		
		return list;
	}
	
	@RequestMapping("/sendnotelist")
	@ResponseBody
	public List<Note> sendPrintList(HttpSession session) {
		String sendId = (String)session.getAttribute("id");
		
		List<Note> list = noteService.printSendIdList(sendId);
		
		for(Note note:list) {
			System.out.println("아이디:"+note.getSendId());
		}
		
		return list;
	}
	
	@RequestMapping("/deletenote")
	@ResponseBody
	public String deleteList(@RequestBody String[] checkedList) {
		noteService.deleteNote(checkedList);
		
		return "받은 편지 삭제";
	}
	

}
