package kr.or.ddit.autumn.vo;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
@Data
@EqualsAndHashCode(of="popupNo")
public class PopUpVO {
	
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer popupNo;
	private String popupTitle;
	private String popupContent;
	private String comCode;
	@NotNull
	private int popupSta;
	
	private MultipartFile popImage;
	
	private transient AttatchVO attatch;
	
	public void setPopImage(MultipartFile popImage) {
		if(popImage==null || popImage.isEmpty()) return;
		this.popImage = popImage;
		this.attatch = new AttatchVO(popImage);
	}
	
	@JsonIgnore
	private List<Integer> popupNoList;

}
