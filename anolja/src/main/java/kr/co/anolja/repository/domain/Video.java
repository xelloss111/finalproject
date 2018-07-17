package kr.co.anolja.repository.domain;

public class Video {
	private String id;
	private String tankId;
	private String tankName;
	private String videoImg;
	private String videoTitle;
	private String videoUrl;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTankId() {
		return tankId;
	}
	public void setTankId(String tankId) {
		this.tankId = tankId;
	}
	public String getTankName() {
		return tankName;
	}
	public void setTankName(String tankName) {
		this.tankName = tankName;
	}
	public String getVideoImg() {
		return videoImg;
	}
	public void setVideoImg(String videoImg) {
		this.videoImg = videoImg;
	}
	public String getVideoTitle() {
		return videoTitle;
	}
	public void setVideoTitle(String videoTitle) {
		this.videoTitle = videoTitle;
	}
	public String getVideoUrl() {
		return videoUrl;
	}
	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}
	@Override
	public String toString() {
		return "Video [id=" + id + ", tankId=" + tankId + ", tankName=" + tankName + ", videoImg=" + videoImg
				+ ", videoTitle=" + videoTitle + ", videoUrl=" + videoUrl + "]";
	}
	
	
	
}
