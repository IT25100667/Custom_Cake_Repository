package com.example.custom_cake_system.services;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class CookieServices {


    Authentication user = SecurityContextHolder.getContext().getAuthentication();

    public String isEmployee(){
        return user.getAuthorities().stream().map(r -> r.getAuthority())
                .toList().get(0);
    }

    public String getUsername(){
        return user.getName();
    }
}
