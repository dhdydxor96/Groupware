package kr.or.ddit.autumn.vo;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@EqualsAndHashCode(of="apdNo")
public class AplDetailVO {
	private Integer apdNo;
	@NotNull
	private Integer aplNo;
	private String empId;
	private String apdOrd;
	private String aplDate;
	private String aplSta;
	private String aplTurn;
	private boolean decSta;
	private byte[] empSign;
	private MultipartFile empSignImg;
	
	// 결재 순서에 따라 state 변경
	// 2[결재완료], 1[결재대기], 0[결재예정], -1[반려]
	private String appState;
	private EmployeeVO employee;
	
	public void setAplTurn(String aplTurn) {
		this.aplTurn = aplTurn;
		if(StringUtils.trim(aplTurn).equals("2")) {
			this.appState = "결재완료";
		}else if(StringUtils.trim(aplTurn).equals("1")) {
			this.appState = "결재대기";
		}else if(StringUtils.trim(aplTurn).equals("0")) {
			this.appState = "결재예정";
		}else {
			this.appState = "반려";
		}
	}
	
	public void setEmpSignImg(MultipartFile empSignImg) throws IOException {
		if(empSignImg == null || empSignImg.isEmpty()) {
			return;
		}
		this.empSignImg = empSignImg;
		this.empSign = empSignImg.getBytes();
	}
	
	public String getBase64Img() {
		if(empSign == null) {
			return null;
		}else {
			String base64Text = Base64.getEncoder().encodeToString(empSign);
			log.info("base64 encoded text : {}", base64Text);
			return base64Text;
		}
	}
}
