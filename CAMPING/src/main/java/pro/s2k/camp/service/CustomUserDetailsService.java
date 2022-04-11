package pro.s2k.camp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.extern.slf4j.Slf4j;
import pro.s2k.camp.dao.MemberDAO;
import pro.s2k.camp.vo.CustomUser;
import pro.s2k.camp.vo.MemberVO;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {
	 
   @Autowired
    private MemberDAO memberDAO;
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //시큐리티에서 username은 실제 유저 아이디로 인식
        log.warn("유저정보 로드: "+username);
        MemberVO vo=memberDAO.read(username);
 
        log.warn(vo);
        return vo==null ? null : new CustomUser(vo);
    }
 
}


