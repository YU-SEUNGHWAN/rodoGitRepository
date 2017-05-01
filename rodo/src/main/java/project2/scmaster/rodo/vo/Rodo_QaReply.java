package project2.scmaster.rodo.vo;

public class Rodo_QaReply 
{
	private int qareply_replynum;
	private int qa_boardnum;
	private String qareply_id;
	private String qareply_text;
	private String qareply_input_dt;
	private String qareply_update_dt;
	
	public Rodo_QaReply()
	{
	}

	public Rodo_QaReply(int qareply_replynum, int qa_boardnum, String qareply_id, String qareply_text,
			String qareply_input_dt, String qareply_update_dt) {
		super();
		this.qareply_replynum = qareply_replynum;
		this.qa_boardnum = qa_boardnum;
		this.qareply_id = qareply_id;
		this.qareply_text = qareply_text;
		this.qareply_input_dt = qareply_input_dt;
		this.qareply_update_dt = qareply_update_dt;
	}

	public int getQareply_replynum() {
		return qareply_replynum;
	}

	public void setQareply_replynum(int qareply_replynum) {
		this.qareply_replynum = qareply_replynum;
	}

	public int getQa_boardnum() {
		return qa_boardnum;
	}

	public void setQa_boardnum(int qa_boardnum) {
		this.qa_boardnum = qa_boardnum;
	}

	public String getQareply_id() {
		return qareply_id;
	}

	public void setQareply_id(String qareply_id) {
		this.qareply_id = qareply_id;
	}

	public String getQareply_text() {
		return qareply_text;
	}

	public void setQareply_text(String qareply_text) {
		this.qareply_text = qareply_text;
	}

	public String getQareply_input_dt() {
		return qareply_input_dt;
	}

	public void setQareply_input_dt(String qareply_input_dt) {
		this.qareply_input_dt = qareply_input_dt;
	}

	public String getQareply_update_dt() {
		return qareply_update_dt;
	}

	public void setQareply_update_dt(String qareply_update_dt) {
		this.qareply_update_dt = qareply_update_dt;
	}

	@Override
	public String toString() {
		return "Rodo_QaReply [qareply_replynum=" + qareply_replynum + ", qa_boardnum=" + qa_boardnum + ", qareply_id="
				+ qareply_id + ", qareply_text=" + qareply_text + ", qareply_input_dt=" + qareply_input_dt
				+ ", qareply_update_dt=" + qareply_update_dt + "]";
	}
}