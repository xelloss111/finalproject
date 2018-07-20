package kr.co.anolja.video.service;

import java.util.List;

import kr.co.anolja.repository.domain.Video;

public interface VideoService {
	
	public List<Video> insert(Video video);
	public List<Video> selectUserTankId(String id);
	public List<Video> selectMyTank(String id, String tankId);
	public List<Video> updateTankName(Video video);
	public void delTank(Video video);

}
