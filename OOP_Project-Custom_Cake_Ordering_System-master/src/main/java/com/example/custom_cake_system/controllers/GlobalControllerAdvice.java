package com.example.custom_cake_system.controllers;

import com.example.custom_cake_system.services.ProductService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    private final ProductService productService;

    public GlobalControllerAdvice(ProductService productService) {
        this.productService = productService;
    }

    @ModelAttribute
    public void addAttributes(Model model) {
        model.addAttribute("categories", productService.getAvailableCategories());
    }
}
