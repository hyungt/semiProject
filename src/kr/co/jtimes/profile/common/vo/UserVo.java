package kr.co.jtimes.profile.common.vo;

public class UserVo {

	private int no;
	private String id;
	private String pwd;
	private String name;
	private String email;
	private String pwdQuestion;
	private String pwdAnswer;
	
	public UserVo() {}
	
	public UserVo(int no, String id, String pwd, String name, String email, String pwdQuestion, String pwdAnswer) {
		super();
		this.no = no;
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.pwdQuestion = pwdQuestion;
		this.pwdAnswer = pwdAnswer;
	}
	
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPwdQuestion() {
		return pwdQuestion;
	}

	public void setPwdQuestion(String pwdQuestion) {
		this.pwdQuestion = pwdQuestion;
	}

	public String getPwdAnswer() {
		return pwdAnswer;
	}

	public void setPwdAnswer(String pwdAnswer) {
		this.pwdAnswer = pwdAnswer;
	}



	@Override
	public String toString() {
		return "User [no=" + no + ", id=" + id + ", pwd=" + pwd + ", name=" + name + ", email=" + email
				+ ", pwdQuestion=" + pwdQuestion + ", pwdAnswer=" + pwdAnswer + "]";
	}
	
	
	
}
