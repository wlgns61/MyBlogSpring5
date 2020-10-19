package com.myblog.config;

import javax.inject.Inject;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import com.myblog.user.service.UserDetailsServiceImpl;

@Configuration
@EnableWebSecurity
@ComponentScan("com.myblog.**")
public class SecurityConfiguration extends WebSecurityConfigurerAdapter{
	
	@Inject
	UserDetailsServiceImpl userDetailsService;
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception { //인증 메니저
		// TODO Auto-generated method stub
		auth.userDetailsService(userDetailsService);
	}
	
	@Override
    protected void configure(HttpSecurity http) throws Exception {
		
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
	    filter.setEncoding("UTF-8");      
	    filter.setForceEncoding(true);
	    
        http
        	.authorizeRequests()
        		.antMatchers("/board/**").authenticated()
        		.antMatchers("/user/getUserList*").hasRole("ADMIN")
        		.antMatchers("/menu/**").hasRole("ADMIN")
        		.and()
            .formLogin()
                .loginPage("/login/loginForm")
                .loginProcessingUrl("/login/doLogin")
                .defaultSuccessUrl("/board/getBoardList")
                .usernameParameter("uid")
                .passwordParameter("pwd")
                .failureUrl("/login/loginForm?error=true")
                .permitAll()
                .and()
            .logout()
            	.logoutUrl("/logout")
            	.invalidateHttpSession(true) //브라우저가 종료되면 로그인했던 정보를 삭제함
            	.logoutSuccessUrl("/login/loginForm")
            	.and()
            .csrf()
            	.ignoringAntMatchers("/logout")
            	.and()
            .addFilterBefore(filter, CsrfFilter.class); //csrf filter이전에 filter를 추가하는 것.
    }
	
}
