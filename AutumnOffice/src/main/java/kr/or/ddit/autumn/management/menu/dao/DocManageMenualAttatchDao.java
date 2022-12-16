package kr.or.ddit.autumn.management.menu.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.RuleVO;

@Mapper
public interface DocManageMenualAttatchDao {
	
	public int insertAttatches(RuleVO rule);
	public AttatchVO selectAttatch(int rulNo);
	public int deleteAttatches(@Param("delAttNos")int [] delAttNos);
	public int deleteAttatch(int rulNo);
	public int selectRulNo(@Param("comCode")String comCode);
}
