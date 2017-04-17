package project2.scmaster.rodo.vo;

public class Rodo_PhotoReply 
{
	private int photoreply_replynum;
	private int photo_boardnum;
	private String photoreply_id;
	private String photoreply_text;
	private String photoreply_input_dt;
	private String photoreply_update_dt;
	
	public Rodo_PhotoReply(int photoreply_replynum, int photo_boardnum, String photoreply_id, String photoreply_text,
			String photoreply_input_dt, String photoreply_update_dt) {
		super();
		this.photoreply_replynum = photoreply_replynum;
		this.photo_boardnum = photo_boardnum;
		this.photoreply_id = photoreply_id;
		this.photoreply_text = photoreply_text;
		this.photoreply_input_dt = photoreply_input_dt;
		this.photoreply_update_dt = photoreply_update_dt;
	}
	
	public Rodo_PhotoReply() {
		// TODO Auto-generated constructor stub
	}

	public int getPhotoreply_replynum() {
		return photoreply_replynum;
	}

	public void setPhotoreply_replynum(int photoreply_replynum) {
		this.photoreply_replynum = photoreply_replynum;
	}

	public int getPhoto_boardnum() {
		return photo_boardnum;
	}

	public void setPhoto_boardnum(int photo_boardnum) {
		this.photo_boardnum = photo_boardnum;
	}

	public String getPhotoreply_id() {
		return photoreply_id;
	}

	public void setPhotoreply_id(String photoreply_id) {
		this.photoreply_id = photoreply_id;
	}

	public String getPhotoreply_text() {
		return photoreply_text;
	}

	public void setPhotoreply_text(String photoreply_text) {
		this.photoreply_text = photoreply_text;
	}

	public String getPhotoreply_input_dt() {
		return photoreply_input_dt;
	}

	public void setPhotoreply_input_dt(String photoreply_input_dt) {
		this.photoreply_input_dt = photoreply_input_dt;
	}

	public String getPhotoreply_update_dt() {
		return photoreply_update_dt;
	}

	public void setPhotoreply_update_dt(String photoreply_update_dt) {
		this.photoreply_update_dt = photoreply_update_dt;
	}

	@Override
	public String toString() 
	{
		return "Rodo_PhotoReply [photoreply_replynum=" + photoreply_replynum + ", photo_boardnum=" + photo_boardnum
				+ ", photoreply_id=" + photoreply_id + ", photoreply_text=" + photoreply_text + ", photoreply_input_dt="
				+ photoreply_input_dt + ", photoreply_update_dt=" + photoreply_update_dt + "]";
	}
}