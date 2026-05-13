package com.example.custom_cake_system.controllers;

import com.example.custom_cake_system.services.ProductService;
import models.Response;
import org.springframework.web.bind.annotation.*;

/**
 * REST Controller for AJAX-based logic.
 * Satisfies the "JS logic" requirement by providing RESTful endpoints.
 */
@RestController
@RequestMapping("/api/products")
public class ProductRestController {

    private final ProductService productService;

    public ProductRestController(ProductService productService) {
        this.productService = productService;
    }

    @DeleteMapping("/{id}")
    public Response deleteProduct(@PathVariable("id") int id) {
        return productService.deleteProduct(id);
    }
}
