package com.example.custom_cake_system.utlity;

import DTOs.UserDTO;
import com.example.custom_cake_system.data_access.UsersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Component
public class AuthenticationHandler {

    @Autowired
    UsersRepository usersRepository;

    public String getCurrentUsername(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return auth.getName();
    }

    public int getCurrentUserId(){
        return usersRepository.getUserByUsername(getCurrentUsername()).id;
    }

    public UserDTO getUserDetails(){
        return usersRepository.getUserDetails(getCurrentUsername(), false);
    }
}
