package project2.scmaster.rodo.vo;

public class GPX {
	private String lat;
	private String lng;
	private String ele;
	private String time;
	
	public GPX() {
		// TODO Auto-generated constructor stub
	}

	public GPX(String lat, String lng, String ele, String time) {
		super();
		this.lat = lat;
		this.lng = lng;
		this.ele = ele;
		this.time = time;
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

	public String getEle() {
		return ele;
	}

	public void setEle(String ele) {
		this.ele = ele;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	@Override
	public String toString() {
		return "GPX [lat=" + lat + ", lng=" + lng + ", ele=" + ele + ", time=" + time + "]";
	}	
}
