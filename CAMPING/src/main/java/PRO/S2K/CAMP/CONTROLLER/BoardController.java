package PRO.S2K.CAMP.CONTROLLER;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardController {
	
	// 다운로드가 가능하게 하자
	@RequestMapping(value = "/download")
	public ModelAndView download(@RequestParam HashMap<Object, Object> params, ModelAndView mv) {
		String ofileName = (String) params.get("of");
		String sfileName = (String) params.get("sf");
		mv.setViewName("downlaodView");
		mv.addObject("ofileName",ofileName);
		mv.addObject("sfileName",sfileName);
		return mv;
	}
	
	@RequestMapping(value = "summernote")
	public String summernote() {
		return "summernote";
	}
	
	@RequestMapping(value = "result")
	public String result() {
		return "result";
	}
}
