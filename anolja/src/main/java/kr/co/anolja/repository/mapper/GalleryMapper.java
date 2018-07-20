package kr.co.anolja.repository.mapper;

import java.util.List;

import kr.co.anolja.repository.domain.Gallery;

public interface GalleryMapper {
	List<Gallery> selectGallery();
	Gallery viewGallery(int gno);
	void insertGallery(Gallery gallery);
}
