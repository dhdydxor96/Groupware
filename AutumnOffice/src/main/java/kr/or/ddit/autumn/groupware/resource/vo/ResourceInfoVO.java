package kr.or.ddit.autumn.groupware.resource.vo;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.MeetRoomVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="meetNo")
public class ResourceInfoVO {
	@NotNull
	private Integer meetNo;
	private String meiPer;
	private String meiBeam;
	private String meiBod;
	private String meiPla;
	private String meiItem;
	private String meiScr;
	
	private String meetNm;
	private String comCode;
	
	private AttatchVO attatchVO;
	
	private MeetRoomVO meetRoom;
	
	@JsonIgnore
	private transient List<MultipartFile> meetFiles;
	public void setMeetFiles(List<MultipartFile> meetFiles) {
		if(meetFiles==null || meetFiles.isEmpty()) return;
		this.meetFiles = meetFiles;
		this.attatchList 
		= new ArrayList<>();
		for(MultipartFile file : meetFiles) {
			if(file.isEmpty()) continue;
			attatchList.add(new AttatchVO(file));
		}
	}
	@JsonIgnore
	private transient List<AttatchVO> attatchList;
	@JsonIgnore
	private transient int[] delMeetNos;
	
	AttatchVO attatch;
}
