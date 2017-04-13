package project2.scmaster.rodo.vo;

import java.util.ArrayList;

public class Rodo_PhotoBoard {

	private int photo_boardnum;
	private String photo_id;
	private String photo_title;
	private String photo_content;
	private int photo_share;
	private String photo_input_dt;
	private String photo_update_dt;
	private int photo_hit;
	private ArrayList<String> photofile_original;
	private ArrayList<String> photofile_saved;
	private String photofile_tn;
	
	public Rodo_PhotoBoard() {
	}

	public Rodo_PhotoBoard(int photo_boardnum, String photo_id, String photo_title, String photo_content,
			int photo_share, String photo_input_dt, String photo_update_dt, int photo_hit,
			ArrayList<String> photofile_original, ArrayList<String> photofile_saved, String photofile_tn) {
		super();
		this.photo_boardnum = photo_boardnum;
		this.photo_id = photo_id;
		this.photo_title = photo_title;
		this.photo_content = photo_content;
		this.photo_share = photo_share;
		this.photo_input_dt = photo_input_dt;
		this.photo_update_dt = photo_update_dt;
		this.photo_hit = photo_hit;
		this.photofile_original = photofile_original;
		this.photofile_saved = photofile_saved;
		this.photofile_tn = photofile_tn;
	}

	public int getPhoto_boardnum() {
		return photo_boardnum;
	}

	public void setPhoto_boardnum(int photo_boardnum) {
		this.photo_boardnum = photo_boardnum;
	}

	public String getPhoto_id() {
		return photo_id;
	}

	public void setPhoto_id(String photo_id) {
		this.photo_id = photo_id;
	}

	public String getPhoto_title() {
		return photo_title;
	}

	public void setPhoto_title(String photo_title) {
		this.photo_title = photo_title;
	}

	public String getPhoto_content() {
		return photo_content;
	}

	public void setPhoto_content(String photo_content) {
		this.photo_content = photo_content;
	}

	public int getPhoto_share() {
		return photo_share;
	}

	public void setPhoto_share(int photo_share) {
		this.photo_share = photo_share;
	}

	public String getPhoto_input_dt() {
		return photo_input_dt;
	}

	public void setPhoto_input_dt(String photo_input_dt) {
		this.photo_input_dt = photo_input_dt;
	}

	public String getPhoto_update_dt() {
		return photo_update_dt;
	}

	public void setPhoto_update_dt(String photo_update_dt) {
		this.photo_update_dt = photo_update_dt;
	}

	public int getPhoto_hit() {
		return photo_hit;
	}

	public void setPhoto_hit(int photo_hit) {
		this.photo_hit = photo_hit;
	}

	public ArrayList<String> getPhotofile_original() {
		return photofile_original;
	}

	public void setPhotofile_original(ArrayList<String> photofile_original) {
		this.photofile_original = photofile_original;
	}

	public ArrayList<String> getPhotofile_saved() {
		return photofile_saved;
	}

	public void setPhotofile_saved(ArrayList<String> photofile_saved) {
		this.photofile_saved = photofile_saved;
	}

	public String getPhotofile_tn() {
		return photofile_tn;
	}

	public void setPhotofile_tn(String photofile_tn) {
		this.photofile_tn = photofile_tn;
	}

	@Override
	public String toString() {
		return "Rodo_PhotoBoard [photo_boardnum=" + photo_boardnum + ", photo_id=" + photo_id + ", photo_title="
				+ photo_title + ", photo_content=" + photo_content + ", photo_share=" + photo_share
				+ ", photo_input_dt=" + photo_input_dt + ", photo_update_dt=" + photo_update_dt + ", photo_hit="
				+ photo_hit + ", photofile_original=" + photofile_original + ", photofile_saved=" + photofile_saved
				+ ", photofile_tn=" + photofile_tn + "]";
	}

}

	