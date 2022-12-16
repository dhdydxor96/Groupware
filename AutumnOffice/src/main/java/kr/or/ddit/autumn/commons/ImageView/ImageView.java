package kr.or.ddit.autumn.commons.ImageView;



import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.ddit.autumn.commons.ftp.FtpPool;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class ImageView extends AbstractView{

	@Inject
	private FtpUtil ftpUtil;
	@Value("#{ftpInfo.savePath}")
	private String savePath;

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		AttatchVO attatch =  (AttatchVO) model.get("attatch");
		
		
		String originName = attatch.getAttFnm();
		
		originName = URLEncoder.encode(originName, "UTF-8");
		
		originName = originName.replaceAll("\\+", " "); 
		
		String saveName = attatch.getAttSnm(); 
		
		response.setContentType("image/*"); 
		response.setContentLengthLong(attatch.getAttFis());
		
		log.info("savePath : {}", savePath);
		boolean flag = ftpUtil.isFileExist(savePath, saveName);
		byte[] file = null;
		if(flag) {
			file = ftpUtil.getFileByte(savePath, saveName);
		}
		
		try (
			InputStream is = new ByteArrayInputStream(file);
			OutputStream os = response.getOutputStream();
		){
			byte[] buffer = new byte[1024];
			int length = -1;
			while( (length = is.read(buffer, 0, buffer.length)) != -1 ) {
				os.write(buffer, 0, length);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
