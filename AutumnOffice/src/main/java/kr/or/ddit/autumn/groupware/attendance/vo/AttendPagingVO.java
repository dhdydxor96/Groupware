package kr.or.ddit.autumn.groupware.attendance.vo;

import java.util.List;

import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class AttendPagingVO<T> {

	public AttendPagingVO(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}

	private int totalRecord;
	private int currentPage;
	private int screenSize=5;
	private int blockSize=5;
	private int totalPage;
	private String depId;
	private String comCode;
	
	private int startRow;
	private int endRow;
	private int startPage;
	private int endPage;
	private String empId;
	private String powRole;
	
	private PeriodSearchVO simpleCondition;
	private SearchVO simpleCondition1;
	// domain이 무엇이냐에 따라서 검색 조건이 달라지는 것을 의미하는 것이 T의 의미
	private T detailCondition;
	
	private List<T> dataList;
	
	public void setPowRole(String powRole) {
		this.powRole = powRole;
	}
	
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	
	public void setComCode(String comCode) {
		this.comCode = comCode;
	}
	
	public void setDepId(String depId) {
		this.depId = depId;
	}
	
	public void setDetailCondition(T detailCondition) {
		this.detailCondition = detailCondition;
	}
	
	public void setSimpleCondition1(SearchVO simpleCondition1) {
		this.simpleCondition1 = simpleCondition1;
	}
	
	public void setSimpleCondition(PeriodSearchVO simpleCondition) {
		this.simpleCondition = simpleCondition;
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		totalPage = (totalRecord+(screenSize-1)) / screenSize;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		endRow = currentPage * screenSize;
		startRow = endRow - (screenSize - 1);
		endPage = blockSize * ((currentPage + (blockSize - 1)) / blockSize);
		startPage = endPage - (blockSize - 1);
	}
	
	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}
	
	private static final String PATTERN = "<a href='#' data-page='%d'>%s</a>";
	public String getPagingHTML_Simple() {
		StringBuffer html = new StringBuffer();
		
		endPage = endPage > totalPage ?  totalPage : endPage;
		
		if(startPage > blockSize) {
			html.append(
				String.format(PATTERN, startPage-blockSize, "이전")	
			);
		}
		
		for(int page = startPage; page <= endPage; page++) {
			if(page == currentPage) {
				html.append(page);
			}else {
				html.append(
					String.format(PATTERN, page, page)
				);
			}
		}
		
		if(endPage < totalPage) {
			html.append(
				String.format(PATTERN, endPage+1, "다음")	
			);
		}
		
		return html.toString();
	}
	
//	<nav aria-label="Page navigation example">
//	  <ul class="pagination justify-content-center">
//	    <li class="page-item disabled">
//	      <a class="page-link">Previous</a>
//	    </li>
//	    <li class="page-item"><a class="page-link" href="#">1</a></li>
//	    <li class="page-item active"><a class="page-link" href="#">2</a></li>
//	    <li class="page-item"><a class="page-link" href="#">3</a></li>
//	    <li class="page-item">
//	      <a class="page-link" href="#">Next</a>
//	    </li>
//	  </ul>
//	</nav>
	
	private static final String BSPATTERN = "<li class='page-item %s'>" +
			"<a class='page-link' href='#' data-page='%d'>%s</a>" +
			"</li>";
	
	public String getPagingHTML() {
		StringBuffer html = new StringBuffer();
		html.append(" <nav aria-label='Page navigation example'>        ");
		html.append("   <ul class='pagination pagination-sm  justify-content-center'>  ");
		// previous
		if(startPage > blockSize) {
			html.append(
				String.format(
					BSPATTERN 
					, ""
					, 1
					, "<<"		
				)	
			);
		}
		
		boolean disabled = startPage <= 1;
		html.append(
			String.format(
				BSPATTERN 
				, disabled?"disabled":""
				, disabled?1:startPage-blockSize
				, "이전"		
			)	
		);
		// page link
		endPage = endPage > totalPage ?  totalPage : endPage;
		for(int page = startPage; page <= endPage; page++) {
			boolean active = page == currentPage;
			html.append(
				String.format(
					BSPATTERN 
					, active?"active":""
					, page
					, page		
				)	
			);
		}
		// next
		disabled = endPage >= totalPage;
		html.append(
			String.format(
				BSPATTERN 
				, disabled?"disabled":""
				, disabled?totalPage:endPage+1
				, "다음"		
			)	
		);
		// to end
		if(totalPage > blockSize && totalPage > endPage ) {
			html.append(
				String.format(
					BSPATTERN 
					, ""
					, totalPage
					, ">>"		
				)	
			);
		}

		html.append("   </ul>                                           ");
		html.append(" </nav>                                            ");
		return html.toString();
	}
	
}
