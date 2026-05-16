package com.example.custom_cake_system.services;

import DTOs.CustomOrderInfoDTO;
import DTOs.ProductDTO;
import models.CheckoutState;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;
import DTOs.CartItemDTO;

@Service
public class CheckoutService {

    public void initializeCheckout(CheckoutState state, List<CartItemDTO> items) {
        state.setCartItems(items);
        state.calculateTotals();
        state.setCurrentStep(1);
    }

    public void updateShippingInfo(CheckoutState state, String firstName, String lastName, String address1, String address2, String city, String phone, String email) {
        state.setFirstName(firstName);
        state.setLastName(lastName);
        state.setAddress1(address1);
        state.setAddress2(address2);
        state.setCity(city);
        state.setPhone(phone);
        state.setEmail(email);
        state.setCurrentStep(2);
    }

    public void updatePaymentInfo(CheckoutState state, String paymentMethod) {
        state.setPaymentMethod(paymentMethod);
        state.setCurrentStep(3);
    }

    public CheckoutState createCustomCheckout(java.util.Map<String, Object> data) {
        String presetName = (String) data.get("presetName");
        String size = (String) data.get("size");
        String topping = (String) data.get("topping");
        String message = (String) data.get("message");
        Double price = Double.parseDouble(data.get("totalPrice").toString());

        CartItemDTO item = new CartItemDTO();
        item.setProductId(1); // Custom Cake ID
        item.setProductName("Custom Cake: " + presetName);
        item.setProductPrice(price.longValue());
        item.setQuantity(1);
        
        String details = "Preset: " + presetName + " | Size: " + size + " | Toppings: " + topping + " | Msg: " + message;
        item.setCustomDetails(List.of(new CustomOrderInfoDTO(0, 1, 1, details)));

        CheckoutState state = new CheckoutState();
        state.setCartItems(java.util.Collections.singletonList(item));
        state.calculateTotals();
        state.setCurrentStep(1);
        return state;
    }
}
