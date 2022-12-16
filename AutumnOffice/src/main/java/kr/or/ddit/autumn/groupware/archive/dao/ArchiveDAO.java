package kr.or.ddit.autumn.groupware.archive.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;

@Mapper
public interface ArchiveDAO {
	
	public AttatchVO selectAttatch(@Param("attNo") int attNo);
	public List<AttatchVO> selectAttatchList(int number, String category);
}
