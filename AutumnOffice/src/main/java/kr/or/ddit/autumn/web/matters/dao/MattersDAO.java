package kr.or.ddit.autumn.web.matters.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.web.vo.MattersVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface MattersDAO {
	public int insertMatters(MattersVO matters);
	public MattersVO selectMatters(@Param("matNo") int matNo);
	public List<MattersVO> selectmattersList(PagingVO<MattersVO> pagingVO);
	public int updateMatters(MattersVO matters);
	public int deleteMatters(MattersVO matters);
	public int selectTotalRecord(PagingVO<MattersVO> pagingVO);
}
