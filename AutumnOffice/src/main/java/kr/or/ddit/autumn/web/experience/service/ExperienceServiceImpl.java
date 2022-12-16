package kr.or.ddit.autumn.web.experience.service;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.web.experience.dao.ExperienceDAO;
import kr.or.ddit.autumn.web.vo.ExperienceVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ExperienceServiceImpl implements ExperienceService {
	
	private final ExperienceDAO expDAO;
	
	@Override
	public ServiceResult createExperience(ExperienceVO experience) {
		ServiceResult result = null;
		int rowcnt = expDAO.insertExperience(experience);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

}
