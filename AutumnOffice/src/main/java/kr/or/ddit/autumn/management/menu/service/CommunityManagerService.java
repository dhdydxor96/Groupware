package kr.or.ddit.autumn.management.menu.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.BoardVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface CommunityManagerService {
	public ServiceResult createCommunity(BoardVO board);
	public List<BoardVO> retrieveCommunityList(PagingVO<BoardVO> paging);
	public ServiceResult modifyNotice(BoardVO board);
	public int retrieveCommunityCount(PagingVO<BoardVO> paging);
	public String searchCode(String code);
	public ServiceResult removeCommunity(String boCode);
}
