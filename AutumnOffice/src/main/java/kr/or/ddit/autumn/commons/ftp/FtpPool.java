package kr.or.ddit.autumn.commons.ftp;

import java.io.IOException;
import java.time.Duration;

import javax.inject.Inject;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class FtpPool {
	
	private final GenericObjectPoolConfig<FTPClient> config;
	private final GenericObjectPool<FTPClient> pool;
	
	@Inject
	private FtpSettings setting;
	
	
	private FtpPool(FtpSettings setting){
		// GenericObjectPool 설정할 객체 생성
		this.config = new GenericObjectPoolConfig<>();
		
		// 셋팅 부분
		this.config.setMaxTotal(setting.getMaxTotal());
		this.config.setMaxIdle(setting.getMaxIdle());
		this.config.setMaxWaitMillis(setting.getMaxWaitMillis());
		this.config.setSoftMinEvictableIdleTime(Duration.ofMinutes(setting.getSoftMinEvictableIdleTime()));
		
		// 설정한 셋팅과 factory를 매개변수로 GenericObjectPool 생성
		// GenericObjectPool이 객체를 생성해주고 생성한 객체를 빌리고 반납하는식으로 메모리 절약 가능
		// 최대 생성갯수를 제한해놓으면 많은 연결 요청이 있을때도 ftp 연결객체는 설정한 갯수만 생성되서 서버는 일정한 부하만 감당한다.
		pool = new GenericObjectPool<FTPClient>(new FtpConnectFactory(setting), config);
	}
	
	public FTPClient borrowFtp() {
		FTPClient ftpClient = null;
		try {
			// pool에서 객체 빌려옴 -> 생성된 객체가 없다면 pool에서 새로 생성해서 빌려준다.
			ftpClient = pool.borrowObject();
			log.info("created count : {}", pool.getCreatedCount());
			log.info("borrow count : {}", pool.getBorrowedCount());
			
			// 연결 설정
			ftpClient.setControlEncoding(setting.getControlEncoding());
			ftpClient.setDataTimeout(setting.getDataTimeout());
			
			// ftp 서버 연결 -> ip, port
			ftpClient.connect(setting.getServerIp(), setting.getPort());
			
			// ftp 서버에 연결되었으면 로그 출력
			if(ftpClient.isConnected()) {
				log.info("ftp server connect...");
				log.info("ip : {}, port : {}", setting.getServerIp(), setting.getPort() );
			}
			
			// 연결이 잘 되었나 검사하는 코드
			int replyCode = ftpClient.getReplyCode();
			
			// 연결이 잘 안되었으면 연결을 끊는다.
			if (!FTPReply.isPositiveCompletion(replyCode)) {
				ftpClient.disconnect();
				log.warn("ftpServer refused connection,replyCode:{}", replyCode);
				return null;
			}

			// 연결이 잘 되었으면 로그인 ftp 서버에 등록되어있는 아이디로 로그인 진행
			// 로그인 안됐으면 로그 출력
			if (!ftpClient.login(setting.getUser(), setting.getPassword())) {
				log.warn("ftpClient login failed... username is {}; password: {}", setting.getUser(),
						setting.getPassword());
			}
			log.info("login success...");
			
			// ftp 서버에서 파일 송수신할 buffer와 fileType 설정
			ftpClient.setBufferSize(setting.getBufferSize());
			ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

		} catch (Exception e) {
			log.error("borrow error {}", e.getMessage());
		}
		
		// 설정 다 된 ftpClient 객체 return 이 ftpClient 가지고 작업한다.
		return ftpClient;
	}
	
	public void returnFtp(FTPClient ftpClient) {
		try {
			// ftp 서버에서 로그아웃
			ftpClient.logout();
			log.info("ftp logout...");
		} catch (IOException io) {
			log.error("ftp client logout failed...{}", io);
		} finally {
			try {
				// ftp 서버에 연결되어있으면 연결을 끊는다.
				if (ftpClient.isConnected()) {
					ftpClient.disconnect();
				}
			} catch (IOException io) {
				log.error("close ftp client failed...{}", io);
			}
		}
		// pool에 사용하던 객체 반환 -> 설정한 시간만큼 살아있는다.
		pool.returnObject(ftpClient);
	}
}
