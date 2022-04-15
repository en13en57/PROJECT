package pro.s2k.camp.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import pro.s2k.camp.vo.CampInfoVO;
import pro.s2k.camp.vo.CommonVO;
import pro.s2k.camp.vo.NoticeVO;
import pro.s2k.camp.vo.PagingVO;

public interface CampService {
	
		// 일반야영장 불러오기
		List<Map<String, Object>> selectCampsitel();
		// 자동차야영장 불러오기
		Map<String, Object> selectCamplInfo(int idx);
		// 자동차야영장 불러오기
		List<Map<String, Object>> selectcarCampground();
		//글램핑 불러오기
		List<Map<String, Object>> selectGlamping();
		//카라반 불러오기
		List<Map<String, Object>> selectCaravan();
		
		PagingVO<CampInfoVO> selectSearchList(CommonVO commVO);
		
	
}
