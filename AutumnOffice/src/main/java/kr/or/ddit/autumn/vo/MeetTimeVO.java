package kr.or.ddit.autumn.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="metTime")
public class MeetTimeVO {

	@NotNull
	private Integer metTime;
	@NotBlank
	private String metCon;
}
