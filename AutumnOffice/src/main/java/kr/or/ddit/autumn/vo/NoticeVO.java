package kr.or.ddit.autumn.vo;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="nocNo")
public class NoticeVO {
	
	private int rnum;
	
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer nocNo;
	private String comCode;
	@NotBlank
	private String nocTit;
	private String nocCon;
	private String nocDate;
	private String nocVie;
	
	private transient List<MultipartFile> nocFiles;
	public void setNocFiles(List<MultipartFile> nocFiles) {
		if(nocFiles==null || nocFiles.isEmpty()) return;
		this.nocFiles = nocFiles;
		this.attatchList 
		= new ArrayList<>();
		for(MultipartFile file : nocFiles) {
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
