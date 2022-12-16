package kr.or.ddit.autumn.web.experience.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.web.vo.ExperienceVO;

@Mapper
public interface ExperienceDAO {
	public int insertExperience(ExperienceVO experience);
}
