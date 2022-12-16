package kr.or.ddit.autumn.groupware.mail.service;

import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.groupware.mail.dao.MailAttatchDAO;
import kr.or.ddit.autumn.groupware.mail.dao.SendMailDAO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.SendMailVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Service
public class SendMailServiceImpl implements SendMailService {

	@Inject
	private SendMailDAO dao;
	@Inject
	private MailAttatchDAO attatchDAO;
	
	
	@Inject
	private FtpUtil ftpUtil; 
	   
	@Value("#{ftpInfo.savePath}")
	private String savePath;
	
//	@Value("#{appInfo.attatchFolder}") //Properties 읽는 어노테이션
//	private Resource attatchFolder; //업로드된 파일이 저장될 폴더
	
//	private File saveFolder;
	
//	@PostConstruct   //@PostConstruct가 붙은 메서드는 클래스가 service(로직을 탈 때? 로 생각 됨)를 수행하기 전에 발생한다. 이 메서드는 다른 리소스에서 호출되지 않는다해도 수행된다. 
//	public void init() throws IOException {
//		saveFolder = attatchFolder.getFile();
//	}
	
	private int processAttatchList(SendMailVO sendMailVO) {
		int rowcnt = 0;
		List<AttatchVO> attatchList = sendMailVO.getAttatchList();
		if(attatchList!=null && !attatchList.isEmpty()) {
			// 메타데이터 저장
			rowcnt = attatchDAO.insertAttatches(sendMailVO);
			// 2진 데이터 저장
			
			for(AttatchVO attatch : attatchList) { 
//					attatch.saveTo(saveFolder); //원래 로직 
				ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee()); //ftp용
			}
		}
		return rowcnt;
	}
	
	private int processDeleteAttatches(SendMailVO sendMailVO) {
		List<AttatchVO> attatchList = dao.selectSendMail(sendMailVO.getMailNo()).getAttatchList();
		if(attatchList==null || attatchList.isEmpty()) return 0;
		boolean bool = false;
		for(AttatchVO attach:attatchList) {
			if(attach.getAttNo()==null) {
				bool = true;
			}
		}
		if(bool) return 0;
		
		List<String> saveNames = attatchList.stream()
					.map(attatch->{
						return attatch.getAttSnm();
					}).collect(Collectors.toList());
		int rowcnt = 0;
		// 메타데이터 삭제
		rowcnt = attatchDAO.deleteAttatches(sendMailVO.getMailNo());
		// 2진 데이터 삭제
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
//				File deleteFile = new File(saveFolder, attSavename);
//				FileUtils.deleteQuietly(deleteFile);
				ftpUtil.removeFile(savePath,attSavename);
			}
		}
		return rowcnt;
	}
	
	
	@Override
	public SendMailVO retrieveSendMail(Integer mailNo) {
		SendMailVO sendMailVO = dao.selectSendMail(mailNo);
		if(sendMailVO==null)
			throw new RuntimeException(String.format("%d 번호의 메일이 없음.", mailNo));
		
		return sendMailVO;
	}

	@Override
	public List<SendMailVO> retrieveSendMailList(PagingVO<SendMailVO> pagingVO) {
		return dao.selectSendMailList(pagingVO);
	}
	
	@Override
	public List<SendMailVO> noPageRetrieveSendMailList(String empId) {
		return dao.noPageSelectSendMailList(empId);
	}

	@Override
	public ServiceResult createSendMailVO(String[] toMails,SendMailVO sendMailVO) {
		int rowcnt =0;
		String address = Arrays.toString(toMails);
		if(toMails.length==1) {
			address = address.substring(1, Arrays.toString(toMails).length()-1);
		}
		sendMailVO.setToAddress(address);
		rowcnt += dao.insertSendMailVO(sendMailVO);
		
		rowcnt += processAttatchList(sendMailVO);
		
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeSendMailVO(SendMailVO sendMailVO) {
		ServiceResult result = null;
		
			processDeleteAttatches(sendMailVO);
			int rowcnt = dao.deleteSendMailVO(sendMailVO.getMailNo());
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	
		return result;
	}
	
	
	//보낸 메일함 카운트
	@Override
	public int retrieveSendMailCount(PagingVO<SendMailVO> pagingVO) {
		return dao.selectTotalRecord(pagingVO);
	}

	//파일 가져오기
	@Override
	public AttatchVO retrieveAttatch(int attNo) {
		AttatchVO attatch = attatchDAO.selectAttatch(attNo);
		if(attatch == null)
			throw new RuntimeException("해당 파일 없음.");
		return attatch;
	}



}
