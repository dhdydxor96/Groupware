package kr.or.ddit.autumn.groupware.archive.vo;

import lombok.Data;

@Data
public class DirStructJsonVO implements Comparable<DirStructJsonVO>{
	private String text;
	private boolean isDir;
	@Override
	public int compareTo(DirStructJsonVO o) {
		int a = this.isDir == true ? 1:0;
		int b = o.isDir == true ? 1:0;
		return b - a;
	}
}
