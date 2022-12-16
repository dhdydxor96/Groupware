package kr.or.ddit.autumn.web.experience.service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.web.vo.ExperienceVO;

public interface ExperienceService {
	public ServiceResult createExperience(ExperienceVO experience);
}
