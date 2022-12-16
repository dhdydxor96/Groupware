package kr.or.ddit.autumn.groupware.mail.service;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Properties;

import javax.activation.CommandMap;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.MailcapCommandMap;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.autumn.vo.SendMailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MailServiceImpl implements MailService {

    
    //메일보내기
    @Override
    public boolean mailSend(SendMailVO sendMailVO,String nickName,String fromAddress, String password){
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.naver.com");
        props.put("mail.smtp.port", 465);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.trust", "smtp.naver.com");
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromAddress.substring(0,fromAddress.indexOf("@")), password);
            }
        });
        session.setDebug(true);

        try {
            Message mimeMessage = new MimeMessage(session);
            mimeMessage.setHeader("Content-Type", "text/plain; charset=UTF-8");
            mimeMessage.setFrom(new InternetAddress(fromAddress, nickName));		// 별명 설정
            mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(sendMailVO.getToAddress()));
            mimeMessage.setSubject(sendMailVO.getTitle());

            
            
          if(sendMailVO.getFiles()==null||sendMailVO.getFiles().isEmpty()){
        	  mimeMessage.setContent(sendMailVO.getContent(), "text/html;charset=euc-kr");
         } else {
            
            //===================================================================================
            //======================================파일첨부====================================
            // 메일 콘텐츠 설정
        	 List<MultipartFile> files = sendMailVO.getFiles();
            
            Multipart mParts = new MimeMultipart();
            MimeBodyPart mTextPart = new MimeBodyPart();

            // 메일 콘텐츠 - 내용
            mTextPart.setText(sendMailVO.getContent(), "UTF-8", "html");
            mParts.addBodyPart(mTextPart);
            
            for(MultipartFile file : files) {
            MimeBodyPart mFilePart = new MimeBodyPart();
            DataSource ds = new javax.mail.util.ByteArrayDataSource(file.getBytes(),file.getContentType());
            
            mFilePart.setDataHandler(new DataHandler(ds));
           
             
            //파일명칭이 깨지지 않도록 조치를 취함
		    try {
		    	
		    	mFilePart.setFileName(MimeUtility.encodeText(file.getOriginalFilename(),"euc-kr","B"));
				mParts.addBodyPart(mFilePart);	  
				
			} catch (UnsupportedEncodingException e) {
				log.info("파일 endcode 에러 발생 : {} ", e.getMessage());
				
				
				e.printStackTrace();
            
			}
                  
            // 메일 콘텐츠 설정
         	}
            mimeMessage.setContent(mParts);
         }
          
        
            // MIME 타입 설정
            MailcapCommandMap MailcapCmdMap = (MailcapCommandMap) CommandMap.getDefaultCommandMap();
            MailcapCmdMap.addMailcap("text/html;; x-java-content-handler=com.sun.mail.handlers.text_html");
            MailcapCmdMap.addMailcap("text/xml;; x-java-content-handler=com.sun.mail.handlers.text_xml");
            MailcapCmdMap.addMailcap("text/plain;; x-java-content-handler=com.sun.mail.handlers.text_plain");
            MailcapCmdMap.addMailcap("multipart/*;; x-java-content-handler=com.sun.mail.handlers.multipart_mixed");
            MailcapCmdMap.addMailcap("message/rfc822;; x-java-content-handler=com.sun.mail.handlers.message_rfc822");
            CommandMap.setDefaultCommandMap(MailcapCmdMap);
       
          
            Transport.send(mimeMessage);
            return true;
        	} catch (Exception e){
              return false;
        }
    }
}