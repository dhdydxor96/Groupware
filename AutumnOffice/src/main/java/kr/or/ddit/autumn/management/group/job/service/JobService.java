package kr.or.ddit.autumn.management.group.job.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.JobVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface JobService {
	public ServiceResult createJob(JobVO job);
	public JobVO retrieveJob(int jobId);
	public List<JobVO> retrieveJobList(PagingVO<JobVO> pagingVO);
	public int retrieveJobCount(PagingVO<JobVO> pagingVO);
	public ServiceResult modifyJob(JobVO job);
	public int removeJob(JobVO job);
	public List<JobVO> jobList(JobVO job);
	public int idCheck(JobVO job);
}
