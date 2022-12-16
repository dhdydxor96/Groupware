package kr.or.ddit.autumn.groupware.approval.vo;

import java.util.List;

import kr.or.ddit.autumn.vo.AppFormVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import lombok.Data;

@Data
public class AppFormSelectElementsVO {
	private List<AppFormVO> appFormList;
	private List<DepartmentVO> departmentList;
}
