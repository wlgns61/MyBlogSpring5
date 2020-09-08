package com.myblog.web;

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;

import com.myblog.config.SecurityConfiguration;

public class SecurityInitializer extends AbstractSecurityWebApplicationInitializer {

    public SecurityInitializer() {
        super(SecurityConfiguration.class);
    }
}
