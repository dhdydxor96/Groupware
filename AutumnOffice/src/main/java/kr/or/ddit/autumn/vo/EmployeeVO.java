package kr.or.ddit.autumn.vo;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@EqualsAndHashCode(of="empId")
@ToString(exclude={"empPass"})
public class EmployeeVO implements Serializable{
	private int rnum;
	@NotBlank
	private String empId;
	@NotBlank
	private String comCode;
	private String comCnm;
	@NotBlank
	private String depId;
	@NotBlank
	private Integer jobId;
	@NotBlank
	@JsonIgnore
	private transient String empPass;
	@NotBlank
	private String empNm;
	@NotBlank
	private String empBid;
	@Email
	@NotBlank
	private String empMail;
	private String empMpass;
	@NotBlank
	private String empPh;
	private String empAddr;
	@NotBlank
	private String empHid;
	private String empEnd;
	private byte[] empSign;
	private MultipartFile empSignImg;
	private String empSta;
	private byte[] empImg;
	private String depCrd;
	private String jobCrd;
	private String depNm;
	private String jobNm;
	private Integer powNo;
	private String powRole;
	
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
	
	@JsonIgnore
	private transient List<MultipartFile> empFiles;
	public void setEmpFiles(List<MultipartFile> empFiles) {
		if(empFiles==null || empFiles.isEmpty()) return;
		this.empFiles = empFiles;
		this.attatchList 
		= new ArrayList<>();
		for(MultipartFile file : empFiles) {
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
	
	Set<String> empRoles;
	EmpPfileVO empPfile;
	AttatchVO attatch;
	DepartmentVO department;
	JobVO job;
	EmpStcodeVO empStcode;
	PowerVO power;
	private Integer empCount;
	
	@JsonIgnore
	private transient List<DepartmentVO> departmentList;
	@JsonIgnore
	private transient List<JobVO> jobList;
	
	private List<PowerVO> powList;
	
}
