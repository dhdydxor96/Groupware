package kr.or.ddit.autumn.vo;

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
import lombok.EqualsAndHashCode;

@Data@EqualsAndHashCode(of="poNo")
public class PostVO {
	
	private int rnum;
	
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer poNo;
	@NotBlank(groups= InsertGroup.class)
	private String boCode;
	private String empId;
	private String poTit;
	private String poCon;
	private Integer poVie;
	private String poCrd;
	private String poUpd;
	private String poPin;
	
	private EmployeeVO emp;
	
	private String boType;
	
	@JsonIgnore
	private List<BoardVO> boardList;
	
	@JsonIgnore
	private List<CommentsVO> commentList;
	
	@JsonIgnore
	private transient List<MultipartFile> poFiles;
	public void setPoFiles(List<MultipartFile> poFiles) {
		if(poFiles==null || poFiles.isEmpty()) return;
		this.poFiles = poFiles;
		this.attatchList 
		= new ArrayList<>();
		for(MultipartFile file : poFiles) {
			if(file.isEmpty()) continue;
			attatchList.add(new AttatchVO(file));
		}
	}
    @JsonIgnore
    private transient  int startNo;
	@JsonIgnore
    private transient List<AttatchVO> attatchList;
	@JsonIgnore
	private transient int[] delAttNos;
}
