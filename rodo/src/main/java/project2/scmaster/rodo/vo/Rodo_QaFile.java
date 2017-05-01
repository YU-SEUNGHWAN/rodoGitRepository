package project2.scmaster.rodo.vo;

public class Rodo_QaFile 
{
	private int qa_boardnum;
	private String qafile_original;
	private String qafile_saved;
	
	public Rodo_QaFile(int qa_boardnum, String qafile_original, String qafile_saved) {
		super();
		this.qa_boardnum = qa_boardnum;
		this.qafile_original = qafile_original;
		this.qafile_saved = qafile_saved;
	}
	
	public Rodo_QaFile()
	{
	}

	public int getQa_boardnum() {
		return qa_boardnum;
	}

	public void setQa_boardnum(int qa_boardnum) {
		this.qa_boardnum = qa_boardnum;
	}

	public String getQafile_original() {
		return qafile_original;
	}

	public void setQafile_original(String qafile_original) {
		this.qafile_original = qafile_original;
	}

	public String getQafile_saved() {
		return qafile_saved;
	}

	public void setQafile_saved(String qafile_saved) {
		this.qafile_saved = qafile_saved;
	}

	@Override
	public String toString() {
		return "Rodo_QaFile [qa_boardnum=" + qa_boardnum + ", qafile_original=" + qafile_original + ", qafile_saved="
				+ qafile_saved + "]";
	}
}