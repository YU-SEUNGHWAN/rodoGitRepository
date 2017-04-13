package project2.scmaster.rodo.vo;

public class videoBoard {

	public String video_boardnum;
	public String video_id;
	public String video_title;
	public String video_content;
	public String video_inputdate;
	public String video_originalfile;
	public String video_savedfile;
	public String video_thumbnail;
	public String video_hits;

	public videoBoard() {
		// TODO Auto-generated constructor stub
	}

	public videoBoard(String video_boardnum, String video_id, String video_title, String video_content,
			String video_inputdate, String video_originalfile, String video_savedfile, String video_thumbnail, String video_hits) {
		super();
		this.video_boardnum = video_boardnum;
		this.video_id = video_id;
		this.video_title = video_title;
		this.video_content = video_content;
		this.video_inputdate = video_inputdate;
		this.video_originalfile = video_originalfile;
		this.video_savedfile = video_savedfile;
		this.video_thumbnail = video_thumbnail;
		this.video_hits = video_hits;
	}

	public String getVideo_boardnum() {
		return video_boardnum;
	}

	public void setVideo_boardnum(String video_boardnum) {
		this.video_boardnum = video_boardnum;
	}

	public String getVideo_id() {
		return video_id;
	}

	public void setVideo_id(String video_id) {
		this.video_id = video_id;
	}

	public String getVideo_title() {
		return video_title;
	}

	public void setVideo_title(String video_title) {
		this.video_title = video_title;
	}

	public String getVideo_content() {
		return video_content;
	}

	public void setVideo_content(String video_content) {
		this.video_content = video_content;
	}

	public String getVideo_inputdate() {
		return video_inputdate;
	}

	public void setVideo_inputdate(String video_inputdate) {
		this.video_inputdate = video_inputdate;
	}

	public String getVideo_originalfile() {
		return video_originalfile;
	}

	public void setVideo_originalfile(String video_originalfile) {
		this.video_originalfile = video_originalfile;
	}
	
	public String getVideo_savedfile() {
		return video_savedfile;
	}
	
	public void setVideo_savedfile(String video_savedfile) {
		this.video_savedfile = video_savedfile;
	}

	public String getVideo_thumbnail() {
		return video_thumbnail;
	}

	public void setVideo_thumbnail(String video_thumbnail) {
		this.video_thumbnail = video_thumbnail;
	}

	public String getVideo_hits() {
		return video_hits;
	}

	public void setVideo_hits(String video_hits) {
		this.video_hits = video_hits;
	}

	@Override
	public String toString() {
		return "videoBoard [video_boardnum=" + video_boardnum + ", video_id=" + video_id + ", video_title="
				+ video_title + ", video_content=" + video_content + ", video_inputdate=" + video_inputdate
				+ ", video_originalfile=" + video_originalfile + ", video_savedfile=" + video_savedfile
				+ ", video_thumbnail=" + video_thumbnail + ", video_hits=" + video_hits + "]";
	}
	
}
