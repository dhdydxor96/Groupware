package kr.or.ddit.autumn.groupware.mail.vo;

import lombok.Data;

@Data
public class ReceiveMailVO {
	 private Integer mailNo;
	 private String from ;
	 private String sendId;
     private String subject ;
     private String sentDate ;
     private String receivedDate ;
     private String contentType ;
     private String messageContent ;
     private String attachFiles ;
}
