package kr.or.ddit.autumn.web.matters.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

/**
 *	문의사항 이미지 업로드 컨트롤러 
 *
 */

@Slf4j
@Controller
public class MattersImageUploadController {
	@Inject
	private ServletContext application;
	
	@Value("#{appInfo.imageFolderURL}")
	private String imageFolderURL;
	
	@Value("#{appInfo.imageFolderURL}")
	private Resource imageFolderRes;
	private File saveFolder;
	
	@PostConstruct
	public void init() throws IOException {
		saveFolder = imageFolderRes.getFile();
		if(!saveFolder.exists())
			saveFolder.mkdirs();
		log.info("image folder url : {}", imageFolderURL);
		log.info("로딩된 saveFolder : {}", saveFolder.getCanonicalPath());
	}
	
	@PostMapping(value="/web/matters/imageUpload.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> imageUpload(
		@RequestPart(required=true) MultipartFile upload
	) throws IOException{
		Map<String, Object> target = new HashMap<>();
		if(!upload.isEmpty()) {
			String saveName = UUID.randomUUID().toString();
			try(
				InputStream is = upload.getInputStream();
			){
				File saveFile = new File(saveFolder, saveName);
				FileUtils.copyInputStreamToFile(is, saveFile);
				String fileName = upload.getOriginalFilename();
				int uploaded = 1;
				String url = String.format("%s/%s/%s"
						,application.getContextPath(), imageFolderURL, saveName); 
				target.put("fileName", fileName);
				target.put("uploaded", uploaded);
				target.put("url", url);
			}
			
		}else {
			Map<String, Object> error = new HashMap<>();
			target.put("error", error);
			error.put("number", 400);
			error.put("message", "업로드된 이미지가 비어있음.");
		}
		return target;
	}
}
