package kr.or.ddit.autumn.commons.ftp;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class FtpSettings {
	// factory settings
	// ftp 서버를 구동하는 pc ip
	private String serverIp;
	// ftp 서버 포트 기본 21
	private int port;
	// ftp 서버 로그인 할 id
	private String user;
	// ftp 서버 로그인 할 password
	private String password;
	// 데이터 연결에서 읽을 때 사용할 제한 시간 (밀리세컨드) 0이면 무제한
	private int dataTimeout;
	// ftp 서버 데이터 encoding
	private String controlEncoding;
	// stream 데이터 오갈때 buffer 사이즈
	private int bufferSize;
	
	// pool settings
	// 생성할 pool 최대 갯수
	private int maxTotal;
	// pool에 반납할 때 최대로 유지될 수 있는 갯수
	private int maxIdle;
	// pool 대여 대기 최대 시간
	private int maxWaitMillis;
	// 생성된 pool 대기 시간(분) -> 대기시간 끝나면 삭제됨
	private int softMinEvictableIdleTime;
}
