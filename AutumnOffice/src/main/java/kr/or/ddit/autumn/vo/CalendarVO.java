package kr.or.ddit.autumn.vo;

import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of ="calNo")
@ToString
public class CalendarVO {
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer calNo;
	@NotBlank(groups = InsertGroup.class)
	private String depId;
	@NotBlank(groups = InsertGroup.class)
	private String empId;
	@NotBlank(groups = InsertGroup.class)
	private String calTit;
	private String calCon;
	@NotBlank(groups = InsertGroup.class)
	private String calStart;
	@NotBlank(groups = InsertGroup.class)
	private String calEnd;
	private String calSta;
	private String calColor;
	@NotNull(groups = InsertGroup.class)
	private Integer calAllday;
	
	private List<DepartmentVO> departmentList;

}
