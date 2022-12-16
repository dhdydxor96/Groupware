package kr.or.ddit.autumn.groupware.board.service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.groupware.board.dao.CommunicationAttatchDAO;
import kr.or.ddit.autumn.groupware.board.dao.CommunicationDAO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.PostVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CommunicationServiceImpl implements CommunicationService {
	
	private final CommunicationDAO commuDAO;
	private final CommunicationAttatchDAO attatchDAO;
	
	@Inject
	private FtpUtil ftpUtil; 
	
	@Value("#{ftpInfo.savePath}")
	private String savePath;
	
	private int processAttatchList(PostVO post) {
		int rowcnt = 0;
		List<AttatchVO> attatchList = post.getAttatchList();
		if(attatchList!=null && !attatchList.isEmpty()) {
			rowcnt = attatchDAO.insertAttatches(post);
			for(AttatchVO attatch : attatchList) {
				ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee());
			}
		}
		return rowcnt;
	}
	
	@Override
	public ServiceResult createPost(PostVO post) {
		int rowcnt = commuDAO.insertPost(post);
		rowcnt += processAttatchList(post);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public PostVO retrievePost(int poNo) {
		commuDAO.incrementPoHit(poNo);
		PostVO post = commuDAO.selectPost(poNo);
		if(post == null)
			throw new RuntimeException(String.format("%d 글번호의 글이 없음.", poNo));
		post.setAttatchList(commuDAO.selectAttatchList(post));
		post.setCommentList(commuDAO.selectCommentList(post));
		log.info("@@@@@@@@@@@@@@@@@@@@@@ 1111111 " + post.getCommentList().toString());
		log.info("@@@@@@@@@@@@@@@@@@@@@@ 2222222 " + post.toString());
		return post;
	}
	
	@Override
	public PostVO retrievePostForEdit(int poNo) {
		PostVO post = commuDAO.selectPost(poNo);
		if(post == null)
			throw new RuntimeException(String.format("%d 글번호의 글이 없음.", poNo));
		post.setAttatchList(commuDAO.selectAttatchList(post));
		post.setCommentList(commuDAO.selectCommentList(post));
		log.info("@@@@@@@@@@@@@@@@@@@@@@ 1111111 " + post.getCommentList().toString());
		log.info("@@@@@@@@@@@@@@@@@@@@@@ 2222222 " + post.toString());
		return post;
	}

	@Override
	public List<PostVO> retrievePostList(PagingVO<PostVO> paging) {
		return commuDAO.selectPostList(paging);
	}

	@Override
	public int retrievePostCount(PagingVO<PostVO> paging) {
		return commuDAO.selectTotalRecord(paging);
	}
	
	@Transactional
	@Override
	public ServiceResult modifyPost(PostVO post) {
			ServiceResult result = null;
			int rowcnt = commuDAO.updatePost(post);
			rowcnt += processAttatchList(post);
			processDeleteAttatch(post);
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
			return result;
	}
	
	private int processDeleteAttatch(PostVO post) {
		int[] delAttNos = post.getDelAttNos();
		if(delAttNos==null || delAttNos.length==0) return 0;
		Arrays.sort(delAttNos);
		List<AttatchVO> attatchList = commuDAO.selectAttatchList(post);
		List<String> saveNames = attatchList.stream()
				.filter(attatch->{
					return Arrays.binarySearch(delAttNos, attatch.getAttNo()) >= 0;
				}).map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		int rowcnt = attatchDAO.deleteAttatches(delAttNos);
		
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				ftpUtil.removeFile(savePath, attSavename);
			}
		}
		return rowcnt;
	}
	
	private int processDeleteAttatches(PostVO post) {
		int rowcnt = 0;
		rowcnt = commuDAO.deleteComment(post);

		List<AttatchVO> attatchList = commuDAO.selectAttatchList(post);
		
		if(attatchList==null || attatchList.isEmpty()) return 0;
		List<String> saveNames = attatchList.stream()
				.map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		rowcnt += attatchDAO.deleteAttatch(post.getPoNo());
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				ftpUtil.removeFile(savePath, attSavename);
			}
		}
		return rowcnt;
	}

	@Transactional
	@Override
	public ServiceResult removePost(PostVO post) {
		ServiceResult result = null;
			processDeleteAttatches(post);
			int rowcnt = commuDAO.deletePost(post);
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public AttatchVO retrieveAttatch(int attNo) {
		AttatchVO attatch = attatchDAO.selectAttatch(attNo);
		if(attatch == null)
			throw new RuntimeException("해당 파일 없음.");
		return attatch;
	}

}