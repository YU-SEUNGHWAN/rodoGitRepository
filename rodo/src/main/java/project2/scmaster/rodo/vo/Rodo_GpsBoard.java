package project2.scmaster.rodo.vo;

public class Rodo_GpsBoard 
{
	private int gps_boardnum;
	private String gps_id;
	private String gps_title;
	private String gps_content;
	private String gps_gpxinfo;
	private String gps_location;
	private String gps_input_dt;
	private String gps_update_dt;
	private String gps_marker;
	private String gpsfile_original;
	private String gpsfile_saved;
	private int gps_hit;
	
	public Rodo_GpsBoard(int gps_boardnum, String gps_id, String gps_title, String gps_content, String gps_gpxinfo,
			String gps_location, String gps_input_dt, String gps_update_dt, String gps_marker, String gpsfile_original,
			String gpsfile_saved, int gps_hit) {
		super();
		this.gps_boardnum = gps_boardnum;
		this.gps_id = gps_id;
		this.gps_title = gps_title;
		this.gps_content = gps_content;
		this.gps_gpxinfo = gps_gpxinfo;
		this.gps_location = gps_location;
		this.gps_input_dt = gps_input_dt;
		this.gps_update_dt = gps_update_dt;
		this.gps_marker = gps_marker;
		this.gpsfile_original = gpsfile_original;
		this.gpsfile_saved = gpsfile_saved;
		this.gps_hit = gps_hit;
	}
	
	public Rodo_GpsBoard() {
		// TODO Auto-generated constructor stub
	}

	public int getGps_boardnum() {
		return gps_boardnum;
	}

	public void setGps_boardnum(int gps_boardnum) {
		this.gps_boardnum = gps_boardnum;
	}

	public String getGps_id() {
		return gps_id;
	}

	public void setGps_id(String gps_id) {
		this.gps_id = gps_id;
	}

	public String getGps_title() {
		return gps_title;
	}

	public void setGps_title(String gps_title) {
		this.gps_title = gps_title;
	}

	public String getGps_content() {
		return gps_content;
	}

	public void setGps_content(String gps_content) {
		this.gps_content = gps_content;
	}

	public String getGps_gpxinfo() {
		return gps_gpxinfo;
	}

	public void setGps_gpxinfo(String gps_gpxinfo) {
		this.gps_gpxinfo = gps_gpxinfo;
	}

	public String getGps_location() {
		return gps_location;
	}

	public void setGps_location(String gps_location) {
		this.gps_location = gps_location;
	}

	public String getGps_input_dt() {
		return gps_input_dt;
	}

	public void setGps_input_dt(String gps_input_dt) {
		this.gps_input_dt = gps_input_dt;
	}

	public String getGps_update_dt() {
		return gps_update_dt;
	}

	public void setGps_update_dt(String gps_update_dt) {
		this.gps_update_dt = gps_update_dt;
	}

	public String getGps_marker() {
		return gps_marker;
	}

	public void setGps_marker(String gps_marker) {
		this.gps_marker = gps_marker;
	}

	public String getGpsfile_original() {
		return gpsfile_original;
	}

	public void setGpsfile_original(String gpsfile_original) {
		this.gpsfile_original = gpsfile_original;
	}

	public String getGpsfile_saved() {
		return gpsfile_saved;
	}

	public void setGpsfile_saved(String gpsfile_saved) {
		this.gpsfile_saved = gpsfile_saved;
	}

	public int getGps_hit() {
		return gps_hit;
	}

	public void setGps_hit(int gps_hit) {
		this.gps_hit = gps_hit;
	}

	@Override
	public String toString()
	{
		return "Rodo_GpsBoard [gps_boardnum=" + gps_boardnum + ", gps_id=" + gps_id + ", gps_title=" + gps_title
				+ ", gps_content=" + gps_content + ", gps_gpxinfo=" + gps_gpxinfo + ", gps_location=" + gps_location
				+ ", gps_input_dt=" + gps_input_dt + ", gps_update_dt=" + gps_update_dt + ", gps_marker=" + gps_marker
				+ ", gpsfile_original=" + gpsfile_original + ", gpsfile_saved=" + gpsfile_saved + ", gps_hit=" + gps_hit
				+ "]";
	}
}