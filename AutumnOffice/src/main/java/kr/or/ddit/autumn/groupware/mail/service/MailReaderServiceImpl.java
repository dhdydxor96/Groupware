package kr.or.ddit.autumn.groupware.mail.service;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.UIDFolder;
import javax.mail.internet.MimeBodyPart;
import javax.mail.search.AndTerm;
import javax.mail.search.ComparisonTerm;
import javax.mail.search.FlagTerm;
import javax.mail.search.ReceivedDateTerm;
import javax.mail.search.SearchTerm;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.groupware.mail.vo.ReceiveMailVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MailReaderServiceImpl {
    private File saveDirectory;
    
    private Map<String,ReceiveMailVO> mailMap;
    
    private ServletContext application;
    
    
    public void setSaveDirectory(File dir) {
        this.saveDirectory = dir;
    }

    
   //받은메일함
    public List<ReceiveMailVO> receiveMailAttachedFile(HttpServletRequest request,String userName, String password, Date startDate, Date endDate) throws MessagingException, IOException {
    	List<ReceiveMailVO> mailList = new ArrayList<>();
    	mailMap = new LinkedHashMap<>();
    	
    	
    	application = request.getServletContext();
    	
    	Properties props = System.getProperties();
        props.setProperty("mail.store.protocol", "imaps");
        try {
//            Session session = Session.getDefaultInstance(props, null);
        	Session session = Session.getInstance(props, null);
            Store store = session.getStore("imaps");
            store.connect("imap.naver.com", userName, password);
            
            // 받은편지함을 INBOX 라고 한다.
            Folder inbox = store.getFolder("INBOX");
            UIDFolder uf = (UIDFolder) inbox;
           
            inbox.open(Folder.READ_ONLY);
            SearchTerm olderThan = new ReceivedDateTerm (ComparisonTerm.LT, startDate);
            SearchTerm newerThan = new ReceivedDateTerm (ComparisonTerm.GT, endDate);
            SearchTerm andTerm = new AndTerm(olderThan, newerThan);
            // 받은 편지함에 있는 메일 모두 읽어오기
            Message[] arrayMessages = inbox.getMessages();
            // 안읽은 메시지
            Message newMessages[] = inbox.search(new FlagTerm(new Flags(Flags.Flag.SEEN), false));
            

            for (int i = arrayMessages.length; i > 970; i--) {
                Message msg = arrayMessages[i-1];
                Address[] fromAddress = msg.getFrom();
                // 메일 내용 변수에 담기

                log.info("message:{}",msg.toString());
                ReceiveMailVO mail = new ReceiveMailVO();
                
                  
                 int index = fromAddress[0].toString().indexOf("<");
                 
                String str = fromAddress[0].toString().substring(index+1);
                
                String from = str.substring(0, str.length()-1);
                
                int idIndex = from.indexOf("@");
                String sendId = from.substring(0,idIndex);
                String subject = msg.getSubject();
                String sentDate = msg.getSentDate().toString();
                String receivedDate = msg.getReceivedDate().toString();
                String contentType = msg.getContentType();
                String messageContent = msg.getContent().toString();
                String attachFiles = "";
                
                
                mail.setMailNo(i);
                mail.setSendId(sendId);
                mail.setFrom(from);
                mail.setSubject(subject);
                mail.setSentDate(sentDate);
                mail.setReceivedDate(receivedDate);
                mail.setContentType(contentType);
                mail.setMessageContent(messageContent);
                
                
                

				// 첨부파일
                if (contentType.contains("multipart")) {
                    Multipart multiPart = (Multipart) msg.getContent();
                    int numberOfParts = multiPart.getCount();
                    for (int partCount = 0; partCount < numberOfParts; partCount++) {
                        MimeBodyPart part = (MimeBodyPart) multiPart.getBodyPart(partCount);
                        if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) {
                            // 첨부파일 있을 경우 지정 폴더로 저장
                            String fileName = part.getFileName();
                            attachFiles += fileName + ", ";
//                            part.saveFile(saveDirectory + File.separator + fileName);
                        } else {
                            // 메일 내용 저장
                            messageContent = part.getContent().toString();
                            mail.setMessageContent(messageContent);
                        }
                    }
                    if (attachFiles.length() > 1) {
                        attachFiles = attachFiles.substring(0,
                        		attachFiles.length() - 2);
                        mail.setAttachFiles(attachFiles);
                    }
                } else if (contentType.contains("text/plain") || contentType.contains("text/html")) {
                    Object content = msg.getContent();
                    if (content != null) {
                        messageContent = content.toString();
                    }
                }

                mailMap.put("mail"+i, mail);
                
                mailList.add(mail);
                
                application.setAttribute("mailMap", mailMap);
            }
            
            	
            // disconnect
            inbox.close(false);
            store.close();

            
            
        } catch (MessagingException e) {
            e.printStackTrace();
            System.exit(2);
        }
       
        return mailList;
    }

    
    //페이징용받은메일함
    public List<ReceiveMailVO> receiveMailAttachedFilePaging(HttpServletRequest request,String userName, String password, int page) throws MessagingException, IOException, ParseException {
    	List<ReceiveMailVO> mailList = new ArrayList<>();
    	mailMap = new LinkedHashMap<>();
    	
    	
    	application = request.getServletContext();
    	
    	Properties props = System.getProperties();
        props.setProperty("mail.store.protocol", "imaps");
        try {

        	Session session = Session.getInstance(props, null);
            Store store = session.getStore("imaps");
            store.connect("imap.naver.com", userName, password);
            
            // 받은편지함을 INBOX 라고 한다.
            Folder inbox = store.getFolder("INBOX");
            inbox.open(Folder.READ_ONLY);
           
            // 받은 편지함에 있는 메일 모두 읽어오기
            Message[] arrayMessages = inbox.getMessages();
            
            for (int start = (page - 1 ) * 10+1 ; start < (page - 1) * 10 + 11 ; start++){
    			int msgIndex= arrayMessages.length - start;
    			if(msgIndex<0) {
    				  inbox.close(false);
    		            store.close();

    		            return mailList;
    			}
    			
    			Message msg = arrayMessages[msgIndex];
                Address[] fromAddress = msg.getFrom();
                // 메일 내용 변수에 담기

                ReceiveMailVO mail = new ReceiveMailVO();
                
                  
                 int index = fromAddress[0].toString().indexOf("<");
                 
                String str = fromAddress[0].toString().substring(index+1);
                
                String from = str.substring(0, str.length()-1);
                
                int idIndex = from.indexOf("@");
                String sendId = from.substring(0,idIndex);
                String subject = msg.getSubject();
                String textDate = msg.getSentDate().toString();
                
               //날짜 형식 바꾸기
                SimpleDateFormat recvSimpleFormat = new SimpleDateFormat("E MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
                SimpleDateFormat tranSimpleFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);
         
                Date data = recvSimpleFormat.parse(textDate);
                String sentDate = tranSimpleFormat.format(data);
            
                String receivedDate = msg.getReceivedDate().toString();
                String contentType = msg.getContentType();
                String messageContent = msg.getContent().toString();
                String attachFiles = "";
                
                
                mail.setMailNo(msgIndex+1);
                mail.setSendId(sendId);
                mail.setFrom(from);
                mail.setSubject(subject);
                mail.setSentDate(sentDate);
                mail.setReceivedDate(receivedDate);
                mail.setContentType(contentType);
                mail.setMessageContent(messageContent);
                
                
                

				// 첨부파일
                if (contentType.contains("multipart")) {
                    Multipart multiPart = (Multipart) msg.getContent();
                    int numberOfParts = multiPart.getCount();
                    for (int partCount = 0; partCount < numberOfParts; partCount++) {
                        MimeBodyPart part = (MimeBodyPart) multiPart.getBodyPart(partCount);
                        if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) {
                            // 첨부파일 있을 경우 지정 폴더로 저장
                            String fileName = part.getFileName();
                            attachFiles += fileName + ", ";
                           // part.saveFile(saveDirectory + File.separator + fileName);
                        } else {
                            // 메일 내용 저장
                            messageContent = part.getContent().toString();
                            mail.setMessageContent(messageContent);
                        }
                    }
                    if (attachFiles.length() > 1) {
                        attachFiles = attachFiles.substring(0,
                        		attachFiles.length() - 2);
                        mail.setAttachFiles(attachFiles);
                    }
                } else if (contentType.contains("text/plain") || contentType.contains("text/html")) {
                    Object content = msg.getContent();
                    if (content != null) {
                        messageContent = content.toString();
                    }
                }


                mailMap.put("mail"+(msgIndex+1), mail);
                
                
                mailList.add(mail);
                
                application.setAttribute("mailMap", mailMap);
            }
            
            	
            // disconnect
            inbox.close(false);
            store.close();

            
            
        } catch (MessagingException e) {
            e.printStackTrace();
            System.exit(2);

        }
       
        return mailList;
    }
    
    //메일 하나 삭제로직
    public boolean deleteMail(Integer mailNo, String userName, String password) throws MessagingException, IOException {
    	
    	
    	boolean result = true;
    	Properties props = System.getProperties();
        props.setProperty("mail.store.protocol", "imaps");
        try {
            Session session = Session.getDefaultInstance(props, null);
            Store store = session.getStore("imaps");
            store.connect("imap.naver.com", userName, password);
           
            
            Folder inbox = store.getFolder("INBOX");
            inbox.open(Folder.READ_WRITE);
            
            
            Message[] oneMessages = inbox.getMessages(mailNo,mailNo);
         
		         
		         oneMessages[0].setFlag(Flags.Flag.DELETED, true);
		       
         
            inbox.close((true));
            store.close();

            
            
        } catch (MessagingException e) {
        	result= false;
            e.printStackTrace();
            System.exit(2);
        }
       
        return result;
    }

   
    
    //메일 삭제로직
    public boolean deleteCheckMail(Integer [] deleteNos, String userName, String password) throws MessagingException, IOException {
    	
    	Properties props = System.getProperties();
        props.setProperty("mail.store.protocol", "imaps");
        try {
            Session session = Session.getDefaultInstance(props, null);
            Store store = session.getStore("imaps");
            store.connect("imap.naver.com", userName, password);
           
            
            Folder inbox = store.getFolder("INBOX");
            inbox.open(Folder.READ_WRITE);
           log.info("deleteNos[0] : {}",deleteNos[0]);
           log.info("deleteNos[deleteNos.length-1] : {}",deleteNos[deleteNos.length-1]);
           
           
        	   for (int i =0; i<deleteNos.length; i++) {
        		   if(deleteNos[i] + i > 1000) {
        			   Message[] oneMessages = inbox.getMessages(1000,1000);
        			   oneMessages[0].setFlag(Flags.Flag.DELETED, true);
        			   
        		   }else {
        			   Message[] oneMessages = inbox.getMessages(deleteNos[i]+i,deleteNos[i]+i);
        			   oneMessages[0].setFlag(Flags.Flag.DELETED, true);
        		   }
        		   
        		   
			}
     
            inbox.close((false));
            store.close();

            
            
        } catch (MessagingException e) {
            e.printStackTrace();
            System.exit(2);

        }
       
        return true;
    }


	public int retrieveMailCount(PagingVO<ReceiveMailVO> pagingVO, String userName, String password) {
		Properties props = System.getProperties();
        props.setProperty("mail.store.protocol", "imaps");
        int totalCount = 0;
        try {

        	Session session = Session.getInstance(props, null);
            Store store = session.getStore("imaps");
            store.connect("imap.naver.com", userName, password);
            
            // 받은편지함을 INBOX 라고 한다.
            Folder inbox = store.getFolder("INBOX");
            UIDFolder uf = (UIDFolder) inbox;
           
            inbox.open(Folder.READ_ONLY);
           
            // 받은 편지함에 있는 메일 모두 읽어오기
            totalCount = inbox.getMessageCount();
            return totalCount;
        
        } catch (MessagingException e) {
            e.printStackTrace();
            System.exit(2);

        }
		return totalCount;
      
       
	}


    
}