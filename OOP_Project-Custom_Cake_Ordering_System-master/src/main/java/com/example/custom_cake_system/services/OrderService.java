package com.example.custom_cake_system.services;

import DTOs.OrderDTO;
import com.example.custom_cake_system.data_access.OrdersRepository;
import models.CheckoutState;
import models.Response;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderService {

    private final OrdersRepository ordersRepository;

    public OrderService(OrdersRepository ordersRepository) {
        this.ordersRepository = ordersRepository;
    }

    public Response placeOrder(CheckoutState state, int customerId) {
        try {
            List<OrderDTO> orders = new ArrayList<>();
            
            state.getCartItems().forEach(item -> {
                OrderDTO order = new OrderDTO();
                order.setCustomerId(customerId);
                order.setProductId(item.getProductId());
                order.setQuantity(item.getQuantity());
                order.setDateOfOrder(LocalDateTime.now());
                order.setOrderStatus("Pending");
                order.setTotalPrice((long)item.getProductPrice() * item.getQuantity());
                
                // Carry over custom details if they exist
                if (item.getCustomDetails() != null) {
                    order.setCustomOrderInfo(item.getCustomDetails());
                }
                
                orders.add(order);
            });


            return ordersRepository.createOrders(orders);
        } catch (Exception e) {
            return new Response(false, "Failed to place order: " + e.getMessage());
        }
    }

    public void updateOrderStatus(int orderId, String status) {
        ordersRepository.updateOrderStatus(orderId, status);
    }

    public List<OrderDTO> getOrdersByUserId(int userId) {
        return ordersRepository.getOrders(userId);
    }

    public Response deleteOrder(int orderId) {
        return ordersRepository.deleteOrder(orderId);
    }

    public List<OrderDTO> getAllOrders() {
        return ordersRepository.getOrdersWithoutCustomOrderDetails();
    }
}
