package kr.or.ddit.autumn.web.matters.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.web.vo.MattersVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface MattersService {
	public ServiceResult creaeteMatters(MattersVO matters);
	public MattersVO retrieveMatters(int matNo);
	public List<MattersVO> retrieveMattersList(PagingVO<MattersVO> pagingVO);
	public int retrieveMattersCount(PagingVO<MattersVO> pagingVO);
	public ServiceResult modifyMatters(MattersVO matters);
	public ServiceResult removeMatters(MattersVO matters);
	public AttatchVO retrieveAttatch(int attNo);
}
