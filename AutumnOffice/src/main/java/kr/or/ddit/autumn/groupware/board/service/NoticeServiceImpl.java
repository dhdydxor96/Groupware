package kr.or.ddit.autumn.groupware.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.groupware.board.dao.NoticeDAO;
import kr.or.ddit.autumn.management.menu.dao.NoticeManagerAttatchDAO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

	private final NoticeDAO noticeDAO;
	private final NoticeManagerAttatchDAO attatchDAO;
	
	@Override
	public List<NoticeVO> retrieveNoticeList(PagingVO<NoticeVO> pagingVO) {
		return noticeDAO.selectNoticeList(pagingVO);
	}

	@Override
	public int retrieveNoticeCount(PagingVO<NoticeVO> pagingVO) {
		return noticeDAO.selectTotalRecord(pagingVO);
	}

	@Override
	public NoticeVO retrieveNotice(int nocNo) {
		noticeDAO.incrementNoHit(nocNo);
		NoticeVO notice = noticeDAO.selectNotice(nocNo);
		if(notice == null)
			throw new RuntimeException(String.format("%d 글번호의 글이 없음.", nocNo));
		return notice;
	}
	
	@Override
	public AttatchVO retrieveAttatch(int attNo) {
		AttatchVO attatch = attatchDAO.selectAttatch(attNo);
		if(attatch == null)
			throw new RuntimeException("해당 파일 없음.");
		return attatch;
	}

}
