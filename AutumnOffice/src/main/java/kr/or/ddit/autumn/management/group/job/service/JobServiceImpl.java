package kr.or.ddit.autumn.management.group.job.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.management.group.job.dao.JobDAO;
import kr.or.ddit.autumn.vo.JobVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JobServiceImpl implements JobService {
	private final JobDAO jobdao;

	@Override
	public ServiceResult createJob(JobVO job) {
		int rowcnt = jobdao.insertJob(job);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public JobVO retrieveJob(int jobId) {
		JobVO job = jobdao.selectJob(jobId);
		if(job == null)
			throw new RuntimeException(String.format("%d 직위가 없음.", jobId));
		return job;
	}

	@Override
	public List<JobVO> retrieveJobList(PagingVO<JobVO> pagingVO) {
		return jobdao.selectJobList(pagingVO);
	}

	@Override
	public int retrieveJobCount(PagingVO<JobVO> pagingVO) {
		return jobdao.selectTotalRecord(pagingVO);
	}

	@Override
	public ServiceResult modifyJob(JobVO job) {
		retrieveJob(job.getJobId());
		int rowcnt = jobdao.updateJob(job);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public int removeJob(JobVO job) {
		return jobdao.deleteJob(job);
	}

	@Override
	public List<JobVO> jobList(JobVO job) {
		return jobdao.jobList(job);
	}

	@Override
	public int idCheck(JobVO job) {
		int result = jobdao.idCheck(job);
		return result;
	}
	
}
