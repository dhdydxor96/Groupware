package kr.or.ddit.autumn.groupware.archive.service;

import static org.junit.Assert.*;

import java.io.IOException;

import javax.inject.Inject;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.or.ddit.autumn.commons.ftp.FtpPool;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/datasource-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/security-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/aop-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/ftp-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/mail-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/websocket-context.xml"
})
public class ArchiveServiceImplTest {

	@Inject
	private FtpPool pool;
	@Value("#{ftpInfo.personalPath}")
	private String personalPath;
	
	@Test
	public void test() {
		FTPClient ftpClient = pool.borrowFtp();
		
		try {
			boolean result = ftpClient.changeWorkingDirectory(personalPath);
			System.out.println("워킹 디렉토리 체인지 결과값 : " + result);
			FTPFile[] Files = ftpClient.listFiles();
			for(FTPFile file : Files) {
				System.out.println(file.getName());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
