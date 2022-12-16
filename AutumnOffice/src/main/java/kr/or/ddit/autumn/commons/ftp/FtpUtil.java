package kr.or.ddit.autumn.commons.ftp;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.autumn.groupware.archive.vo.DirStructJsonVO;
import lombok.extern.slf4j.Slf4j;

/**
 * ftp 서버와 connection, disconnection을 담당하는 ftp pool을 inject받아서
 * ftp 서버에서 할 작업들을 사용하기 편하게 모아놓은 class 
 * @author 2022-11-28 -윤정식-
 *
 */
@Slf4j
@Repository
public class FtpUtil {
	
	@Inject
	private FtpPool pool;
	
	/**
	 * ftp 서버에 작업 디렉토리가 있는지 검사한다.
	 * 작업 디렉토리가 없다면 생성해준다.
	 * @param workingPath 작업 디렉토리 경로, 개인 자료실의 경우 작업 디렉토리 / 사원 아이디를 파라미터로 넘겨야함
	 */
	public boolean checkDirectory(String workingPath) {
		
		log.info("\n\n\n");
		log.info("[checkDirectory] checkDirectory parameter");
		log.info("[checkDirectory] param > workingPath : {}", workingPath);
		
		boolean result = true;
		FTPClient ftpClient = pool.borrowFtp();
		log.debug("[checkDirectory] ftpClient borrow...");
		try {
			boolean moveDir = ftpClient.changeWorkingDirectory(workingPath);
			log.debug("[checkDirectory] move workingDirectory : {}, {}", workingPath, moveDir);
			if(!moveDir) {
				String path = "";
				String[] splitPath = workingPath.split("/");
				
				for(String temp : splitPath) {
					log.debug("splitPath : {}", temp);
					path += temp;
					moveDir = ftpClient.changeWorkingDirectory(path);
					log.debug("[checkDirectory] move workingDirectory : {}, {}", path, moveDir);
					if(!moveDir) {
						boolean makeDir = ftpClient.makeDirectory(temp);
						log.debug("[checkDirectory] create directory : {}, {}", temp, makeDir);
						if(makeDir) {
							moveDir = ftpClient.changeWorkingDirectory(path);
							log.debug("[checkDirectory] move workingDirectory : {}, {}", path, moveDir);
						}
					}
					path += "/";
				}
			}
		} catch (IOException e) {
			log.error("[checkDirectory] working error : {}", e.getMessage());
			result = false;
			throw new RuntimeException(e);
		} finally {
			
			pool.returnFtp(ftpClient);
			log.debug("[checkDirectory] ftpClient return...");
			
		}
		return result;
	}
	
	/**
	 * ftp 서버의 path 경로안에 fileName의 파일이 존재하는지 검사한다.
	 * 존재하면 true, 존재하지 않으면 false
	 * @param path 검사할 ftp 폴더 경로
	 * @param fileName 검사할 파일 이름
	 * @return
	 * @throws IOException 
	 */
	public boolean isFileExist(String path, String fileName) {
		log.info("\n\n\n");
		log.info("[isFileExist] isFileExist parameter");
		log.info("[isFileExist] param > path : {}", path);
		log.info("[isFileExist] param > fileName : {}", fileName);
		
		FTPClient ftpClient = pool.borrowFtp();
		log.debug("[isFileExist] ftpClient borrow...");
		
		boolean flag = false;
		
		try {
			
			String currentDir = ftpClient.printWorkingDirectory();
			log.debug("[isFileExist] currentDir : {}", currentDir);
			
			String check = path + "/" + fileName;
			
			if(currentDir == null || !currentDir.equals(path)) {
				
				boolean moveDir = ftpClient.changeWorkingDirectory(path);
				log.debug("[isFileExist] moveDir : {} > {}", path, moveDir);
				
			}
			
			String[] fileNames = ftpClient.listNames(path);
			
			for(String name : fileNames) {
				if(name.equals(check)) {
					flag = true;
					break;
				}
			} // for end
			
		} catch (IOException e) {
			log.error("[isFileExist] move directory error : {}", e.getMessage());
			throw new RuntimeException(e);
		} finally {
			pool.returnFtp(ftpClient);
			log.debug("[isFileExist] ftpClient return...");
		}
		return flag;
	}
	
