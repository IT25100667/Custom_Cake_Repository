package com.example.custom_cake_system.services;

import DTOs.CartItemDTO;
import DTOs.UserDTO;
import com.example.custom_cake_system.data_access.CartRepository;
import com.example.custom_cake_system.data_access.UsersRepository;
import models.Response;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Service for Cart business logic.
 */
@Service
public class CartService {

    private final CartRepository cartRepository;
    private final UsersRepository usersRepository;

    public CartService(CartRepository cartRepository, UsersRepository usersRepository) {
        this.cartRepository = cartRepository;
        this.usersRepository = usersRepository;
    }

    private int getCurrentUserId() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        UserDTO user = usersRepository.getUserDetails(username, false);
        return user != null ? user.id : -1;
    }

    public List<CartItemDTO> getCart() {
        int userId = getCurrentUserId();
        if (userId == -1) return new ArrayList<>();
        return cartRepository.getCartItems(userId);
    }

    public Response addToCart(int productId, int quantity) {
        int userId = getCurrentUserId();
        if (userId == -1) return new Response(false, "User not logged in");
        return cartRepository.addItem(userId, productId, quantity);
    }

    public Response updateQuantity(int itemId, int quantity) {
        return cartRepository.updateQuantity(itemId, quantity);
    }

    public Response removeFromCart(int itemId) {
        return cartRepository.removeItem(itemId);
    }

    public void clearCart() {
        int userId = getCurrentUserId();
        if (userId != -1) {
            cartRepository.clearCart(userId);
        }
    }

    public Response checkIfCartItemsAreValid(int userId){
        return cartRepository.checkIfCartItemsAreValid(userId);
    }
}
