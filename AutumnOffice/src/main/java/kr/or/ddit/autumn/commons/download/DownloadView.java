package kr.or.ddit.autumn.commons.download;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.vo.AttatchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class DownloadView extends AbstractView {
	
	@Inject
	private FtpUtil ftpUtil;
	@Value("#{ftpInfo.savePath}")
	private String savePath;
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		AttatchVO attatch = (AttatchVO) model.get("attatch");
		String fileName = attatch.getAttFnm();
		fileName = URLEncoder.encode(fileName, "UTF-8");
		fileName = fileName.replaceAll("\\+", " ");
		String saveName = attatch.getAttSnm();
		
		response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
		response.setContentLengthLong(attatch.getAttFis());
		response.setHeader("Content-Disposition", "attatchment;filename=\"" + fileName + "\"");
		
		byte[] downloadFile = ftpUtil.getFileByte(savePath, saveName);
		
		if(downloadFile != null) {
			try(
				OutputStream os = response.getOutputStream();
				InputStream is = new ByteArrayInputStream(downloadFile);
			){
				byte[] buffer = new byte[1024];
				int length = -1;
				while( (length = is.read(buffer, 0, buffer.length)) != -1 ) {
					os.write(buffer, 0, length);
				}
			}catch(Exception e) {
				throw new RuntimeException("stream error(no file binary data) : "+e.getMessage());
			}
		}
	}
}
