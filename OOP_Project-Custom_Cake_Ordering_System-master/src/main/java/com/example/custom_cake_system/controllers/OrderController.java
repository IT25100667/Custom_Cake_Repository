package com.example.custom_cake_system.controllers;
import com.example.custom_cake_system.services.OrderService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/order")
@Controller
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping("/updateOrderStatus")
    public void updateOrderStatus(@RequestParam int orderId, @RequestParam String orderStatus){
        orderService.updateOrderStatus(orderId, orderStatus);
    }
}
