package project2.scmaster.rodo.vo;

public class Rodo_FreeReply 
{
	private int freereply_replynum;
	private int free_boardnum;
	private String freereply_id;
	private String freereply_text;
	private String freereply_input_dt;
	private String freereply_update_dt;
	
	public Rodo_FreeReply(int freereply_replynum, int free_boardnum, String freereply_id, String freereply_text,
			String freereply_input_dt, String freereply_update_dt) {
		super();
		this.freereply_replynum = freereply_replynum;
		this.free_boardnum = free_boardnum;
		this.freereply_id = freereply_id;
		this.freereply_text = freereply_text;
		this.freereply_input_dt = freereply_input_dt;
		this.freereply_update_dt = freereply_update_dt;
	}
	
	public Rodo_FreeReply() {
		// TODO Auto-generated constructor stub
	}

	public int getFreereply_replynum() {
		return freereply_replynum;
	}

	public void setFreereply_replynum(int freereply_replynum) {
		this.freereply_replynum = freereply_replynum;
	}

	public int getFree_boardnum() {
		return free_boardnum;
	}

	public void setFree_boardnum(int free_boardnum) {
		this.free_boardnum = free_boardnum;
	}

	public String getFreereply_id() {
		return freereply_id;
	}

	public void setFreereply_id(String freereply_id) {
		this.freereply_id = freereply_id;
	}

	public String getFreereply_text() {
		return freereply_text;
	}

	public void setFreereply_text(String freereply_text) {
		this.freereply_text = freereply_text;
	}

	public String getFreereply_input_dt() {
		return freereply_input_dt;
	}

	public void setFreereply_input_dt(String freereply_input_dt) {
		this.freereply_input_dt = freereply_input_dt;
	}

	public String getFreereply_update_dt() {
		return freereply_update_dt;
	}

	public void setFreereply_update_dt(String freereply_update_dt) {
		this.freereply_update_dt = freereply_update_dt;
	}

	@Override
	public String toString() {
		return "Rodo_FreeReply [freereply_replynum=" + freereply_replynum + ", free_boardnum=" + free_boardnum
				+ ", freereply_id=" + freereply_id + ", freereply_text=" + freereply_text + ", freereply_input_dt="
				+ freereply_input_dt + ", freereply_update_dt=" + freereply_update_dt + "]";
	}
}