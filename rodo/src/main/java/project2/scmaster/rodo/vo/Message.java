package project2.scmaster.rodo.vo;

public class Message {

	private int messagenum;
	private String sender;
	private String receiver;
	private String title;
	private String text;
	private String senddate;
	private String flag;

	public Message() {
		// TODO Auto-generated constructor stub
	}

	public Message(int messagenum, String sender, String receiver, String title, String text, String senddate,
			String flag) {
		super();
		this.messagenum = messagenum;
		this.sender = sender;
		this.receiver = receiver;
		this.title = title;
		this.text = text;
		this.senddate = senddate;
		this.flag = flag;
	}

	public int getMessagenum() {
		return messagenum;
	}

	public void setMessagenum(int messagenum) {
		this.messagenum = messagenum;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getSenddate() {
		return senddate;
	}

	public void setSenddate(String senddate) {
		this.senddate = senddate;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	@Override
	public String toString() {
		return "Message [messagenum=" + messagenum + ", sender=" + sender + ", receiver=" + receiver + ", title="
				+ title + ", text=" + text + ", senddate=" + senddate + ", flag=" + flag + "]";
	}
	
}
