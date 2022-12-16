package kr.or.ddit.autumn.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.groupware.mail.vo.ReceiveMailVO;
import lombok.Data;

@Data
public class ImportMailVO {
	@NotNull(groups=DeleteGroup.class)
	private Integer maiNo;
	@NotBlank(groups=InsertGroup.class)
	private String maiAddress;
    private String maiTitle;
    private String maiContent;
    private String empId;
    private String maiDate;
    
    private ReceiveMailVO adaptee;
	
    public ImportMailVO() {};
    
	public ImportMailVO(ReceiveMailVO adaptee) {
		super();
		this.adaptee = adaptee;
		this.maiAddress = adaptee.getFrom();
		this.maiTitle =  adaptee.getSubject();
		this.maiContent = adaptee.getMessageContent();
		this.maiDate = adaptee.getSentDate();
	}

}
