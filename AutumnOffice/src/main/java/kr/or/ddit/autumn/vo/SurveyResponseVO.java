package kr.or.ddit.autumn.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString
@EqualsAndHashCode(of="surresNo")
public class SurveyResponseVO {
	private int rnum;
	
	private Integer surresNo;
	private Integer surinvNo;
	private String empId;
	private String empNm;
	private Integer surresChofirst;
	private Integer surresChosecond;
	private Integer surresChothird;
	private Integer surresChofour;
	private Integer surresChofive;
	private String surresEssay;
	private String surresInsdat;
	private String surinvFirst;
	private String surinvSecond;
	private String surinvThird;
	private String surinvFour;
	private String surinvFive;
	private String surTitle;
	private String surqueContent;
	private String surarcContent;
	private Integer surarcTurn;
	private String surSdate;
	private String surEdate;
	private String surPurpose;
	private String surGuide;
	
	private SurveyVO survey;
	private List<SurveyVO> surveyList;
	
	private SurveyQuestionVO surveyQuestion;
	private List<SurveyQuestionVO> surveyQuestionList;
	
	private SurveyArticleVO surveyArticle;
	private List<SurveyArticleVO> surveyArticleList;
	
	private SurveyInvestigationVO SurveyInvestigation;
	private List<SurveyInvestigationVO> SurveyInvestigationList;
}
