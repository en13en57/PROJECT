package pro.s2k.camp.service;

import java.util.HashMap;

import pro.s2k.camp.vo.MemberVO;
import pro.s2k.camp.vo.PagingVO;

public interface MemberService {
// 1. 로그인
	MemberVO loginOk(MemberVO memberVO);
// 2. 로그아웃
	MemberVO logout (MemberVO memberVO);	
// 3. 회원가입
	void insert(MemberVO memberVO);
// 4. 회원정보수정
	MemberVO update(MemberVO memberVO);
// 5. 회원 삭제
	void delete(MemberVO memberVO);
// 5-1 회원 탈퇴
	void userDelete(MemberVO memberVO);
// 5. 비번 변경
	int updatePassword(MemberVO memberVO);
// 7. 인증 완료
	MemberVO updateRole(String mb_ID, String authkey);
// 8. 아이디 중복확인
	int idCheck(String mb_ID);
// 9. 닉네임 중복확인
   int nickCheck(String mb_nick);
// 10. 아이디 찾기
	MemberVO idSearch(MemberVO memberVO);
// 11. 비번 찾기
	MemberVO passwordsearch(MemberVO memberVO);
// 12. 임시비번 만들기
	String makePassword(int length);
// 13. id와 비번이 같은것 가져오기
	MemberVO selectByUserId(MemberVO memberVO);
// 14. 메일로 임시비밀번호 보내기
	void sendPassword(MemberVO memberVO);
// 15. 닉네임 수정
	int updateNick(MemberVO memberVO);
	
	PagingVO<MemberVO> selectList();
	
	MemberVO selectByIdx(int mb_idx);
	
	String naverMemberProfile(String nT);
	String kakaoMemberProfile(String kT);
	// 소셜로그인시 회원가입 여부 판단
	MemberVO socialIdChk(String socialID);
	
/*
// 15. accessToken 얻기	
	String getAccessToken(String code);
// 16. 사용자 정보 가져오기
	KakaoVO getUserInfo(String access_Token);
*/
}
