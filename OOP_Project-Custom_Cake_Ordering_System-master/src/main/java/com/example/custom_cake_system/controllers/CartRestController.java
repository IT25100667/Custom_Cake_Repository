package com.example.custom_cake_system.controllers;

import DTOs.CartItemDTO;
import com.example.custom_cake_system.services.CartService;
import models.Response;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * REST Controller for Shopping Cart operations.
 */
@RestController
@RequestMapping("/api/cart")
public class CartRestController {

    private final CartService cartService;

    public CartRestController(CartService cartService) {
        this.cartService = cartService;
    }

    @GetMapping
    public List<CartItemDTO> getCart() {
        return cartService.getCart();
    }

    @PostMapping("/add")
    public Response addToCart(@RequestParam("productId") int productId, 
                             @RequestParam(value = "quantity", defaultValue = "1") int quantity) {
        return cartService.addToCart(productId, quantity);
    }

    @PutMapping("/update")
    public Response updateQuantity(@RequestParam("itemId") int itemId, 
                                  @RequestParam("quantity") int quantity) {
        return cartService.updateQuantity(itemId, quantity);
    }

    @DeleteMapping("/{itemId}")
    public Response removeFromCart(@PathVariable("itemId") int itemId) {
        return cartService.removeFromCart(itemId);
    }
}
