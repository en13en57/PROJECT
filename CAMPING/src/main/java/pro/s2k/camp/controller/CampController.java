package pro.s2k.camp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String campsite() {
		return "/camp/campsite";
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
	public String selectinfo(@RequestParam("var") int idx ,Model model) {	    
		Map<String, Object> result = new HashMap<String, Object>();
		result = campService.selectCamplInfo(idx);
		//					보낼이름			, null 값이고 아무거나
		//addAttribute(String attributeName, @Nullable Object attributeValue) 이 형태로 작성해야한다고요.
		model.addAttribute("result",result);
		return "/camp/detailPage";
	}

	@RequestMapping(value ={"/camp/selectCampsitel.do"}, method = RequestMethod.POST) 
	@ResponseBody
	public List<Map<String, Object>> selectCampsitel() {
		List<Map<String, Object>> result = new ArrayList<>();  //ArrayList : 상위 리스트
		result = campService.selectCampsitel();
		return result;
	}
	
	@RequestMapping(value ={"/camp/selectcarCampground.do"}, method = RequestMethod.POST) 
	@ResponseBody
	public List<Map<String, Object>> selectcarCampground() {
		List<Map<String, Object>> result = new ArrayList<>();  //ArrayList : 상위 리스트
		result = campService.selectcarCampground();
		return result;	
	}
	
	@RequestMapping(value ={"/camp/selectGlamping.do"}, method = RequestMethod.POST) 
	@ResponseBody
	public List<Map<String, Object>> selectGlamping() {
		List<Map<String, Object>> result = new ArrayList<>();  //ArrayList : 상위 리스트
		result = campService.selectGlamping();
		return result;	
	}
	
	@RequestMapping(value ={"/camp/selectCaravan.do"}, method = RequestMethod.POST) 
	@ResponseBody
	public List<Map<String, Object>> selectCaravan() {
		List<Map<String, Object>> result = new ArrayList<>();  //ArrayList : 상위 리스트
		result = campService.selectCaravan();
		return result;	
	}
	
	@RequestMapping(value = "/selectSearchCamp.do")
	public String selectSearchNotice (@RequestParam String searchType, @RequestParam String searchType2,
			@RequestParam String searchText, HttpServletRequest request, @ModelAttribute CommonVO commVO, Model model) {
		log.info("searchType"+searchType);
		PagingVO<CampInfoVO> pv = campService.selectSearchList(commVO);
		pv.setSearchText(searchText);
		pv.setSearchType(searchType);
		pv.setSearchType2(searchType2);
		String animalCheck = request.getParameter("animalCheck");
		log.info("!!!!!!!!"+animalCheck);
		pv.setAnimalCheck(animalCheck);
		log.info(pv.getAnimalCheck()+"#######");
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);

		return "/camp/campsite";
	}
	
	
}