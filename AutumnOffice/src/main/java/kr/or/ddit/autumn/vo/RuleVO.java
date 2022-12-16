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
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import lombok.Data;

@Data
public class RuleVO implements Serializable{

	private int rnum;
	
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer rulNo;
	private String comCode;
	@NotBlank(groups=InsertGroup.class)
	private String rulTit;
	private String rulCon;
	private String rulDate;
	
	@JsonIgnore
	private transient List<MultipartFile> rulFiles;
	public void setRulFiles(List<MultipartFile> rulFiles) {
		if(rulFiles==null || rulFiles.isEmpty()) return;
		this.rulFiles = rulFiles;
		this.attatchList 
		= new ArrayList<>();
		for(MultipartFile file : rulFiles) {
			if(file.isEmpty()) continue;
			attatchList.add(new AttatchVO(file));
		}
	}
	@JsonIgnore
	private transient int startNo;
	@JsonIgnore
	private transient List<AttatchVO> attatchList;
	@JsonIgnore
	private transient int[] delAttNos;
}
