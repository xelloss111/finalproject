package kr.co.anolja.gallery.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import kr.co.anolja.repository.domain.Gallery;

public interface GalleryService {
	List<Gallery> selectGallery();
	List<Gallery> selectGalleryScroll(int gno);
	void viewGallery(int gno, HttpServletResponse res) throws Exception;
	void insertGallery(String id, String answer, String fileInfo) throws Exception;
}
