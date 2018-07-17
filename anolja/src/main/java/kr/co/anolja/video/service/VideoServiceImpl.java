package kr.co.anolja.video.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anolja.repository.domain.Video;
import kr.co.anolja.repository.mapper.VideoMapper;

@Service
public class VideoServiceImpl implements VideoService {
	
	@Autowired
	private VideoMapper mapper;
	
	@Override
	public void insert(Video video) {
		mapper.insertVideo(video);
	}

	@Override
	public List<Video> selectUserTankId(String id) {
		return mapper.selectUserTankId(id);
	}

	@Override
	public List<Video> selectMyTank(String id, String tankId) {
		return mapper.selectMyTank(id, tankId);
	}


}
