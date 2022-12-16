package kr.or.ddit.autumn.commons.notify.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.NotifyVO;


@Mapper
public interface NotifyDAO {

	//알림인서트
	public int insertNotify(NotifyVO notify);

	//상세 알림검색
	public NotifyVO selectNotify(Integer notNo);
	
	//알림 리스트
	public List<NotifyVO> selectNotifyList(String empId);
	
	//알림 수신 업데이트
	public int updateNotify(NotifyVO notify);
	
	//알림 모두 읽음상태만들기
	public int updateAllNotify(String empId);

	//알림하나삭제
	public int deleteNotify(@Param("notNo") Integer notNo);
	
	//알림전부삭제
	public int deleteAllNotify(String empId);
}
