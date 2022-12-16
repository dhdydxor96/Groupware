package kr.or.ddit.autumn.groupware.archive.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.SocketException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.groupware.archive.vo.DirStructJsonVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ArchiveServiceImpl implements ArchiveService{

	@Inject
	private FtpUtil ftpUtil;
	@Value("#{ftpInfo.personalPath}")
	private String personalPath;
	
	@Override
	public boolean checkDirectory(String empId) {
		String workingPath = personalPath+"/"+empId;
		boolean result = ftpUtil.checkDirectory(workingPath);
		return result;
	}

	@Override
	public List<DirStructJsonVO> retrieveDirDepthList(String empId, String path) {
		String temp = personalPath + "/" + empId;
		log.debug("temp : {}", temp);
		String workingPath = temp + path;
		
		List<DirStructJsonVO> list = ftpUtil.getDirectoryDepthStruct(workingPath);
		
		return list;
	}

	@Override
	public List<Byte[]> downloadList(String path, String[] fileNames){
		
		
		
		return null;
	}
}
