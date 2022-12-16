package kr.or.ddit.autumn.management.menu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.RuleVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface DocManageMenualDao {

	public int insertRule(RuleVO rule);
	public RuleVO selectRule(@Param("rulNo")int rulNo);
	public List<RuleVO> selectRuleList(PagingVO<RuleVO> pagingVO);
	public int updateRule(RuleVO rule);
	public int deleteRule(RuleVO rule);
	public int selectTotalRecord(PagingVO<RuleVO> pagingVO);	
}
