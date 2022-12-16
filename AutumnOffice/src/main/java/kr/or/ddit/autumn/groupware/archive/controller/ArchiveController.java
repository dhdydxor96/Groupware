package kr.or.ddit.autumn.groupware.archive.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.groupware.archive.service.ArchiveService;
import kr.or.ddit.autumn.groupware.archive.vo.DirStructJsonVO;
import kr.or.ddit.autumn.groupware.archive.vo.FilePathVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/archive")
public class ArchiveController {
	
	@Inject
	private FtpUtil ftpUtil;
	
	@Value("#{ftpInfo.personalPath}")
	private String personalPath;
	
	@Inject
	private ArchiveService service;
	
	@GetMapping("/personal.do")
	public String archiveUI(
			@AuthenticationPrincipal(expression="realUser") EmployeeVO employee
	) {
		String empId = employee.getEmpId();
		boolean result = service.checkDirectory(empId);
		
		return "groupware/archive/archive";
	}
	
	@GetMapping(value="/dirDepthList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<DirStructJsonVO> dirDepthList(
			@RequestParam String path
			, @AuthenticationPrincipal(expression="realUser") EmployeeVO employee
		) {
		
		String empId = employee.getEmpId();
		List<DirStructJsonVO> dirStructList = service.retrieveDirDepthList(empId, path);
		
		return dirStructList;
	}
	
	@PostMapping(value="/fileDownload.do", consumes=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public void downloadFiles(@RequestBody FilePathVO filePath
			, @AuthenticationPrincipal(expression="realUser")EmployeeVO employee
			, HttpServletResponse response) throws IOException {
		String savePath = personalPath + "/" + employee.getEmpId();
		String path = filePath.getPath();
		String fileName = filePath.getFileName();
		if(StringUtils.isNotBlank(path)) {
			savePath += "/" + path;
		}
		byte[] file = null;
		file = ftpUtil.getFileByte(savePath, fileName);
		
		response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
		response.setContentLengthLong(file.length);
		response.setHeader("Content-Disposition", "attatchment;filename=\"" + fileName + "\"");
		
		try (
				OutputStream os = response.getOutputStream();
				InputStream is = new ByteArrayInputStream(file);	
		){
			byte[] buffer = new byte[1024];
			int length = -1;
			while( (length = is.read(buffer, 0, buffer.length)) != -1 ) {
				os.write(buffer, 0, length);
			}
		} catch (IOException e) {
			throw new RuntimeException("stream error : " + e.getMessage());
		}
	}
	
	@PostMapping(value="/createDir.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public boolean createDir(String path, @RequestParam(required=true)String dirName
			, @AuthenticationPrincipal(expression="realUser")EmployeeVO employee) {
		
		String createPath = personalPath + "/" + employee.getEmpId();
		if(StringUtils.isNotBlank(path)) {
			createPath += "/" + path;
		}
		boolean check = ftpUtil.isDirectoryExist(createPath, dirName);
		boolean result = false;
		if(!check) {
			result = ftpUtil.createDirectory(createPath, dirName);
		}
		return result;
	}
	
	@PostMapping(value="/removeFile.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public boolean removeFiles(@RequestParam("path") String path, @RequestParam("fileName[]") String[] fileName
			, @AuthenticationPrincipal(expression="realUser")EmployeeVO employee) {
		
		log.debug("\n\nremoveFile Controller...");
		log.debug("parameter");
		log.debug("path : {}", path);
		log.debug("fileName : {}", fileName[0]);
		String savePath = personalPath + "/" + employee.getEmpId();
		if(StringUtils.isNotBlank(path)) {
			savePath += path;
		}
		
		boolean result = true;
		for(String name : fileName) {
			result = ftpUtil.removeFiles(savePath, name);
			if(!result) {
				break;
			}
		}
		
		return result;
	}
	
	@PostMapping(value="/uploadFile.do")
	@ResponseBody
	public boolean uploadFiles(MultipartFile[] uploadFile, @AuthenticationPrincipal(expression="realUser") EmployeeVO employee
			,String path) {
		
		String savePath = personalPath + "/" + employee.getEmpId();
		if(StringUtils.isNotBlank(path)) {
			savePath += path;
		}
		
		
		for(int i=0;i<uploadFile.length;i++) {
			ftpUtil.uploadToFtp(savePath, uploadFile[i].getOriginalFilename(), uploadFile[i]);
		}
		
		
		return true;
	}
	
}
