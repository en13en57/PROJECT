package PRO.S2K.CAMP.CONTROLLER;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import PRO.S2K.CAMP.SERVICE.MemberService;


@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;

	
	@RequestMapping(value = "/insert.do", method = RequestMethod.GET)
	public String insert() {
		return "insert";
	}

	@RequestMapping(value = "/idCheck", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String idCheck(@RequestParam(required = false) String userid) {
		String userids[] = "admin,root,master,webmaster,administrator".split(","); // 금지 아이디 목록
		int count = 0;
		for(String id : userids) { 
			if(userid.equals(id)) {
				count=1;
				break;
			}
		}
		if(count==0) {
			// 서비스를 호출하여 동일한 아이디의 개수를 얻어소 count변수에 넣는다.
			count = memberService.idCheck(userid);
		}
		return count + "";
	}

}
 