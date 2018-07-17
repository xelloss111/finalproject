package kr.co.anolja.repository.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.anolja.repository.domain.Video;

public interface VideoMapper {
	
	//내 저장소에 동영상 저장
	public void insertVideo(Video video);
	
	//첫 화면에서 동영상 리스트 불러오기
	public List<Video> selectUserTankId(String id);
	
	//특정 저장소 선택 시 해당 저장소 데이터 불러오기
	public List<Video> selectMyTank(@Param("id")String id, @Param("tankId")String tankId);
	
}
