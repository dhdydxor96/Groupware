package kr.or.ddit.autumn.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString
@EqualsAndHashCode(of = "surqueNo")
public class SurveyQuestionVO {
	private int rnum;
	private Integer surqueNo;
	private Integer surNo;
	private Integer surqueTurn;
	private String surqueType;
	private String surqueContent;
	private String surqueInsdat;
	private String surTitle;
	
	private SurveyVO survey;
	private List<SurveyVO> surveyList;
}
