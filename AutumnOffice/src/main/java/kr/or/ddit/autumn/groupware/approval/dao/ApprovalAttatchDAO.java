package kr.or.ddit.autumn.groupware.approval.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.groupware.approval.vo.ApprovalFormVO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.web.vo.MattersVO;

@Mapper
public interface ApprovalAttatchDAO {
	public int insertAttatches(ApprovalFormVO approvalForm);
	public AttatchVO selectAttatch(int attNo);
	public List<AttatchVO> selectAttatchList(@Param("eleNo") int eleNo);
	public int deleteAttatches(@Param("delAttNos") int[] delAttNos);
	public int deleteAttatch(int attNo);
}
