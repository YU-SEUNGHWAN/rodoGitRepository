package project2.scmaster.rodo.vo;

public class Rodo_FreeFile 
{
	private int free_boardnum;
	private String freefile_original;
	private String freefile_saved;
	
	public Rodo_FreeFile(int free_boardnum, String freefile_original, String freefile_saved) {
		super();
		this.free_boardnum = free_boardnum;
		this.freefile_original = freefile_original;
		this.freefile_saved = freefile_saved;
	}

	public Rodo_FreeFile() {
		super();
	}

	public int getFree_boardnum() {
		return free_boardnum;
	}

	public void setFree_boardnum(int free_boardnum) {
		this.free_boardnum = free_boardnum;
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
		return "Rodo_FreeFile [free_boardnum=" + free_boardnum + ", freefile_original=" + freefile_original
				+ ", freefile_saved=" + freefile_saved + "]";
	}
}