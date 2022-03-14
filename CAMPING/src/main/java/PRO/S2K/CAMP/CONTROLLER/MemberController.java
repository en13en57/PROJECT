package PRO.S2K.CAMP.CONTROLLER;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController {
	
	@RequestMapping(value = "/insert.do", method = RequestMethod.GET)
	public String insert() {
		return "insert";
	}

	@RequestMapping(value = "/idCheck", produces = "text/plain;charset=UTF-8" ) // UTF-8로 글자 하나 넣겠다.
	@ResponseBody
	public String idCheck(@RequestParam(required = false) String ID) {
		String userids="admin,root,master,webmaster,administrator";
		int count = 0;
		if(userids.contains(ID)) {
			count = 1;
		}else {
			// 서비스를 호출하여 동일한 아이디의 개수를 얻어 count변수에 넣는다.
		}
		return count + "";
	}

}
 