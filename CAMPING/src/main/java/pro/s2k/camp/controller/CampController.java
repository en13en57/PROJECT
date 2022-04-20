package pro.s2k.camp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import pro.s2k.camp.dao.CampDAO;
import pro.s2k.camp.service.CampService;
import pro.s2k.camp.vo.CampInfoVO;
import pro.s2k.camp.vo.CommonVO;
import pro.s2k.camp.vo.NoticeVO;
import pro.s2k.camp.vo.PagingVO;



@Slf4j
@Controller
public class CampController {

	
	@Autowired
	private CampService campService;
	
	
	@RequestMapping(value ={"/camp/campsite.do"}, method = RequestMethod.GET)
	public String campsite(@CookieValue(name="lat", required=false) Double lat,@CookieValue(name="lon", required=false) Double lon, 
			@ModelAttribute CommonVO commonVO, HttpServletRequest request,HttpSession session, Model model) {
	  commonVO.setLon(lon);
	  commonVO.setLat(lat);
      PagingVO<CampInfoVO> pv = campService.selectCampSitel(commonVO);
      model.addAttribute("pv", pv);
      model.addAttribute("cv", commonVO); 
      return "/camp/campsite";
   }
	@RequestMapping(value = "/selectSearchCamp.do", produces = "application/json; charset=UTF8")
	public String selectSearchCamp (@CookieValue(name="lat", required=false) Double lat,@CookieValue(name="lon", required=false) Double lon,
			@RequestParam String searchType, @RequestParam String searchType2,
			@RequestParam String searchText, HttpServletRequest request, HttpSession session, @ModelAttribute CommonVO commVO, Model model) throws JsonProcessingException, ParseException {
		commVO.setLon(lon);
		commVO.setLat(lat);
		log.info("!!!!!!2222"+searchType);
		String animalCheck = request.getParameter("animalCheck");
		session.setAttribute("searchType", searchType);
		session.setAttribute("searchType2", searchType2);
		session.setAttribute("searchText", searchText);
		session.setAttribute("animalCheck", animalCheck);
		PagingVO<CampInfoVO> pv = campService.selectSearchList(commVO);
		pv.setSearchText(searchText);
		pv.setSearchType(searchType);
		pv.setSearchType2(searchType2);
		pv.setAnimalCheck(animalCheck);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		return "/camp/campsite";
	}
	
	
	@RequestMapping(value ={"/camp/selectCampSitel.do"}, method = RequestMethod.POST)
	@ResponseBody
	public String selectCampsitel(@CookieValue(name="lat", required=false) Double lat,@CookieValue(name="lon", required=false) Double lon,
			@RequestHeader(value = "p", required = false)int p,
			@ModelAttribute CommonVO commonVO, HttpServletRequest request, Model model,HttpSession session) throws Exception  {
		String searchType = (String) session.getAttribute("searchType");
		String searchType2 = (String) session.getAttribute("searchType2");
		String searchText = (String) session.getAttribute("searchText");
		String animalCheck = (String) session.getAttribute("animalCheck");
			commonVO.setSearchType(searchType);
			commonVO.setSearchType2(searchType2);
			commonVO.setSearchText(searchText);
			commonVO.setAnimalCheck(animalCheck);
			commonVO.setLon(lon);
			commonVO.setLat(lat);
			commonVO.setP(p);
		log.info("%%%%%"+p);
		log.info("%%%%%"+searchType);
		if(searchType!=null) {
			if(!searchType.equals("-선택-")) {
				PagingVO<CampInfoVO> pv = campService.selectSearchList(commonVO);
				log.info("#####@@@@@"+pv);
				pv.setSearchType(searchType);
				pv.setSearchType2(searchType2);
				pv.setSearchText(searchText);
				pv.setAnimalCheck(animalCheck);
				ObjectMapper mapper = new ObjectMapper();
				String jsonParse = mapper.writeValueAsString(pv);
				JSONParser jsonParser = new JSONParser();
				Object objectJson = null;
				objectJson = jsonParser.parse(jsonParse);
				JSONObject jsonList = (JSONObject) objectJson;
				String list = (String)(jsonList.get("list")+"");
				log.info("#####@@@@@2"+list);
				session.removeAttribute("searchType");
				return list;
				}else {
					PagingVO<CampInfoVO> pv = campService.selectSearchList(commonVO);
					pv.setSearchText(searchText);
					pv.setAnimalCheck(animalCheck);
					ObjectMapper mapper = new ObjectMapper();
					String jsonParse = mapper.writeValueAsString(pv);
					JSONParser jsonParser = new JSONParser();
					Object objectJson = null; 
					objectJson = jsonParser.parse(jsonParse);
					JSONObject jsonList = (JSONObject)objectJson;
					String list = (String)(jsonList.get("list")+"");
					log.info("!!!!!!!!!!!!!!!!1");
					session.removeAttribute("searchType");
					return list;
				}
		}else {
			PagingVO<CampInfoVO> pv = campService.selectCampSitel(commonVO);
			ObjectMapper mapper = new ObjectMapper();
			String jsonParse = mapper.writeValueAsString(pv);
			JSONParser jsonParser = new JSONParser();
			Object objectJson = null; 
			objectJson = jsonParser.parse(jsonParse);
			JSONObject jsonList = (JSONObject)objectJson;
			String list = (String)(jsonList.get("list")+"");
			log.info("!!!!!!!!!!!!!!!!2");
			session.removeAttribute("searchType");
			return list;
		}
	}
	
