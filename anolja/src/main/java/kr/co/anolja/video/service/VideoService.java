package kr.co.anolja.video.service;

import java.util.List;

import kr.co.anolja.repository.domain.Video;

public interface VideoService {
	
	public void insert(Video video);
	public List<Video> selectUserTankId(String id);
	public List<Video> selectMyTank(String id, String tankId);

}
