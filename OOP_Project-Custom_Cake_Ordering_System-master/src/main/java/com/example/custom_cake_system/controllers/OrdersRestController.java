package com.example.custom_cake_system.controllers;

import DTOs.CustomCakeModifierDTO;
import DTOs.CustomCakeOrderRequestDTO;
import DTOs.ProductDTO;
import com.example.custom_cake_system.data_access.OrdersRepository;
import com.example.custom_cake_system.data_access.ProductsRepository;
import com.example.custom_cake_system.services.ProductService;
import models.Response;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * REST Controller for AJAX-based logic.
 * Satisfies the "JS logic" requirement by providing RESTful endpoints.
 */
@RestController
@RequestMapping("/api/orders")
public class OrdersRestController {

    private final OrdersRepository ordersRepository;

    public OrdersRestController(OrdersRepository ordersRepository) {
        this.ordersRepository = ordersRepository;
    }


    @PostMapping("/place-custom-order")
    public Response placeOrder(@RequestBody CustomCakeOrderRequestDTO request)
    {
        return ordersRepository.createCustomOrder(request);
    }
}
