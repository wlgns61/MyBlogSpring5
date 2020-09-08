package com.myblog.user.model;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@SuppressWarnings("serial")
public class UserVO implements UserDetails, GrantedAuthority{
	
	String uid;
	String name;
	String pwd;
	String re_pwd;
	String email;
	boolean enabled;
	String reg_dt;
	String authority;
	Collection <? extends GrantedAuthority> authorities;
	
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getName() {
		return name;
	}
	public String getRe_pwd() {
		return re_pwd;
	}
	public void setRe_pwd(String re_pwd) {
		this.re_pwd = re_pwd;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
		this.authorities = authorities;
	}
	
	
	@Override
	public String getAuthority() {
		// TODO Auto-generated method stub
		return authority;
	}
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return pwd;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return uid;
	}
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return enabled;
	}
	
	@Override
	public String toString() {
		return "UserVO [uid=" + uid + ", name=" + name + ", pwd=" + pwd + ", email=" + email + ", enabled=" + enabled
				+ ", reg_dt=" + reg_dt + ", authority=" + authority + ", authorities=" + authorities + "]";
	}
	
}
