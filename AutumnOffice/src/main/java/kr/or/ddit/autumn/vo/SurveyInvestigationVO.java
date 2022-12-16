package kr.or.ddit.autumn.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString
@EqualsAndHashCode(of="surinvNo")
public class SurveyInvestigationVO {
	private int rnum;
	private Integer surinvNo;
	private Integer surNo;
	private Integer surqueNo;
	private Integer surarcNo;
	private String surinvAnswer;
	private String surinvType;
	private String surinvInsdat;
	private String empNm;
	private String surTitle;
	private String surqueContent;
	private String surarcContent;
	private Integer surarcTurn;
	private String surSdate;
	private String surEdate;
	private String surinvFirst;
	private String surinvSecond;
	private String surinvThird;
	private String surinvFour;
	private String surinvFive;
	private String surPurpose;
	private String surGuide;
	private String empId;
	private Integer surState;
	
	
	
	private SurveyVO survey;
	private List<SurveyVO> surveyList;
	
	private SurveyQuestionVO surveyQuestion;
	private List<SurveyQuestionVO> surveyQuestionList;
	
	private SurveyArticleVO surveyArticle;
	private List<SurveyArticleVO> surveyArticleList;
	
	private SurveyResponseVO surveyResponse;
	private List<SurveyResponseVO> surveyResponseList;
	
	private EmployeeVO employee;
	private List<EmployeeVO> employeeList;
}
