package com.example.custom_cake_system.controllers;

import DTOs.UserDTO;
import com.example.custom_cake_system.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import models.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/user") //https:localhost:8081/user/login
@Controller
public class UserController {

    HttpServletRequest request;

    @Autowired
    UserService userService;

    @Autowired
    com.example.custom_cake_system.services.OrderService orderService;

    public UserController(HttpServletRequest request) {
        this.request = request;
    }

    @GetMapping("/login")
    public String login(){
        return "user/login";
    }

    @GetMapping("/signup")
    public String signup(){
        return "user/signup";
    }

    @GetMapping("/profile")
    public String profile(org.springframework.ui.Model model){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || auth.getPrincipal().equals("anonymousUser")) {
            return "redirect:/user/login";
        }
        
        String username = auth.getName();
        UserDTO user = userService.getUserByUsername(username);
        if (user == null) return "redirect:/user/login";

        model.addAttribute("user", user);
        model.addAttribute("orders", orderService.getOrdersByUserId(user.getId()));
        return "user/profile";
    }


    @GetMapping("/order-tracking")
    public String orderTracking(){
        return "user/order-tracking";
    }

    @PostMapping("/perform_signup")
    public String signup(@RequestParam String username,
                         @RequestParam String email,
                         @RequestParam String address,
                         @RequestParam String phone,
                         @RequestParam String password) throws ServletException {

        Response response = userService.registerUser(new UserDTO(0, password,username, false, email, address, phone));
        if(!response.status){
            return "redirect:/user/signup?error=exists";
        }
        request.login(username, password);
        return "redirect:/home";
    }
}
