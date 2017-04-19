package project2.scmaster.rodo.vo;

public class Rodo_VideoReply 
{
	private int videoreply_replynum;
	private int video_boardnum;
	private String videoreply_id;
	private String videoreply_text;
	private String videoreply_input_dt;
	private String videoreply_update_dt;
	
	public Rodo_VideoReply(int videoreply_replynum, int video_boardnum, String videoreply_id, String videoreply_text,
			String videoreply_input_dt, String videoreply_update_dt) {
		super();
		this.videoreply_replynum = videoreply_replynum;
		this.video_boardnum = video_boardnum;
		this.videoreply_id = videoreply_id;
		this.videoreply_text = videoreply_text;
		this.videoreply_input_dt = videoreply_input_dt;
		this.videoreply_update_dt = videoreply_update_dt;
	}
	
	public Rodo_VideoReply() {
		// TODO Auto-generated constructor stub
	}

	public int getVideoreply_replynum() {
		return videoreply_replynum;
	}

	public void setVideoreply_replynum(int videoreply_replynum) {
		this.videoreply_replynum = videoreply_replynum;
	}

	public int getVideo_boardnum() {
		return video_boardnum;
	}

	public void setVideo_boardnum(int video_boardnum) {
		this.video_boardnum = video_boardnum;
	}

	public String getVideoreply_id() {
		return videoreply_id;
	}

	public void setVideoreply_id(String videoreply_id) {
		this.videoreply_id = videoreply_id;
	}

	public String getVideoreply_text() {
		return videoreply_text;
	}

	public void setVideoreply_text(String videoreply_text) {
		this.videoreply_text = videoreply_text;
	}

	public String getVideoreply_input_dt() {
		return videoreply_input_dt;
	}

	public void setVideoreply_input_dt(String videoreply_input_dt) {
		this.videoreply_input_dt = videoreply_input_dt;
	}

	public String getVideoreply_update_dt() {
		return videoreply_update_dt;
	}

	public void setVideoreply_update_dt(String videoreply_update_dt) {
		this.videoreply_update_dt = videoreply_update_dt;
	}

	@Override
	public String toString() {
		return "Rodo_VideoReply [videoreply_replynum=" + videoreply_replynum + ", video_boardnum=" + video_boardnum
				+ ", videoreply_id=" + videoreply_id + ", videoreply_text=" + videoreply_text + ", videoreply_input_dt="
				+ videoreply_input_dt + ", videoreply_update_dt=" + videoreply_update_dt + "]";
	}
}