package pro.s2k.camp.vo;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

@Data
public class CustomUser extends User {
	
	private static final long serialVersionUID = 1L;
	
	private MemberVO memberVO;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO memberVO) {
		super(memberVO.getMb_ID(), memberVO.getMb_password(),
				memberVO.getau
				)
		
	}
	
}
