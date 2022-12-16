package kr.or.ddit.autumn.vo;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.inject.Inject;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Data
@EqualsAndHashCode(of="attNo")
@ToString(exclude="adaptee")
@NoArgsConstructor // 클라이언트에서 넘어온 데이터랑 디비에서 넘어온 데이터를 받기 위하여 사용
public class AttatchVO {
	
	private MultipartFile adaptee;
	
	public AttatchVO(MultipartFile adaptee) {
		super();
		this.adaptee = adaptee;
		this.attFnm = adaptee.getOriginalFilename();
		this.attSnm = UUID.randomUUID().toString();
		this.attMime = adaptee.getContentType();
		this.attFis = adaptee.getSize();
		this.attFas = FileUtils.byteCountToDisplaySize(attFis);
	}
	
	@NotNull
	private Integer attNo;
	private Integer arcNo;
	private Integer matNo;
	private Integer advNo;
	private Integer repNo;
	private Integer rulNo;
	private Integer docNo;
	private Integer meetNo;
	private Integer poNo;
	private String empId;
	private Integer eleNo;
	private Integer mailNo;
	private String comCode;
	private int popupNo;
	
	@NotBlank
	private String attFnm;
	@NotBlank
	private String attSnm;
	private String attMime;
	@NotNull
	private Long attFis;
	@NotBlank
	private String attFas;
	private Integer attDow;
	
	@JsonIgnore
	private transient  int startNo;
	
	public void saveTo(File saveFolder) throws IllegalStateException, IOException {
		if(adaptee==null) return;
		
		File saveFile = new File(saveFolder, attSnm);
		adaptee.transferTo(saveFile);
	}
	
}
