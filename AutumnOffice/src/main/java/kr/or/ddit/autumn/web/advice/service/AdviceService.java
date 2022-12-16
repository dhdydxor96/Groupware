package kr.or.ddit.autumn.web.advice.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.web.vo.AdviceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface AdviceService {
	public ServiceResult createAdvice(AdviceVO advice);
	public AdviceVO retrieveAdvice(int advNo);
	public List<AdviceVO> retrieveAdviceList(PagingVO<AdviceVO> pagingVO);
	public int retrieveAdviceCount(PagingVO<AdviceVO> pagingVO);
	public ServiceResult modifyAdvice(AdviceVO advice);
	public ServiceResult removeAdvice(AdviceVO advice);
	public AttatchVO retrieveAttatch(int attNo);
}