	@RequestMapping(value ={"/camp/caravan.do"}, method = RequestMethod.GET)
	public String caravan() {
		return "/camp/caravan";
	}
	@RequestMapping(value ={"/camp/carCampground.do"}, method = RequestMethod.GET)
	public String carCampground() {
		return "/camp/carCampground";
	}
	@RequestMapping(value ={"/camp/glamping.do"}, method = RequestMethod.GET)
	public String glamping() {
		return "/camp/glamping";
	}
	
	@RequestMapping(value={"/camp/detailPage.do"}, method = RequestMethod.POST)
	public String selectinfo(@RequestParam("var") String facltNm ,Model model) {	    
		CampInfoVO pv = campService.selectCamplInfo(facltNm);
		//					보낼이름			, null 값이고 아무거나
		//addAttribute(String attributeName, @Nullable Object attributeValue) 이 형태로 작성해야한다고요.
		model.addAttribute("result",pv);
		return "/camp/detailPage";
	}

//	@RequestMapping(value ={"/camp/selectCampsitel.do"}, method = RequestMethod.POST) 
//	@ResponseBody
//	public PagingVO<CampInfoVO> selectCampsitel(@RequestParam String searchType, @RequestParam String searchType2,
//			@RequestParam String searchText, HttpServletRequest request,CommonVO commVO) {
//		PagingVO<CampInfoVO> pv = campService.selectSearchList(commVO); //ArrayList : 상위 리스트
//		pv.setSearchText(searchText);
//		pv.setSearchType(searchType);
//		pv.setSearchType2(searchType2);
//		String animalCheck = request.getParameter("animalCheck");
//		pv.setAnimalCheck(animalCheck);
//		return pv;
//	}
	
//	@RequestMapping(value ={"/camp/selectCampsitel.do"}, method = RequestMethod.POST) 
//	@ResponseBody
//	public List<Map<String, Object>> selectCampsitel() {
//		List<Map<String, Object>> result = new ArrayList<>();  //ArrayList : 상위 리스트
//		result = campService.selectCampsitel();
//		log.info("##############"+result);
//		return result;	
//	}
//	
//	@RequestMapping(value ={"/camp/selectcarCampground.do"}, method = RequestMethod.POST) 
//	@ResponseBody
//	public List<Map<String, Object>> selectcarCampground() {
//		List<Map<String, Object>> result = new ArrayList<>();  //ArrayList : 상위 리스트
//		result = campService.selectcarCampground();
//		return result;	
//	}
//	
//	@RequestMapping(value ={"/camp/selectGlamping.do"}, method = RequestMethod.POST) 
//	@ResponseBody
//	public List<Map<String, Object>> selectGlamping() {
//		List<Map<String, Object>> result = new ArrayList<>();  //ArrayList : 상위 리스트
//		result = campService.selectGlamping();
//		return result;	
//	}
//	
//	@RequestMapping(value ={"/camp/selectCaravan.do"}, method = RequestMethod.POST) 
//	@ResponseBody
//	public List<Map<String, Object>> selectCaravan() {
//		List<Map<String, Object>> result = new ArrayList<>();  //ArrayList : 상위 리스트
//		result = campService.selectCaravan();
//		return result;	
//	}
	
	
	
}