package project2.scmaster.rodo.vo;

import java.util.ArrayList;
import java.util.List;

public class Rodo_QaBoard 
{
	private int qa_boardnum;
	private String qa_id;
	private String qa_title;
	private String qa_content;
	private String qa_input_dt;
	private String qa_update_dt;
	private int qa_hit;
	private ArrayList<String> qafile_original;
	private ArrayList<String> qafile_saved;
	
	public Rodo_QaBoard()
	{
	}

	public Rodo_QaBoard(int qa_boardnum, String qa_id, String qa_title, String qa_content, String qa_input_dt,
			String qa_update_dt, int qa_hit, ArrayList<String> qafile_original, ArrayList<String> qafile_saved) {
		super();
		this.qa_boardnum = qa_boardnum;
		this.qa_id = qa_id;
		this.qa_title = qa_title;
		this.qa_content = qa_content;
		this.qa_input_dt = qa_input_dt;
		this.qa_update_dt = qa_update_dt;
		this.qa_hit = qa_hit;
		this.qafile_original = qafile_original;
		this.qafile_saved = qafile_saved;
	}

	public int getQa_boardnum() {
		return qa_boardnum;
	}

	public void setQa_boardnum(int qa_boardnum) {
		this.qa_boardnum = qa_boardnum;
	}

	public String getQa_id() {
		return qa_id;
	}

	public void setQa_id(String qa_id) {
		this.qa_id = qa_id;
	}

	public String getQa_title() {
		return qa_title;
	}

	public void setQa_title(String qa_title) {
		this.qa_title = qa_title;
	}

	public String getQa_content() {
		return qa_content;
	}

	public void setQa_content(String qa_content) {
		this.qa_content = qa_content;
	}

	public String getQa_input_dt() {
		return qa_input_dt;
	}

	public void setQa_input_dt(String qa_input_dt) {
		this.qa_input_dt = qa_input_dt;
	}

	public String getQa_update_dt() {
		return qa_update_dt;
	}

	public void setQa_update_dt(String qa_update_dt) {
		this.qa_update_dt = qa_update_dt;
	}

	public int getQa_hit() {
		return qa_hit;
	}

	public void setQa_hit(int qa_hit) {
		this.qa_hit = qa_hit;
	}

	public ArrayList<String> getQafile_original() {
		return qafile_original;
	}

	public void setQafile_original(ArrayList<String> qafile_original) {
		this.qafile_original = qafile_original;
	}

	public ArrayList<String> getQafile_saved() {
		return qafile_saved;
	}

	public void setQafile_saved(ArrayList<String> qafile_saved) {
		this.qafile_saved = qafile_saved;
	}

	@Override
	public String toString() {
		return "Rodo_QaBoard [qa_boardnum=" + qa_boardnum + ", qa_id=" + qa_id + ", qa_title=" + qa_title
				+ ", qa_content=" + qa_content + ", qa_input_dt=" + qa_input_dt + ", qa_update_dt=" + qa_update_dt
				+ ", qa_hit=" + qa_hit + ", qafile_original=" + qafile_original + ", qafile_saved=" + qafile_saved
				+ "]";
	}
}