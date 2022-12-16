package kr.or.ddit.autumn.groupware.approval.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.autumn.vo.AttatchVO;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ApprovalFormVO {
	private Integer eleNo;
	private Integer aplNo;
	private String empId;
	@NotNull
	private Integer apfNo;
	private String eleTit;
	@NotBlank
	private String eleUse;
	@NotBlank
	private String depId;
	@NotBlank
	private String appContent;
	private boolean eleYn;
	private String eleStart;
	private String eleEnd;
	
	@NotEmpty
	private List<String> appId;
	private List<String> refId;
	
	@JsonIgnore
	private transient List<MultipartFile> attFile;
	public void setAttFile(List<MultipartFile> attFile) {
		if(attFile==null || attFile.isEmpty()) return;
		this.attFile = attFile;
		this.attatchList 
		= new ArrayList<>();
		for(MultipartFile file : attFile) {
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
