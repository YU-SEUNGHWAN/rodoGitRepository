package project2.scmaster.rodo.vo;

import java.util.Date;

public class GPX {
	private String lat;
	private String lng;
	private String ele;
	private Date time;
	
	public GPX() {
		// TODO Auto-generated constructor stub
	}

	public GPX(String lat, String lng, String ele, Date time) {
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

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	@Override
	public String toString() {
		return "GPX [lat=" + lat + ", lng=" + lng + ", ele=" + ele + ", time=" + time + "]";
	}	
}
