package kr.or.ddit.autumn.management.menu.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.vo.PostVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface NoticeManagerService {
	public ServiceResult createNoticeBymanager(NoticeVO notice);
	public NoticeVO retrieveNotice(int nocNo);
	public NoticeVO retrieveNoticeForEdit(int nocNo);
	public List<NoticeVO> retrieveNoticeList(PagingVO<NoticeVO> paging);
	public int retrieveNoticeCount(PagingVO<NoticeVO> paging);
	public ServiceResult modifyNotice(NoticeVO notice);
	public ServiceResult removeNotice(NoticeVO notice);
	public ServiceResult removeNotices(int nocNo);
	public AttatchVO retrieveAttatch(@Param("attNo") int attNo);
}
