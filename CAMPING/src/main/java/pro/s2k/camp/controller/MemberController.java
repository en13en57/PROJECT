package pro.s2k.camp.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import lombok.extern.slf4j.Slf4j;
import pro.s2k.camp.dao.MemberDAO;
import pro.s2k.camp.service.MemberService;
import pro.s2k.camp.vo.MemberVO;


@Slf4j
@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	// 네이버 ----------------------------------------------------------------------------------
	@RequestMapping(value = "/naverCallback.do", produces = "application/json; charset=UTF8")
	public String naverCallback(HttpServletRequest request,HttpServletResponse httpServletResponse, HttpSession session, Model model) throws IOException {
		
			
			String clientId = "eT2NCIHgedo2uVebssZm";//애플리케이션 클라이언트 아이디값";
		    String clientSecret = "dBx60NTCAZ";//애플리케이션 클라이언트 시크릿값";
		    String code = request.getParameter("code");
		    String state = request.getParameter("state");
		    String redirectURI = URLEncoder.encode("http://localhost:8080/naverCallback.do", "UTF-8");
		    String apiURL;
		    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		    apiURL += "client_id=" + clientId;
		    apiURL += "&client_secret=" + clientSecret;
		    apiURL += "&redirect_uri=" + redirectURI;
		    apiURL += "&code=" + code;
		    apiURL += "&state=" + state;
		    String access_token = "";
		    String refresh_token = "";
		    StringBuffer res = new StringBuffer();
		    try {
		      URL url = new URL(apiURL);
		      HttpURLConnection con = (HttpURLConnection)url.openConnection();
		      con.setRequestMethod("GET");
		      int responseCode = con.getResponseCode();
		      BufferedReader br;
		      log.info("responseCode="+responseCode);
		      if(responseCode==200) { // 정상 호출
		        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		      } else {  // 에러 발생
		        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		      }
		      String inputLine;
		      
		      while ((inputLine = br.readLine()) != null) {
		        res.append(inputLine);
		      }
		      br.close();
		      if(responseCode==200) {
		      
		      }
		    } catch (Exception e) {
		      System.out.println(e);
		}

		// 뷰에서 액세스토큰 세션으로 받아서 json파싱
		JSONParser jsonParser = new JSONParser();
		String token = res.toString();
		Object afterToken = null;
		try {
			afterToken=jsonParser.parse(token);
		}catch (ParseException e) {
			e.printStackTrace();
		}
		JSONObject jsonToken = (JSONObject) afterToken;
		
		// 토큰값 받아서 회원 명세 받아 찍기(회원가입용)
		String nT = (String) jsonToken.get("access_token");
		String responseBody = memberService.naverMemberProfile(nT);
		Object obj = null;
		try {
			obj=jsonParser.parse(responseBody);
		}catch (ParseException e) {
			e.printStackTrace();
		}
		JSONObject jsonObj = (JSONObject) obj;
		JSONObject response = (JSONObject) jsonObj.get("response");
		String socialID = (String) response.get("id");		
 		String socialName = (String) response.get("name");		
		String socialEmail = (String) response.get("email");		
		String socialTel = (String) response.get("mobile");		
		String socialBirth = (String) response.get("birthyear") + "-" +  response.get("birthday");
		int socialNumber = 1;
		
		 MemberVO memberVO = new MemberVO();
	        
	        memberVO.setSocialID(socialID);
	        memberVO.setMb_name(socialName);
	        memberVO.setMb_email(socialEmail);
	        memberVO.setMb_tel(socialTel);
	        memberVO.setMb_birth(socialBirth);
	        memberVO.setSocialNumber(socialNumber);
		
		MemberVO kakaoIdChk = memberService.socialIdChk(socialID);
		
		 if(kakaoIdChk == null) {
	           model.addAttribute("memberVO", memberVO);
	           return "socialInsert";
	        }else {
	           Authentication authentication = new UsernamePasswordAuthenticationToken(memberService.socialIdChk(socialID).getMb_ID(), memberService.socialIdChk(socialID).getMb_password());
	           Object principal = authentication.getPrincipal();
	           String userid = "";
	          if (principal instanceof UserDetails) {
	             userid = ((UserDetails) principal).getUsername();
	          } else {
	             userid = principal.toString();
	          }
	          httpServletResponse.setCharacterEncoding("UTF-8"); 
	          httpServletResponse.setContentType("text/html; charset=UTF-8");
	          PrintWriter out = httpServletResponse.getWriter();
	          MemberVO mvo = memberDAO.selectUserId(userid);
	          if (mvo.getDel() == 0) {
	             // System.out.println(authentication.getPrincipal());
	             // System.out.println(userid);
	             // System.out.println(memberVO);
	             // 얻어온 회원 정보를 세션에 저장하고 홈으로 이동한다.
	             HttpSession httpSession = request.getSession();
	             httpSession.setAttribute("mvo", mvo);
	             redirectStrategy.sendRedirect(request, httpServletResponse, "/main.do");
	             log.info(request+"#############");
	               log.info(httpServletResponse+"#############");
	               log.info(authentication+"#############");
	          } else {
	             out.println("<script language='javascript'>");
	             out.println("alert('탈퇴한 회원입니다.');");
	             out.println("location.href='/main.do';");
	             out.println("</script>");
	             out.close();
	          }
	        }
	        
	        return null;
	   }
	   private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
		// 네이버 ----------------------------------------------------------------------------------
	   
	    // 카카오 ----------------------------------------------------------------------------------
	   @RequestMapping(value = "/kakaoCallback.do", produces = "application/json; charset=UTF8")
	   public String kakaoCallback(@RequestParam String code, HttpServletRequest request,HttpServletResponse httpServletResponse, HttpSession session, Model model) throws IOException {
		   
		   
		   String clientId = "ef83fa2c4e841e935b1971d525cb0e1b";//애플리케이션 클라이언트 아이디값";
		   String clientSecret = "CCHf7unzK3JLDx8648Hpbqux4L7N22gl";
		   String redirectURI = URLEncoder.encode("http://localhost:8080/kakaoCallback.do", "UTF-8");
		   String apiURL;
		   apiURL = "https://kauth.kakao.com/oauth/token?grant_type=authorization_code";
		   apiURL += "&client_id=" + clientId;
		   apiURL += "&client_secret=" + clientSecret;
		   apiURL += "&redirect_uri=" + redirectURI;
		   apiURL += "&code=" + code;
		   log.info(code+"############");
		   String access_token = "";
		   String refresh_token = "";
		   StringBuffer res = new StringBuffer();
		   try {
			   URL url = new URL(apiURL);
			   HttpURLConnection con = (HttpURLConnection)url.openConnection();
			   log.info(con+"url");
			   con.setRequestMethod("GET");
			   int responseCode = con.getResponseCode();
			   BufferedReader br;
			   log.info(responseCode+"!@#");
			   if(responseCode==200) { // 정상 호출
				   br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			   } else {  // 에러 발생
				   br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			   }
			   String inputLine;
			   
			   while ((inputLine = br.readLine()) != null) {
				   res.append(inputLine);
			   }
			   br.close();
			   if(responseCode==200) {
				log.info(res.toString()+"!!!!!!!!!");   
			   }
		   } catch (Exception e) {
			   System.out.println(e);
		   }
		   
		   JSONParser jsonParser = new JSONParser();
		   String token = res.toString();
		   Object afterToken = null;
		   try {
			   afterToken=jsonParser.parse(token);
		   }catch (ParseException e) {
			   e.printStackTrace();
		   }
		   JSONObject jsonToken = (JSONObject) afterToken;
		   log.info(jsonToken+"$$$$$$$$$$3");
		   
		   // 토큰값 받아서 회원 명세 받아 찍기(회원가입용)
		   String kT = (String) jsonToken.get("access_token");
		   log.info(kT+"$$$$$$$$$$2");
		   String responseBody = memberService.kakaoMemberProfile(kT);
		   log.info(responseBody+"$$$$$$$$$$1");
		   Object obj = null;
		   try {
			   obj=jsonParser.parse(responseBody);
		   }catch (ParseException e) {
			   e.printStackTrace();
		   }
		   JSONObject response = (JSONObject) obj;
		   JSONObject response2 = (JSONObject) response.get("properties");
		   JSONObject response3 = (JSONObject) response.get("kakao_account");
		   log.info(response+"$$$$$$$$$$");
		   String socialID = (String) response.get("id").toString();		
		   log.info(socialID+"$$$$$$$$$$");
		   String socialName = (String) response2.get("nickname");		
		   log.info(socialName+"$$$$$$$$$$");
		   String socialEmail = (String) response3.get("email");		
		   log.info(socialEmail+"$$$$$$$$$$");
		   int socialNumber = 2;
		   
		   MemberVO memberVO = new MemberVO();
		   
		   memberVO.setSocialID(socialID);
		   memberVO.setMb_name(socialName);
		   memberVO.setMb_email(socialEmail);
		   memberVO.setSocialNumber(socialNumber);
		   log.info(socialID+"############");
		   log.info(socialNumber+"############");
		   MemberVO naverIdChk = memberService.socialIdChk(socialID);
		   
		   if(naverIdChk == null) {
			   model.addAttribute("memberVO", memberVO);
			   return "socialInsert";
		   }else {
			   Authentication authentication = new UsernamePasswordAuthenticationToken(memberService.socialIdChk(socialID).getMb_ID(), memberService.socialIdChk(socialID).getMb_password());
			   Object principal = authentication.getPrincipal();
			   String userid = "";
			   if (principal instanceof UserDetails) {
				   userid = ((UserDetails) principal).getUsername();
			   } else {
				   userid = principal.toString();
			   }
			   httpServletResponse.setCharacterEncoding("UTF-8"); 
			   httpServletResponse.setContentType("text/html; charset=UTF-8");
			   PrintWriter out = httpServletResponse.getWriter();
			   MemberVO mvo = memberDAO.selectUserId(userid);
			   if (mvo.getDel() == 0) {
				   // System.out.println(authentication.getPrincipal());
				   // System.out.println(userid);
				   // System.out.println(memberVO);
				   // 얻어온 회원 정보를 세션에 저장하고 홈으로 이동한다.
				   HttpSession httpSession = request.getSession();
				   httpSession.setAttribute("mvo", mvo);
				   redirectStrategy.sendRedirect(request, httpServletResponse, "/main.do");
				   log.info(request+"#############");
				   log.info(httpServletResponse+"#############");
				   log.info(authentication+"#############");
			   } else {
				   out.println("<script language='javascript'>");
				   out.println("alert('탈퇴한 회원입니다.');");
				   out.println("location.href='/main.do';");
				   out.println("</script>");
				   out.close();
			   }
		   }
		   
		   return null;
	   }
	    // 카카 ----------------------------------------------------------------------------------
	
	

	   @RequestMapping(value = "/kakao.do", method = RequestMethod.GET)
	   public String kakao() {
		   return "kakaoLogin";
	   }
	   
	@RequestMapping(value = "/insert.do", method = RequestMethod.GET)
	public String insert() {
		return "insert";
	}

	@RequestMapping(value = "/insertOk.do", method = RequestMethod.GET)
	public String insertOk() {
		return "403";
	}

	@RequestMapping(value = "/insertOk.do", method = RequestMethod.POST)
	public String insertOk(MemberVO memberVO, Model model) {
		memberVO.setAuthkey(UUID.randomUUID().toString());
		memberVO.setMb_password(bCryptPasswordEncoder.encode(memberVO.getMb_password()));
		memberService.insert(memberVO);
		model.addAttribute("memberVO", memberVO);

		return "redirect:/main.do";
	}

	// 아이디 체크
	@RequestMapping(value = "/idCheck.do", produces = "text/plain;charset=UTF-8") // UTF-8로 글자 하나 넣겠다.
	@ResponseBody
	public String idCheck(@RequestParam(required = false) String userid) {
		String userids[] = "admin,root,master,webmaster,administrator, ".split(","); // 금지 아이디 목록
		int count = 0;
		for (String id : userids) {
			if (userid.contains(id)) {
				count = 1;
				break;
			}
		}
		if (count == 0) {
			// 서비스를 호출하여 동일한 아이디의 개수를 얻어소 count변수에 넣는다.
			count = memberService.idCheck(userid);
		}
		return count + "";
	}

	// 닉네임 체크
	@RequestMapping(value = "/nickCheck.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String nickCheck(@RequestParam(required = false) String nick) {
		String nicks[] = "admin,root,master,webmaster,administrator, ".split(","); // 금지 아이디 목록
		int count = 0;
		for (String ni : nicks) {
			if (nick.contains(ni)) {
				count = 1;
				break;
			}
		}
		if (count == 0) {
			// 서비스를 호출하여 동일한 닉네임 갯수를 얻어서 count 변수에 넣는다.
			count = memberService.nickCheck(nick);
		}
		return count + "";
	}

	// 로그인 접속 실패시 (성공시는 CustomSuccessHandler)
	@RequestMapping(value = "/login.do")
	public String login(@RequestParam(value = "error", required = false) String error, Model model) {
		if (error != null) {
			model.addAttribute("error", "아이디가 없거나 비번이 일치하지 않습니다.");
		}
		return "login";
	}

	// 이메일 인증시 등급 올리
	@RequestMapping(value = "/confirm.do")
	public String confirm(@RequestParam String mb_ID, @RequestParam String authkey, Model model) {

		MemberVO memberVO = memberService.updateRole(mb_ID, authkey); // grade값을 1로 변경
		model.addAttribute("memberVO", memberVO);
		return "confirm";
	}

	// 아이디찾기 실패시
	@RequestMapping(value = "/userInfo/findUserId.do")
	public String findUserId(@RequestParam(value = "error", required = false) String error, Model model) {
		if (error != null) {
			model.addAttribute("error", "입력하신 정보의 아이디는 존재하지 않습니다.");
		}
		return "/userInfo/findUserId";
	}

	// 아이디 찾기 를 GET으로 받았을때
	@RequestMapping(value = "/userInfo/findUserIdOk.do", method = RequestMethod.GET)
	public String findUserIdOk() {
		return "/userInfo/findUserId";
	}

	// 아이디 찾기 를 POST로 받았을때
	@RequestMapping(value = "/userInfo/findUserIdOk.do", method = RequestMethod.POST)
	public String findUserIdOkPOST(@ModelAttribute MemberVO memberVO, Model model) {
		MemberVO vo = memberService.idSearch(memberVO);
		if (vo == null) {
			// 일치하는 정보가 없다.
			return "redirect:/userInfo/findUserId.do?error";
		} else {
			// 일치하는 정보가 있다.
			model.addAttribute("memberVO", vo);
			return "/userInfo/findUserIdOk";
		}
	}

	// 비밀번호 찾기 실패시
	@RequestMapping(value = "/userInfo/findPassword.do")
	public String findPassword(@RequestParam(value = "error", required = false) String error, Model model) {
		if (error != null) {
			model.addAttribute("error", "입력하신 정보는 존재하지 않습니다.");
		}
		return "/userInfo/findPassword";
	}

	// 비밀번호 찾기 GET으로 받았을때
	@RequestMapping(value = "/userInfo/findPasswordOk.do", method = RequestMethod.GET)
	public String findPasswordOk() {
		return "/userInfo/findPasswordOk";
	}

	@RequestMapping(value = "/userInfo/findPasswordOk.do", method = RequestMethod.POST)
	public String findPasswordOkPOST(@ModelAttribute MemberVO memberVO, Model model) {
		MemberVO vo = memberService.passwordsearch(memberVO);
		if (vo == null) {
			// 일치하는 정보가 없다.
			return "redirect:/userInfo/findPassword.do?error";
		} else {
			// 일치하는 정보가 있다.
			// 임시비밀번호를 만들어서 DB에 저장
			String newPassword = memberService.makePassword(15);
			memberVO.setMb_password(newPassword);
			memberService.updatePassword(memberVO);
			memberService.sendPassword(memberVO);
			// 만들어진 임시 비밀번호 메일로 보낸다.
			return "/userInfo/findPasswordOk";
		}
	}

	@RequestMapping(value = "/memberInfo/memberDelete.do", method = RequestMethod.GET)
	public String memberdelete() {
		return "/memberInfo/memberDelete";
	}

	@RequestMapping(value = "/admin/memberManage.do", method = RequestMethod.GET)
	public String membermanage() {
		return "/admin/memberManage";
	}

	// 회원 탈퇴 폼
	@RequestMapping(value = "/memberInfo/memberDelete.do")
	public String memberdelete(@RequestParam(value = "error", required = false) String error,Model model) {
		if(error!=null) {
			model.addAttribute("error", "입력하신 정보가 일치하지 않습니다.");
		}
		return "/memberInfo/memberDelete";
	}
	
	
	@RequestMapping(value = "/memberDeleteOk.do")
	public String userDeleteOk(@ModelAttribute MemberVO memberVO, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=euc-kr");
		PrintWriter out = response.getWriter();
		MemberVO vo = memberService.selectByUserId(memberVO);
		if (vo == null) {
			out.println("<script>alert('비밀번호를 다시 입력해주세요.'); </script>");
			out.flush();
			return "/memberInfo/memberDelete";
		} else {
			memberService.userDelete(memberVO);
			session.removeAttribute("mvo");
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			if (authentication != null) {
				new SecurityContextLogoutHandler().logout(request, response, authentication);
			}
			out.println("<script>alert('그동안 NG캠핑을 이용해주셔서 감사합니다.'); </script>");
			out.println("<script>location.href='/main.do';</script>");
			out.flush();
			return "/";
		}
	}

	@RequestMapping(value = "/memberInfo/passwordCorrectOk.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String pwdcorrect(@ModelAttribute MemberVO memberVO, @RequestParam String newPassword, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		log.info(newPassword + "######################################");
		memberVO.setMb_password(newPassword);
		result += memberService.updatePassword(memberVO);
		session.removeAttribute("mvo");
		System.out.println(result);
		return result + "";
	}

	@RequestMapping(value = "/memberInfo/passwordCorrect.do", method = RequestMethod.GET)
	public String passwordcorrect() {
		return "/memberInfo/passwordCorrect";
	}

	@RequestMapping(value = "/memberInfo/memberPage.do", method = RequestMethod.POST)
	public String memberPage() {
		return "/memberInfo/memberPage";
	}

	@RequestMapping(value = "/memberInfo/memberpageOk.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String memberPageOk(@ModelAttribute MemberVO memberVO, @RequestParam String mb_nick, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		memberVO.setMb_nick(mb_nick);
		result += memberService.updateNick(memberVO);
		session.removeAttribute("mvo");
		System.out.println(result);
		return result + "";
	}
}
