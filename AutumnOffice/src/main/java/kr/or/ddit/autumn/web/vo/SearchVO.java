package kr.or.ddit.autumn.web.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * 단순 키워드 검색에 활용.
 *
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class SearchVO {
	private String searchType;
	private String searchWord;
	private String searchCommunity;
	private String state;
}