	/**
	 * ftp 서버의 path 경로안에 dirName의 폴더가 존재하는지 검사한다.
	 * @param path 검사할 ftp 폴더 경로
	 * @param dirName 검사할 폴더 이름
	 * @return 존재하면 true, 존재하지 않으면 false
	 * @throws IOException
	 */
	public boolean isDirectoryExist(String path, String dirName) {
		log.info("\n\n\n");
		log.info("[isDirectoryExist] isFileExist parameter");
		log.info("[isDirectoryExist] param > path : {}", path);
		log.info("[isDirectoryExist] param > fileName : {}", dirName);
		
		FTPClient ftpClient = pool.borrowFtp();
		log.debug("[isDirectoryExist] ftpClient borrow...");
		
		boolean flag = false;
		
		try {
			
			boolean moveDir = ftpClient.changeWorkingDirectory(path);
			log.debug("[isDirectoryExist] moveDir : {} > {}", path, moveDir);
				
			
			FTPFile[] files = ftpClient.listDirectories();
			
			for(FTPFile file : files) {
				if(file.getName().equals(dirName)) {
					flag = true;
					break;
				}
			} // for end
			
		} catch (IOException e) {
			log.error("[isDirectoryExist] move directory error : {}", e.getMessage());
			throw new RuntimeException(e);
		} finally {
			pool.returnFtp(ftpClient);
			log.debug("[isDirectoryExist] ftpClient return...");
		}
		log.debug("[isDirectoryExist] return : {}", flag);
		return flag;
	}
	
	/**
	 * MultipartFile의 데이터를 ftp 서버에 stream을 통해서 업로드 해준다.
	 * 업로드할 ftp 디렉토리 경로, 저장할 파일 이름, 업로드할 파일을 매개변수로 가진다.
	 * @param savePath ftp 디렉토리 경로
	 * @param saveName 저장할 파일 이름
	 * @param file 저장할 MultipartFile 객체
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	public void uploadToFtp(String savePath, String saveName, MultipartFile file) {
		log.info("\n\n\n");
		log.info("[uploadToFtp] uploadToFtp parameter");
		log.info("[uploadToFtp] param > savePath : {}", savePath);
		log.info("[uploadToFtp] param > saveName : {}", saveName);
		log.info("[uploadToFtp] param > file : {}", file);
		
		if(file==null) return;
		
		FTPClient ftpClient = pool.borrowFtp();
		log.debug("[uploadToFtp] ftpClient borrow...");
		
		String currentDir = null;
		try {
			
			currentDir = ftpClient.printWorkingDirectory();
			log.debug("[uploadToFtp] currentDir : {}", currentDir);
			if(currentDir == null || !currentDir.equals(savePath)) {
				boolean moveDir = ftpClient.changeWorkingDirectory(savePath);
				log.debug("[uploadToFtp] moveDir : {} > {}", savePath, moveDir);
			}
			
		} catch (IOException e1) {
			log.error("[uploadToFtp] move directory error : {}", e1.getMessage());
			throw new RuntimeException(e1);
		}
		
		try (
			InputStream is = file.getInputStream();
			OutputStream os = ftpClient.storeFileStream(saveName);
		){
			
			log.debug("[uploadToFtp] stream working...");
			byte[] buffer = new byte[1024];
			int length = -1;
			while( (length = is.read(buffer, 0, buffer.length)) != -1 ) {
				os.write(buffer, 0, length);
			}
			log.debug("[uploadToFtp] stream working end...");
			
		} catch (Exception e) {
			log.error("[uploadToFtp] stream error : {}", e.getMessage());
			throw new RuntimeException(e);
		} finally {
			
			pool.returnFtp(ftpClient);
			log.debug("[uploadToFtp] ftpClient return...");
			
		}
	}
	
	/**
	 * ftp 서버에서 파일을 삭제한다.
	 * 삭제할 파일이 있는 경로와 삭제할 파일 이름을 매개변수로 가진다.
	 * @param savePath 삭제할 파일이 있는 디렉토리 경로
	 * @param saveName 삭제할 파일 이름
	 * @return
	 */
	public boolean removeFile(String savePath, String saveName) {
		log.info("\n\n\n");
		log.info("[removeFile] removeFile parameter");
		log.info("[removeFile] param > savePath : {}", savePath);
		log.info("[removeFile] param > saveName : {}", saveName);
		
		FTPClient ftpClient = pool.borrowFtp();
		log.debug("[removeFile] ftpClient borrow...");
		
		boolean moveDir = false;
		boolean result = false;
		
		try {
			
			String currentDir = ftpClient.printWorkingDirectory();
			log.debug("[removeFile] currentDir : {}", currentDir);
			
			if(!currentDir.equals(savePath)) {
				
				moveDir = ftpClient.changeWorkingDirectory(savePath);
				log.debug("[removeFile] moveDir : {} > {}", savePath, moveDir);
				
			}
			
			String filePath = savePath + "/" + saveName;
			result = ftpClient.deleteFile(filePath);
		} catch (IOException e) {
			log.error("[removeFile] move directory error : {}", e.getMessage());
			throw new RuntimeException(e);
		} finally {
			pool.returnFtp(ftpClient);
			log.debug("[removeFile] ftpClient return...");
		}
		
		return result;
	}
	
