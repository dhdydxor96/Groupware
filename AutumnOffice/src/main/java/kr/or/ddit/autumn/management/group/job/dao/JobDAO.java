package kr.or.ddit.autumn.management.group.job.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.JobVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface JobDAO {
	public int insertJob(JobVO job);
	public int selectTotalRecord(PagingVO<JobVO> pagingVO);
	public List<JobVO> selectJobList(PagingVO<JobVO> pagingVO);
	public JobVO selectJob(@Param("jobId") int jobId);
	public int updateJob(JobVO job);
	public int deleteJob(JobVO job);
	public int idCheck(JobVO job);
	public List<JobVO> jobList(JobVO job);
}
