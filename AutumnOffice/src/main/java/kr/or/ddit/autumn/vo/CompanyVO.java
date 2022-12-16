package kr.or.ddit.autumn.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="comCode")
public class CompanyVO implements Serializable{
	@NotBlank
	private String comCode;
	@NotBlank
	private String comId;
	@NotBlank
	@JsonIgnore
	private transient String comPass;
	@NotBlank
	private String comNm;
	@NotBlank
	private String comPh;
	@NotBlank
	private String comMail;
	@NotBlank
	private String comCnm;
	@NotBlank
	private String comCeo;
	@NotBlank
	private String comTel;
	@NotBlank
	@JsonIgnore
	private transient String comBrn;
	@NotBlank
	private String comAddr;
	@NotBlank
	private String comDiv;
	
	@JsonIgnore
	private transient List<MultipartFile> comFiles;
	public void setComFiles(List<MultipartFile> comFiles) {
		if(comFiles==null || comFiles.isEmpty()) return;
		this.comFiles = comFiles;
		this.attatchList 
		= new ArrayList<>();
		for(MultipartFile file : comFiles) {
			if(file.isEmpty()) continue;
			attatchList.add(new AttatchVO(file));
		}
	}
	
	@JsonIgnore
	private transient List<AttatchVO> attatchList;
	AttatchVO attatch;
}
