package com.kjnresort.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.kjnresort.domain.MemberVO;

import lombok.Getter;
import lombok.extern.log4j.Log4j;

@Getter
public class CustomUser extends User {
	private MemberVO mvo;

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO mvo) {
		
		super(mvo.getId(), mvo.getPw(), mvo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.mvo = mvo;
		
	}
	
	

}
