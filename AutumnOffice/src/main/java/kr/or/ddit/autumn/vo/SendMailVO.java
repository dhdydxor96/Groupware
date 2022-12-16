package kr.or.ddit.autumn.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import lombok.Data;

@Data
public class SendMailVO {
	@NotNull(groups=DeleteGroup.class)
	private Integer mailNo;
	@NotBlank(groups=InsertGroup.class)
	private String toAddress;
    private String title;
    private String content;
    private String empId;
    private String sendDate;
    
   
    
    
   
    private List<MultipartFile> files;
    
	public void setFiles(List<MultipartFile> files) {
		if(files==null || files.isEmpty()) return;
		this.files = files;
		this.attatchList = new ArrayList<>();
		for(MultipartFile file : files) {
			if(file.isEmpty()) continue;
			attatchList.add(new AttatchVO(file));
		}
	}
	
	private int startNo;
	
    private List<AttatchVO> attatchList; 
 
}
