package project2.scmaster.rodo.vo;

public class Marks {

	public String lat;
	public String lng;
	public String content;
	
	public Marks() {
		// TODO Auto-generated constructor stub
	}

	public Marks(String lat, String lng, String content) {
		super();
		this.lat = lat;
		this.lng = lng;
		this.content = content;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "Marks [lat=" + lat + ", lng=" + lng + ", content=" + content + "]";
	}

	
}
