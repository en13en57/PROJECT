package pro.s2k.camp.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import pro.s2k.camp.vo.CampInfoVO;
import pro.s2k.camp.vo.CommonVO;
import pro.s2k.camp.vo.NoticeVO;



public interface CampDAO {
	
	// 일반야영장 불러오기
	List<CampInfoVO> selectCampSitel(HashMap<String, Object> map);
	
	//idx로 불러오기
	CampInfoVO selectCamplInfo(int idx); 
	
	// 자동차야영장 불러오기
	List<CampInfoVO> selectcarCampGround(HashMap<String, Object> map);
	
	//글램핑 불러오기
	List<CampInfoVO> selectGlamping(HashMap<String, Object> map);
	
	//카라반 불러오기
	List<CampInfoVO> selectCaravan(HashMap<String, Object> map);
	
	// 메인에 개수찍기
	int selectCountTotal();
	int selectCountCampsitel();
	int selectCountCar();
	int selectCountGlamping();
	
	int selectCountSite();
	int selectCountGround();
	int selectCountCaravan();

	// 검색기능
	List<CampInfoVO> selectSearchList(HashMap<String, Object> map);
	int selectSearchCount(CommonVO commonVO);
	
}
