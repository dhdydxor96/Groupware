package kr.or.ddit.autumn.commons.ftp;

import java.io.IOException;
import java.util.Properties;

import javax.inject.Inject;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPClientConfig;
import org.apache.commons.net.ftp.FTPReply;
import org.apache.commons.pool2.BasePooledObjectFactory;
import org.apache.commons.pool2.PooledObject;
import org.apache.commons.pool2.impl.DefaultPooledObject;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FtpConnectFactory extends BasePooledObjectFactory<FTPClient> {
	
	private FtpSettings setting;
	
	public FtpConnectFactory(FtpSettings setting) {
		super();
		this.setting = setting;
	}

	@Override
	public FTPClient create() {
		FTPClient ftpClient = new FTPClient();
		
		return ftpClient;
	}

	@Override
	public PooledObject<FTPClient> wrap(FTPClient ftpClient) {
		log.info("return DefaultPooledObject...");
		return new DefaultPooledObject<>(ftpClient);
	}

	@Override
	public void destroyObject(PooledObject<FTPClient> ftpPooled) {
		log.info("destroyObject...");
		if (ftpPooled == null) {
			return;
		}

		FTPClient ftpClient = ftpPooled.getObject();
		log.info("get object from pooled object : {}", ftpClient);
		
	}

	@Override
	public boolean validateObject(PooledObject<FTPClient> ftpPooled) {
		log.info("validateObject...");
		try {
			FTPClient ftpClient = ftpPooled.getObject();
			log.info("get object from pooled object : {}", ftpClient);
			log.info("return no op...");
			return ftpClient.sendNoOp();
		} catch (IOException e) {
			log.error("failed to validate client: {}", e);
		}
		return false;
	}
	
	

}
