package kr.or.ddit.autumn.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString
@EqualsAndHashCode(of="surarcNo")
public class SurveyArticleVO {
	private int rnum;
	private Integer surarcNo;
	private Integer surqueNo;
	private Integer surarcTurn;
	private String surarcContent;
	private String surarcInsdat;
	private String surqueContent;
	
	private SurveyQuestionVO surveyQuestion;
	private List<SurveyQuestionVO> surveyQuestionList;
}
