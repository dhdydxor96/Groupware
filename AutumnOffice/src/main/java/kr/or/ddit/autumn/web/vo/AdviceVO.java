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
@EqualsAndHashCode(of="advNo")
@ToString(exclude= {"advPass", "advCon","advFiles", "attatchList"})
public class AdviceVO implements Serializable {
	
	private int rnum;
	
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer advNo;
	@NotBlank
	private String advTit;
	@NotBlank(groups=InsertGroup.class)
	private String advNm;
	@NotBlank(groups= {Default.class, DeleteGroup.class})
	@JsonIgnore
	private String advPass;
	private String advPh;
	private String advCon;
	private String advDate;
	private String advCom;
	private String advCod;
	private String advAcn;
	private String advAnd;
	
	@JsonIgnore
	private transient List<MultipartFile> advFiles;
	public void setAdvFiles(List<MultipartFile> advFiles) {
		if(advFiles==null || advFiles.isEmpty()) return;
		this.advFiles = advFiles;
		this.attatchList 
		= new ArrayList<>();
		for(MultipartFile file : advFiles) {
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
