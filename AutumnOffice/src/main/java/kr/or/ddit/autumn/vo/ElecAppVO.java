package kr.or.ddit.autumn.vo;

import java.io.Serializable;
import java.util.Base64;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="eleNo")
public class ElecAppVO implements Serializable{
	@NotNull
	private Integer eleNo;
	private Integer apfNo;
	private Integer aplNo;
	private String empId;
	private String eleDepnm;
	private String depId;
	private String depNm;
	private String eleTit;
	private String eleUse;
	private String eleCon;
	private String eleCrd;
	private String eleDyn;
	private String eleStart;
	private String eleEnd;
	private byte[] empSign;
	private boolean eleYn;
	private String empNm;
	private String jobNm;
	private Integer bstNo;
	private Integer vacNo;
	
	private AppFormVO appForm;
	private AppStatusVO appStatus;
	private List<AplDetailVO> aplDetailList;
	private List<EleRefVO> eleRefList;
	private List<AttatchVO> attatchList;
	
	public String getBase64Img() {
		if(empSign == null) {
			return null;
		}else {
			String base64Text = Base64.getEncoder().encodeToString(empSign);
			return base64Text;
		}
	}
}
