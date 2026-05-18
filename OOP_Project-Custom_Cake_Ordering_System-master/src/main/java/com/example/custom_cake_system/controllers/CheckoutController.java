package com.example.custom_cake_system.controllers;

import DTOs.CartItemDTO;
import DTOs.ProductDTO;

import DTOs.UserDTO;
import com.example.custom_cake_system.services.CheckoutService;
import com.example.custom_cake_system.services.OrderService;
import com.example.custom_cake_system.services.UserService;
import com.example.custom_cake_system.services.CartService;
import com.example.custom_cake_system.utlity.AuthenticationHandler;
import jakarta.servlet.http.HttpSession;
import models.CheckoutState;
import models.Response;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/checkout")
public class CheckoutController {

    private final CheckoutService checkoutService;
    private final OrderService orderService;
    private final UserService userService;
    private final CartService cartService;
    private final AuthenticationHandler authenticationHandler;

    public CheckoutController(CheckoutService checkoutService, OrderService orderService, UserService userService, CartService cartService, AuthenticationHandler authenticationHandler) {
        this.checkoutService = checkoutService;
        this.orderService = orderService;
        this.userService = userService;
        this.cartService = cartService;
        this.authenticationHandler = authenticationHandler;
    }

    @PostMapping("/init")
    @ResponseBody
    public Response initCheckout(@RequestBody List<CartItemDTO> items, HttpSession session) {
        CheckoutState state = new CheckoutState();
        Response response = cartService.checkIfCartItemsAreValid(authenticationHandler.getCurrentUserId());
        if(!response.status){
            return response;
        }
        checkoutService.initializeCheckout(state, items);
        session.setAttribute("checkoutState", state);
        return new Response(true, "Checkout initialized");
    }

    @PostMapping("/init-custom")
    @ResponseBody
    public Response initCustomCheckout(@RequestBody java.util.Map<String, Object> orderData, HttpSession session) {
        try {
            CheckoutState state = checkoutService.createCustomCheckout(orderData);
            session.setAttribute("checkoutState", state);
            return new Response(true, "Checkout initialized");
        } catch (Exception e) {
            return new Response(false, "Initialization failed: " + e.getMessage());
        }
    }


    @GetMapping
    public String showCheckout(HttpSession session, Model model) {
        CheckoutState state = (CheckoutState) session.getAttribute("checkoutState");
        if (state == null) {
            return "redirect:/cart";
        }
        model.addAttribute("state", state);
        return "home/checkout";
    }

    @PostMapping("/step1")
    public String processStep1(
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String address1,
            @RequestParam(required = false) String address2,
            @RequestParam String city,
            @RequestParam String phone,
            @RequestParam String email,
            HttpSession session) {
        
        CheckoutState state = (CheckoutState) session.getAttribute("checkoutState");
        if (state != null) {
            checkoutService.updateShippingInfo(state, firstName, lastName, address1, address2, city, phone, email);
        }
        return "redirect:/checkout";
    }

    @PostMapping("/step2")
    public String processStep2(@RequestParam String paymentMethod, HttpSession session) {
        CheckoutState state = (CheckoutState) session.getAttribute("checkoutState");
        if (state != null) {
            checkoutService.updatePaymentInfo(state, paymentMethod);
        }
        return "redirect:/checkout";
    }

    @PostMapping("/place")
    public String placeOrder(HttpSession session, Model model, jakarta.servlet.http.HttpServletRequest request) {
        CheckoutState state = (CheckoutState) session.getAttribute("checkoutState");
        if (state == null) return "redirect:/cart";

        int customerId = 1; // Default
        org.springframework.security.core.Authentication auth = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !auth.getPrincipal().equals("anonymousUser")) {
            String username = auth.getName();
            UserDTO user = userService.getUserByUsername(username);
            if (user != null) {
                customerId = user.getId();
            }
        }

        
        Response response = orderService.placeOrder(state, customerId);
        
        if (response.status) {
            cartService.clearCart();
            session.removeAttribute("checkoutState");
            return "redirect:/order-confirmation?orderId=ORD-" + response.message;
        } else {
            model.addAttribute("error", response.message);
            model.addAttribute("state", state);
            return "home/checkout";
        }
    }

    @GetMapping("/back")
    public String goBack(HttpSession session) {
        CheckoutState state = (CheckoutState) session.getAttribute("checkoutState");
        if (state != null && state.getCurrentStep() > 1) {
            state.setCurrentStep(state.getCurrentStep() - 1);
        }
        return "redirect:/checkout";
    }
}
