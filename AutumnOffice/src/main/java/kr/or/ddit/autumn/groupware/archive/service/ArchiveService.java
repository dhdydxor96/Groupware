package kr.or.ddit.autumn.groupware.archive.service;

import java.util.List;

import org.apache.commons.net.ftp.FTPFile;

import kr.or.ddit.autumn.groupware.archive.vo.DirStructJsonVO;
import kr.or.ddit.autumn.vo.AttatchVO;

public interface ArchiveService {
	
	public boolean checkDirectory(String empId);
	
	public List<DirStructJsonVO> retrieveDirDepthList(String empId, String path);
	
	public List<Byte[]> downloadList(String path, String[] fileNames);
}
