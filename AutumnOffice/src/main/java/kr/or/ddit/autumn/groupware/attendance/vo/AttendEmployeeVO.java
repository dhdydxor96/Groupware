package kr.or.ddit.autumn.groupware.attendance.vo;

import java.util.Set;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmpPfileVO;
import kr.or.ddit.autumn.vo.EmpStcodeVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.JobVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="empId")
@ToString(exclude={"empPass"})
public class AttendEmployeeVO {
	@NotBlank
	private String empId;
	@NotBlank
	private String comCode;
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
	@NotBlank
	private String empPh;
	private String empAddr;
	@NotBlank
	private String empHid;
	private String empEnd;
	private String empSign;
	private String empSta;
	
	Set<String> empRoles;
	EmpPfileVO empPfile;
	AttatchVO attatch;
	DepartmentVO department;
	JobVO job;
	EmpStcodeVO empStcode;
	
	private String jobNm;
	private String depNm;
	private String powRole;
	private String rNum;
	
}
