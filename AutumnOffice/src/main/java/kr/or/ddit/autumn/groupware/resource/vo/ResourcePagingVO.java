package kr.or.ddit.autumn.groupware.resource.vo;

import java.util.List;

import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ResourcePagingVO<T> {

	public ResourcePagingVO(int screenSize, int blockSize) {
			super();
			this.screenSize = screenSize;
			this.blockSize = blockSize;
		}

	private int totalRecord;
	private int currentPage;
	private int screenSize = 10;
	private int blockSize = 5;
	private int totalPage;

	private int startRow;
	private int endRow;
	private int startPage;
	private int endPage;

	private String comCode;
	private String depId;
	private String powRole;
	private int surNo;
	private int surqueNo;
	private String empId;

	private SearchVO simpleCondition;
	// domain이 무엇이냐에 따라서 검색 조건이 달라지는 것을 의미하는 것이 T의 의미
	private T detailCondition;

	private List<T> dataList;

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public void setPowRole(String powRole) {
		this.powRole = powRole;
	}

	public void setDepId(String depId) {
		this.depId = depId;
	}

	public void setComcode(String comCode) {
		this.comCode = comCode;
	}

	public void setDetailCondition(T detailCondition) {
		this.detailCondition = detailCondition;
	}

	public void setSimpleCondition(SearchVO simpleCondition) {
		this.simpleCondition = simpleCondition;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		totalPage = (totalRecord + (screenSize - 1)) / screenSize;
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

		endPage = endPage > totalPage ? totalPage : endPage;

		if (startPage > blockSize) {
			html.append(String.format(PATTERN, startPage - blockSize, "&laquo;"));
		}

		for (int page = startPage; page <= endPage; page++) {
			if (page == currentPage) {
				html.append(page);
			} else {
				html.append(String.format(PATTERN, page, page));
			}
		}

		if (endPage < totalPage) {
			html.append(String.format(PATTERN, endPage + 1, "&raquo;"));
		}

		return html.toString();
	}

	private static final String BSPATTERN = "<li class='page-item %s'>"
			+ "<a class='page-link' href='#' data-page='%d'>%s</a>" + "</li>";

	public String getPagingHTML() {
		StringBuffer html = new StringBuffer();
		html.append(" <nav aria-label='Page navigation example'>        ");
		html.append("   <ul class='pagination pagination-sm pg-primary justify-content-center'>  ");
		// previous
		if (startPage > blockSize) {
			html.append(String.format(BSPATTERN, "", 1, "&laquo;"));
		}

		boolean disabled = startPage <= 1;
		html.append(
				String.format(BSPATTERN, disabled ? "disabled" : "", disabled ? 1 : startPage - blockSize, "&laquo;"));
		// page link
		endPage = endPage > totalPage ? totalPage : endPage;
		for (int page = startPage; page <= endPage; page++) {
			boolean active = page == currentPage;
			html.append(String.format(BSPATTERN, active ? "active" : "", page, page));
		}
		// next
		disabled = endPage >= totalPage;
		html.append(
				String.format(BSPATTERN, disabled ? "disabled" : "", disabled ? totalPage : endPage + 1, "&raquo;"));
		// to end
		if (totalPage > blockSize && totalPage > endPage) {
			html.append(String.format(BSPATTERN, "", totalPage, ">>"));
		}

		html.append("   </ul>                                           ");
		html.append(" </nav>                                            ");
		return html.toString();
	}
}
