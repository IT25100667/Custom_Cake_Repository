package com.example.custom_cake_system.controllers;
import com.example.custom_cake_system.data_access.ProductsRepository;
import DTOs.ProductDTO;
import DTOs.UserDTO;
import com.example.custom_cake_system.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;

@RequestMapping("/products")
@Controller
public class ProductsController {


    private ProductsRepository productsRepository;
    private UserService userService;
    private com.example.custom_cake_system.data_access.OrdersRepository ordersRepository;

    public ProductsController(ProductsRepository productsRepository, UserService userService, com.example.custom_cake_system.data_access.OrdersRepository ordersRepository) {
        this.productsRepository = productsRepository;
        this.userService = userService;
        this.ordersRepository = ordersRepository;
    }

    @GetMapping({"", "/"})
    public String index(){
        return "redirect:/search";
    }

    @GetMapping("/details")
    public String getProductDetails(@org.springframework.web.bind.annotation.RequestParam("id") int id, Model model){
        ProductDTO product = productsRepository.getProductById(id);
        
        if (product == null) {
            return "redirect:/search";
        }
        
        model.addAttribute("product", product);
        return "products/product-details";
    }

    @GetMapping("/custom-cakes")
    public String getCustomCakes(){
        return "products/custom-cakes";
    }
}
