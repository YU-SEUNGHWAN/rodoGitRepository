package project2.scmaster.rodo.vo;

public class Rodo_GpsReply 
{
	private int gpsreply_replynum;
	private int gps_boardnum;
	private String gpsreply_id;
	private String gpsreply_text;
	private String gpsreply_input_dt;
	private String gpsreply_update_dt;
	
	public Rodo_GpsReply(int gpsreply_replynum, int gps_boardnum, String gpsreply_id, String gpsreply_text,
			String gpsreply_input_dt, String gpsreply_update_dt) {
		super();
		this.gpsreply_replynum = gpsreply_replynum;
		this.gps_boardnum = gps_boardnum;
		this.gpsreply_id = gpsreply_id;
		this.gpsreply_text = gpsreply_text;
		this.gpsreply_input_dt = gpsreply_input_dt;
		this.gpsreply_update_dt = gpsreply_update_dt;
	}
	
	public Rodo_GpsReply() {
		// TODO Auto-generated constructor stub
	}

	public int getGpsreply_replynum() {
		return gpsreply_replynum;
	}

	public void setGpsreply_replynum(int gpsreply_replynum) {
		this.gpsreply_replynum = gpsreply_replynum;
	}

	public int getGps_boardnum() {
		return gps_boardnum;
	}

	public void setGps_boardnum(int gps_boardnum) {
		this.gps_boardnum = gps_boardnum;
	}

	public String getGpsreply_id() {
		return gpsreply_id;
	}

	public void setGpsreply_id(String gpsreply_id) {
		this.gpsreply_id = gpsreply_id;
	}

	public String getGpsreply_text() {
		return gpsreply_text;
	}

	public void setGpsreply_text(String gpsreply_text) {
		this.gpsreply_text = gpsreply_text;
	}

	public String getGpsreply_input_dt() {
		return gpsreply_input_dt;
	}

	public void setGpsreply_input_dt(String gpsreply_input_dt) {
		this.gpsreply_input_dt = gpsreply_input_dt;
	}

	public String getGpsreply_update_dt() {
		return gpsreply_update_dt;
	}

	public void setGpsreply_update_dt(String gpsreply_update_dt) {
		this.gpsreply_update_dt = gpsreply_update_dt;
	}

	@Override
	public String toString() {
		return "Rodo_GpsReply [gpsreply_replynum=" + gpsreply_replynum + ", gps_boardnum=" + gps_boardnum
				+ ", gpsreply_id=" + gpsreply_id + ", gpsreply_text=" + gpsreply_text + ", gpsreply_input_dt="
				+ gpsreply_input_dt + ", gpsreply_update_dt=" + gpsreply_update_dt + "]";
	}
}
