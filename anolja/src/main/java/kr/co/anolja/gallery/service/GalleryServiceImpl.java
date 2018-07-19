package kr.co.anolja.gallery.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anolja.common.FileHandler;
import kr.co.anolja.repository.domain.Gallery;
import kr.co.anolja.repository.mapper.GalleryMapper;

@Service
public class GalleryServiceImpl implements GalleryService {
	
	@Autowired
	GalleryMapper mapper;
	
	@Override
	public void insertGallery(String id, String answer, String fileInfo) throws Exception {
		Object[] result = new FileHandler().base64Decode(id, answer, fileInfo);
		
		Gallery g = new Gallery();
		g.setId(id);
		g.setAnswer(answer);
		g.setPath((String)result[0]);
		g.setFileName((String)result[1]);
		mapper.insertGallery(g);
	}

}
