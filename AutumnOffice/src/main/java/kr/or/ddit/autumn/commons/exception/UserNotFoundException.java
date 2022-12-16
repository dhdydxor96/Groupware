package kr.or.ddit.autumn.commons.exception;

public class UserNotFoundException extends PKNotFoundException{

	private String empId;
	
	public UserNotFoundException(String empId) {
		this.empId = empId;
	}
	
	@Override
	public String getMessage() {
		return String.format("%s 아이디 회원이 존재하지 않음.", this.empId);
	}
}
