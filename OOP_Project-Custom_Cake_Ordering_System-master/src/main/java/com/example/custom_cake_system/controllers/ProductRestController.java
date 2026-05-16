package com.example.custom_cake_system.controllers;

import DTOs.CustomCakeModifierDTO;
import DTOs.ProductDTO;
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
@RequestMapping("/api/products")
public class ProductRestController {

    private final ProductService productService;
    private final ProductsRepository productsRepository;

    public ProductRestController(ProductService productService, ProductsRepository productsRepository) {
        this.productService = productService;
        this.productsRepository = productsRepository;
    }

    @DeleteMapping("/{id}")
    public Response deleteProduct(@PathVariable("id") int id) {
        return productService.deleteProduct(id);
    }

    @PostMapping("/fetch-custom-cakes")
    public List<ProductDTO> fetchCustomCakes()
    {
        return productsRepository.getAllCustomCakes();
    }

    @PostMapping("/fetch-custom-modifiers")
    public List<CustomCakeModifierDTO> fetchCustomModifiers(){
        return productsRepository.getAllCustomCakesModifiers();
    }


}
