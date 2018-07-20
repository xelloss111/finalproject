package kr.co.anolja.gallery.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anolja.common.FileHandler;
import kr.co.anolja.repository.domain.Gallery;
import kr.co.anolja.repository.mapper.GalleryMapper;

@Service
public class GalleryServiceImpl implements GalleryService {
	
	@Autowired
	GalleryMapper mapper;
	
	public List<Gallery> selectGallery() {
		return mapper.selectGallery();
	}
	
	@Override
	public void viewGallery(int gno, HttpServletResponse res) throws Exception {
		Gallery g = mapper.viewGallery(gno);
		new FileHandler().fileViewer(g.getPath(), g.getFileName(), res);
		
//		List<Gallery> g = mapper.selectGallery();
//		for (int i = 0; i < g.size(); i++) {
//			new FileHandler().fileViewer(g.get(i).getPath(), g.get(i).getFileName(), res);
//		}
	}

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
