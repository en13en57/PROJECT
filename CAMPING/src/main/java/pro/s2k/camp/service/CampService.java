package pro.s2k.camp.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import pro.s2k.camp.vo.CampInfoVO;
import pro.s2k.camp.vo.CommonVO;
import pro.s2k.camp.vo.NoticeVO;
import pro.s2k.camp.vo.PagingVO;

public interface CampService {
		
		PagingVO<CampInfoVO> selectCampSitel(CommonVO commonVO);
		
		// 자동차야영장 불러오기
		PagingVO<CampInfoVO> selectcarCampGround(CommonVO commonVO);
	
		
		//글램핑 불러오기
		PagingVO<CampInfoVO> selectGlamping(CommonVO commonVO);
		
		//카라반 불러오기
		PagingVO<CampInfoVO> selectCaravan(CommonVO commonVO);
		
		// 정보 조회
		CampInfoVO selectCamplInfo(String facltNm);
		
		PagingVO<CampInfoVO> selectSearchList(CommonVO commVO);
		
		PagingVO<CampInfoVO> selectRandom(CommonVO commonVO);
	
}
