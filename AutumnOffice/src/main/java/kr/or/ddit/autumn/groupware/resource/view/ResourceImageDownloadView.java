package kr.or.ddit.autumn.groupware.resource.view;

import java.io.File;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.ddit.autumn.vo.AttatchVO;



public class ResourceImageDownloadView extends AbstractView  {

	// boardServiceImpl 참고
	@Value("#{appInfo.attatchFolder}")
	private File saveFolder;

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		
		AttatchVO attatch =  (AttatchVO) model.get("attatch");
		
		
		String originName = attatch.getAttFnm();
		
		originName = URLEncoder.encode(originName, "UTF-8");
		
		originName = originName.replaceAll("\\+", " "); 
		
		String saveName = attatch.getAttSnm(); 
		
		File downloadFile = new File(saveFolder,saveName );
		
		response.setContentType("image/*"); 
		response.setContentLengthLong(attatch.getAttFis()); 

		byte[] fileByte = FileUtils.readFileToByteArray(downloadFile);
		
		response.getOutputStream().write(fileByte);
		
	}


}
