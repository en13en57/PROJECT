package pro.s2k.camp.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import pro.s2k.camp.vo.CampInfoVO;
import pro.s2k.camp.vo.CommonVO;
import pro.s2k.camp.vo.NoticeVO;



public interface CampDAO {
	
	// 일반야영장 불러오기
	List<Map<String, Object>> selectCampsitel();
	//idx로 불러오기
	Map<String, Object> selectCamplInfo(int idx); // 생각을 좀만 더 해봐
	// 자동차야영장 불러오기
	List<Map<String, Object>> selectcarCampground();
	//글램핑 불러오기
	List<Map<String, Object>> selectGlamping();
	//카라반 불러오기
	List<Map<String, Object>> selectCaravan();
	
	// 메인에 개수찍기
	int selectCountTotal();
	int selectCountCampsitel();
	int selectCountCar();
	int selectCountGlamping();

	// 검색기능
	List<CampInfoVO> selectSearchList(HashMap<String, Object> map);
	int selectSearchCount(CommonVO commonVO);
	
}
