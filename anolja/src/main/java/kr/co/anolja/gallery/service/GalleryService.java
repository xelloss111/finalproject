package kr.co.anolja.gallery.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import kr.co.anolja.repository.domain.Gallery;

public interface GalleryService {
	List<Gallery> selectGallery();
	void viewGallery(HttpServletResponse res) throws Exception;
	void insertGallery(String id, String answer, String fileInfo) throws Exception;
}
