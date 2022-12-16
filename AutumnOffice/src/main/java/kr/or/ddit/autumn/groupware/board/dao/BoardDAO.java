package kr.or.ddit.autumn.groupware.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.BoardVO;

@Mapper
public interface BoardDAO {
	public List<BoardVO> selectCategory(@Param("comCode") String comCode);
	public String selectNoticeNumber(@Param("comCode") String comCode);
}
