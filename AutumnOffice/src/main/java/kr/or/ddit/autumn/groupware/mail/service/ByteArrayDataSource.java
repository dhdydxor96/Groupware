package kr.or.ddit.autumn.groupware.mail.service;

import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.activation.DataSource;

class ByteArrayDataSource implements DataSource {
   byte[] bytes;
   String contentType;
   String name;

   ByteArrayDataSource(byte[] bytes, String contentType, String name) {
      this.bytes = bytes;
      if(contentType == null)
         this.contentType = "application/octet-stream";
      else
         this.contentType = contentType;
      this.name = name;
   }

   public String getContentType() {
      return contentType;
   }

   public InputStream getInputStream() {
      // 가장 마지막의 CR/LF를 없앤다.
      return new ByteArrayInputStream(bytes,0,bytes.length - 2);
   }
   
   public String getName() {
      return name;
   }
   
   public OutputStream getOutputStream() throws IOException {
      throw new FileNotFoundException();
   }
}