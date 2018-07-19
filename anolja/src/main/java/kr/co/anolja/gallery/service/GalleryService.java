package kr.co.anolja.gallery.service;

import java.util.List;

import kr.co.anolja.repository.domain.Gallery;

public interface GalleryService {
	List<Gallery> selectGallery();
	void insertGallery(String id, String answer, String fileInfo) throws Exception;
}
