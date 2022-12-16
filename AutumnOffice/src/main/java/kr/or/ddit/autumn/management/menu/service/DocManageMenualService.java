package kr.or.ddit.autumn.management.menu.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.RuleVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface DocManageMenualService {
	
	public ServiceResult createRule(RuleVO rule);
	public RuleVO retrieveRule(int rulNo);
	public List<RuleVO> retrieveRuleList(PagingVO<RuleVO> PagingVO);
	public int retrieveRuleCount(PagingVO<RuleVO> pagingVO);
	public int modifyRule(RuleVO rule);
	public ServiceResult removeRule(RuleVO rule);
	public AttatchVO retrieveAttatch(int attNo);
	
}
