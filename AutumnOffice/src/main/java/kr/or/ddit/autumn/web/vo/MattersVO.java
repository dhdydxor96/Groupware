package kr.or.ddit.autumn.web.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.groups.Default;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import kr.or.ddit.autumn.vo.AttatchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="matNo")
@ToString(exclude= {"matPass","matCon", "matFiles", "attatchList"})
public class MattersVO implements Serializable {
	
	private int rnum;
	
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer matNo;
	@NotBlank
	private String matTit;
	@NotBlank(groups=InsertGroup.class)
	private String matNm;
	@NotBlank(groups= {Default.class, DeleteGroup.class})
	@JsonIgnore
	private transient String matPass;
	private String matCon;
	private String matDate;
	private String matCom;
	private String matCod;
	private String matAcn;
	private String matAnd;
	
	@JsonIgnore
	private transient List<MultipartFile> matFiles;
	public void setMatFiles(List<MultipartFile> matFiles) {
		if(matFiles==null || matFiles.isEmpty()) return;
		this.matFiles = matFiles;
		this.attatchList 
		= new ArrayList<>();
		for(MultipartFile file : matFiles) {
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
	
	@JsonIgnore
	private transient List<MattersReplyVO> replyList;
}
