package kr.or.ddit.autumn.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of ="notNo")
@ToString
public class NotifyVO implements Serializable{
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer notNo;
	private String empId;
	private String sendempId;
	private String notName;
	private String notCrd;
	private String notCon;
	private Integer notType;
	private String notYn;
	private String notUrl;

}
