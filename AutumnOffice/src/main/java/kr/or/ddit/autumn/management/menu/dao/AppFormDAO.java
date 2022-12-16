package kr.or.ddit.autumn.management.menu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.AppFormVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface AppFormDAO {
	public int insertAppForm(AppFormVO appForm);
	public int selectTotalRecord(PagingVO<AppFormVO> pagingVO);
	public List<AppFormVO> selectAppFormList(PagingVO<AppFormVO> pagingVO);
	public int deleteAppForm(AppFormVO appForm);
}