	public boolean removeFiles(String path, String saveName) {
		log.info("\n\n\n");
		log.info("[removeFiles] removeFile parameter");
		log.info("[removeFiles] param > savePath : {}", path);
		log.info("[removeFiles] param > saveName : {}", saveName);
		
		FTPClient ftpClient = pool.borrowFtp();
		log.debug("[removeFiles] ftpClient borrow...");
		
		boolean result = false;
		try {
			result = removeFileOne(ftpClient, path, saveName);
			log.debug("[removeFiles] removeFileOne result : {}", result);
		} finally {
			pool.returnFtp(ftpClient);
			log.debug("[removeFiles] ftpClient return...");
		}
		return result;
	}
	
	private boolean removeFileOne(FTPClient ftpClient, String path, String saveName) {
		log.info("\n\n\n");
		log.info("[removeFileOne] removeFileOne parameter");
		log.info("[removeFileOne] param > savePath : {}", path);
		log.info("[removeFileOne] param > saveName : {}", saveName);
		boolean flag = true;
		try {
			boolean change = ftpClient.changeWorkingDirectory(path);
			log.debug("[removeFileOne] change : {}", change);
			FTPFile[] files = ftpClient.listFiles();
			for(FTPFile file : files) {
				if(file.getName().equals(saveName)) {
					String filePath = path + "/" + saveName;
					log.debug("[removeFileOne] filePath : {}", filePath);
					if(file.isDirectory()) {
						boolean dirResult = removeDir(ftpClient, filePath);
						log.debug("[removeFileOne] dirResult : {}", dirResult);
						if(dirResult) {
							flag = ftpClient.removeDirectory(filePath);
							log.debug("[removeFileOne] removeDirectory : {}, {}", filePath, flag);
						}
					}else{
						flag = ftpClient.deleteFile(filePath);
						log.debug("[removeFileOne] deleteFile : {}, {}", filePath, flag);
					}
				}
			}
			
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		log.info("[removeFileOne] return : {}", flag);
		return flag;
	}
	
	private boolean removeDir(FTPClient ftpClient, String path) {
		log.info("\n\n\n");
		log.info("[removeDir] removeFileOne parameter");
		log.info("[removeDir] param > savePath : {}", path);
		boolean flag = true;
		try {
			boolean change = ftpClient.changeWorkingDirectory(path);
			log.debug("[removeDir] change : {}", change);
			FTPFile[] files = ftpClient.listFiles();
			for(FTPFile file : files) {
				String filePath = path + "/" + file.getName();
				log.debug("[removeDir] filePath : {}", filePath);
				if(file.isDirectory()) {
					boolean dirResult = removeDir(ftpClient, filePath);
					log.debug("[removeDir] dirResult : {}", dirResult);
					if(dirResult) {
						flag = ftpClient.removeDirectory(filePath);
						log.debug("[removeDir] removeDirectory : {}, {}", filePath, flag);
					}
				}else {
					flag = ftpClient.deleteFile(filePath);
					log.debug("[removeDir] deleteFile : {}, {}", filePath, flag);
				}
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		log.info("[removeDir] return : {}", flag);
		return flag;
	}
	
	/**
	 * ftp 서버에 있는 파일을 byte[] 배열화 시켜서 return 해주는 메소드
	 * @param savePath ftp 내부에 파일이 있는 경로
	 * @param saveName 꺼내올 파일 이름
	 * @return 꺼내올 파일의 byte[] 배열
	 * @throws IOException
	 */
	public byte[] getFileByte(String savePath, String saveName) throws IOException {
		log.info("\n\n\n");
		log.info("[getFileByte] getFileByte parameter");
		log.info("[getFileByte] param > savePath : {}", savePath);
		log.info("[getFileByte] param > saveName : {}", saveName);
		
		FTPClient ftpClient = pool.borrowFtp();
		log.debug("[getFileByte] ftpClient borrow...");

		boolean moveDir = false;
		byte[] byteArray = null;
		String currentDir = ftpClient.printWorkingDirectory();
		
		if(currentDir == null || !currentDir.equals(savePath)) {
			
			moveDir = ftpClient.changeWorkingDirectory(savePath);
			log.debug("[getFileByte] moveDir : {} > {}", savePath, moveDir);
			
		}
		
		try (
				
			InputStream is = ftpClient.retrieveFileStream(saveName);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
				
		){
			
			byte[] buffer = new byte[1024];
			int length = -1;
			log.debug("[getFileByte] stream working start...");
			while( (length = is.read(buffer, 0, buffer.length)) != -1 ) {
				os.write(buffer, 0, length);
			}
			log.debug("[getFileByte] stream working end...");
			
			byteArray = os.toByteArray();
			
		} catch (Exception e) {
			log.debug("[getFileByte] stream error : {}", e.getMessage());
			throw new RuntimeException(e);
		} finally {
			pool.returnFtp(ftpClient);
			log.debug("[getFileByte] ftpClient return...");
		}
		
		
		return byteArray;
	}
	
	/**
	 * 인자값으로 넘겨준 path의 하위 구조를 List 형태로 반환
	 * 하위 구조중 폴더 여부로 정렬되어 반환
	 * @param path 구조를 표현할 base 경로
	 * @return List<DirStructJsonVO>
	 */
	public List<DirStructJsonVO> getDirectoryDepthStruct(String path){
		log.info("\n\n\n");
		log.info("[getDirectoryDepthStruct] getDirectoryDepthStruct parameter");
		log.info("[getDirectoryDepthStruct] param > path : {}", path);
		
		FTPClient ftpClient = pool.borrowFtp();
		log.debug("[getDirectoryDepthStruct] ftpClient borrow...");
		
		List<DirStructJsonVO> dirDepth = null;
		
		try {
			boolean moveDir = ftpClient.changeWorkingDirectory(path);
			log.debug("[getDirectoryDepthStruct] moveDir : {} > {}", path, moveDir);
			if(!moveDir) {
				throw new RuntimeException("can't move directory...");
			}
			
			FTPFile[] files = ftpClient.listFiles();
			dirDepth = new ArrayList<DirStructJsonVO>();
			
			for(FTPFile file : files) {
				log.debug("[getDirectoryDepthStruct] isDir : {}", file.isDirectory());
				log.debug("[getDirectoryDepthStruct] setText : {}", file.getName());
				DirStructJsonVO dirStruct = new DirStructJsonVO();
				dirStruct.setText(file.getName());
				if(file.isDirectory()) {
					dirStruct.setDir(true);
				}
				dirDepth.add(dirStruct);
			}
			Collections.sort(dirDepth);
		} catch (IOException e) {
			log.debug("[getDirectoryDepthStruct] stream error : {}", e.getMessage());
			throw new RuntimeException(e);
		} finally {
			pool.returnFtp(ftpClient);
			log.debug("[getDirectoryDepthStruct] ftpClient return...");
		}
		return dirDepth;
	}
	
	
	/**
	 * ftp 서버에 path 경로에 dirName으로 폴더 생성
	 * @param path ftp 서버 경로 (empId 이후 경로)
	 * @param dirName 생성할 폴더 이름
	 * @return 성공 true, 실패 false
	 */
	public boolean createDirectory(String path, String dirName) {
		
		log.info("\n\n\n");
		log.info("[createDirectory] createDirectory parameter");
		log.info("[createDirectory] param > path : {}", path);
		log.info("[createDirectory] param > dirName : {}", dirName);
		
		FTPClient ftpClient = pool.borrowFtp();
		log.debug("[createDirectory] ftpClient borrow...");

		boolean moveDir = false;
		boolean makeResult = false;
		try {
			moveDir = ftpClient.changeWorkingDirectory(path);
			log.debug("[createDirectory] moveDir : {} > {}", path, moveDir);
			if(!moveDir) {
				throw new RuntimeException("can't move directory...");
			}
			makeResult = ftpClient.makeDirectory(dirName);
		} catch (IOException e) {
			log.error("[createDirectory] move directory error : {}", e.getMessage());
			throw new RuntimeException(e);
		} finally {
			pool.returnFtp(ftpClient);
		}
			
		return makeResult;
	}
	
}
