package project2.scmaster.rodo.vo;

public class Rodo_FreeBoard 
{
	private int free_boardnum;
	private String free_id;
	private String free_title;
	private String free_content;
	private String free_input_dt;
	private String free_update_dt;
	private int free_hit;
	private String freefile_original;
	private String freefile_saved;
	
	public Rodo_FreeBoard(int free_boardnum, String free_id, String free_title, String free_content,
			String free_input_dt, String free_update_dt, int free_hit, String freefile_original,
			String freefile_saved) {
		super();
		this.free_boardnum = free_boardnum;
		this.free_id = free_id;
		this.free_title = free_title;
		this.free_content = free_content;
		this.free_input_dt = free_input_dt;
		this.free_update_dt = free_update_dt;
		this.free_hit = free_hit;
		this.freefile_original = freefile_original;
		this.freefile_saved = freefile_saved;
	}

	public Rodo_FreeBoard() {
		super();
	}

	public int getFree_boardnum() {
		return free_boardnum;
	}

	public void setFree_boardnum(int free_boardnum) {
		this.free_boardnum = free_boardnum;
	}

	public String getFree_id() {
		return free_id;
	}

	public void setFree_id(String free_id) {
		this.free_id = free_id;
	}

	public String getFree_title() {
		return free_title;
	}

	public void setFree_title(String free_title) {
		this.free_title = free_title;
	}

	public String getFree_content() {
		return free_content;
	}

	public void setFree_content(String free_content) {
		this.free_content = free_content;
	}

	public String getFree_input_dt() {
		return free_input_dt;
	}

	public void setFree_input_dt(String free_input_dt) {
		this.free_input_dt = free_input_dt;
	}

	public String getFree_update_dt() {
		return free_update_dt;
	}

	public void setFree_update_dt(String free_update_dt) {
		this.free_update_dt = free_update_dt;
	}

	public int getFree_hit() {
		return free_hit;
	}

	public void setFree_hit(int free_hit) {
		this.free_hit = free_hit;
	}

	public String getFreefile_original() {
		return freefile_original;
	}

	public void setFreefile_original(String freefile_original) {
		this.freefile_original = freefile_original;
	}

	public String getFreefile_saved() {
		return freefile_saved;
	}

	public void setFreefile_saved(String freefile_saved) {
		this.freefile_saved = freefile_saved;
	}

	@Override
	public String toString() {
		return "Rodo_FreeBoard [free_boardnum=" + free_boardnum + ", free_id=" + free_id + ", free_title=" + free_title
				+ ", free_content=" + free_content + ", free_input_dt=" + free_input_dt + ", free_update_dt="
				+ free_update_dt + ", free_hit=" + free_hit + ", freefile_original=" + freefile_original
				+ ", freefile_saved=" + freefile_saved + "]";
	}
}