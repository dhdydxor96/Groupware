package kr.or.ddit.autumn.management.menu.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.board.dao.CommunicationAttatchDAO;
import kr.or.ddit.autumn.management.menu.dao.CommunityManagerDAO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.BoardVO;
import kr.or.ddit.autumn.vo.PostVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommunityManagerServiceImpl implements CommunityManagerService {

	private final CommunityManagerDAO communityDAO;
	private final CommunicationAttatchDAO attatchDAO; 
	
	@Value("#{appInfo.attatchFolder}")
	private Resource attatchFolder;
	
	private File saveFolder;
	
	@PostConstruct
	public void init() throws IOException{
		saveFolder = attatchFolder.getFile();
	}
	
	@Override
	public ServiceResult createCommunity(BoardVO board) {
		int rowcnt = communityDAO.insertCommunity(board);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<BoardVO> retrieveCommunityList(PagingVO<BoardVO> paging) {
		return communityDAO.selectCommunityList(paging);
	}

	@Override
	public ServiceResult modifyNotice(BoardVO board) {
		int rowcnt = communityDAO.updateCommunity(board);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public int retrieveCommunityCount(PagingVO<BoardVO> paging) {
		return communityDAO.selectTotalRecord(paging);
	}

	@Override
	public String searchCode(String code) {
		return communityDAO.searchCode(code);
	}
	
	private int processDeleteAttatches(PostVO post) {
		int rowcnt = 0;
		rowcnt = communityDAO.deleteComment(post);

		List<AttatchVO> attatchList = communityDAO.selectAttatchList(post);
		
		if(attatchList==null || attatchList.isEmpty()) return 0;
		List<String> saveNames = attatchList.stream()
				.map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		rowcnt += attatchDAO.deleteAttatch(post.getPoNo());
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				File deleteFile = new File(saveFolder, attSavename);
				FileUtils.deleteQuietly(deleteFile);
			}
		}
		return rowcnt;
	}
	
	@Transactional
	@Override
	public ServiceResult removeCommunity(String boCode) {
		int rowcnt = 0;
		List<PostVO> poNoList = communityDAO.retrieveChildPost(boCode);
		if(poNoList != null || !poNoList.isEmpty()) {
			for(PostVO post : poNoList) {
				processDeleteAttatches(post);
				communityDAO.deleteChildPost(post);
			}
			rowcnt += communityDAO.deleteCommunity(boCode);
		}else {
			rowcnt += communityDAO.deleteCommunity(boCode);
		}
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	

}
