package kr.or.ddit.autumn.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class BusTripVO implements Serializable{
	private Integer bstNo;
	private Integer eleNo;
	private String bstStart;
	private String bstEnd;
}
